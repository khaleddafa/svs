<?php

namespace App\Http\Controllers\user;

use App\Http\Requests\CoinSwapRequest;
use App\Http\Requests\WalletCreateRequest;
use App\Http\Requests\withDrawRequest;
use App\Http\Services\CommonService;
use App\Http\Services\TransactionService;
use App\Jobs\Withdrawal;
use App\Model\Coin;
use App\Model\CoWalletWithdrawApproval;
use App\Model\DepositeTransaction;
use App\Model\TempWithdraw;
use App\Model\Wallet;
use App\Model\WalletAddressHistory;
use App\Model\WalletCoUser;
use App\Model\WalletSwapHistory;
use App\Model\WithdrawHistory;
use App\Repository\WalletRepository;
use App\Services\BitCoinApiService;
use App\Services\CoinPaymentsAPI;
use App\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\View;
use Illuminate\Support\Str;
use SimpleSoftwareIO\QrCode\Facades\QrCode;
use PragmaRX\Google2FA\Google2FA;


class WalletController extends Controller
{
    public $repo;

    public function __construct()
    {
        $this->repo = new WalletRepository();
    }

    // my pocket
    public function myPocket(Request $request)
    {
        $data['tab'] = $request->tab ?? null;
        $data['wallets'] = Wallet::join('coins', 'coins.id', '=', 'wallets.coin_id')
            ->where(['wallets.user_id'=> Auth::id(), 'wallets.type'=> PERSONAL_WALLET, 'coins.status' => STATUS_ACTIVE])
            ->orderBy('id', 'ASC')
            ->select('wallets.*')
            ->get();
        $data['coWallets'] = Wallet::select('wallets.*')
            ->join('wallet_co_users', 'wallet_co_users.wallet_id','=','wallets.id')
            ->join('coins', 'coins.id', '=', 'wallets.coin_id')
            ->where(['wallets.type'=> CO_WALLET, 'wallet_co_users.user_id'=>Auth::id(), 'coins.status' => STATUS_ACTIVE])
            ->orderBy('id', 'ASC')->get();
        $data['coins'] = Coin::where('status', STATUS_ACTIVE)->get();
        $data['title'] = __('My Pocket');

        return response()->json($data);
//        return view('user.pocket.index', $data);
    }

    public function getCoinSwapDetails(Request $request)
    {
        if ($request->ajax()) {
            $wallet = Wallet::find($request->id);
            $data['wallets'] = Coin::select('coins.*', 'wallets.name as wallet_name', 'wallets.id as wallet_id')
                ->join('wallets', 'wallets.coin_type', '=', 'coins.type')
                ->where('coins.status', STATUS_ACTIVE)
                ->where('wallets.user_id', Auth::id())
                ->where('coins.type', '!=', $wallet->coin_type)
                ->where('coins.type', '<>', DEFAULT_COIN_TYPE)
                ->get();

            return response()->json($data);
        }
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     * get rate of coin
     */
    public function getRate(CoinSwapRequest $request)
    {
        $data = $this->repo->get_wallet_rate($request);

        return response()->json($data);
    }

    public function swapCoin(CoinSwapRequest $request)
    {
        $fromWallet = Wallet::where(['id' => $request->from_coin_id])->first();
        if (!empty($fromWallet) && $fromWallet->type == CO_WALLET) {
            return response()->json(['status' => 'error', 'message' => __('Something went wrong')]);
        }

        $response = $this->repo->get_wallet_rate($request);
        if ($response['success'] == false) {
            return response()->json(['status' => 'error', 'message' => __('Something went wrong')]);
        }

        $swap_coin = $this->repo->coinSwap($response['from_wallet'], $response['to_wallet'], $response['convert_rate'], $response['amount'], $response['rate']);

        if ($swap_coin['success'] == true) {
            return response()->json(['status' => 'success', 'message' => $swap_coin['message']]);
        } else {
            return response()->json(['status' => 'error', 'message' => $swap_coin['message']]);
        }
    }

    // make default account
    public function makeDefaultAccount($account_id, $coin_type)
    {
        $wallet = Wallet::where(['id' => $account_id])->first();
        if (!empty($wallet) && $wallet->type == CO_WALLET) {
            return response()->json(['status' => 'error', 'message' => __('Something went wrong')]);
        }

        Wallet::where(['user_id' => Auth::id(), 'coin_type' => $coin_type])->update(['is_primary' => 0]);
        Wallet::updateOrCreate(['id' => $account_id], ['is_primary' => 1]);

        return response()->json(['status' => 'success', 'message' => __('Default set successfully')]);
    }

    public function createWallet(WalletCreateRequest $request)
    {
        if (!empty($request->wallet_name)) {
            $request->type = $request->type ?? PERSONAL_WALLET;
            $coin = Coin::where(['type' => strtoupper($request->coin_type)])->first();
            $alreadyWallet = Wallet::where(['coin_id' => $coin->id, 'user_id' => Auth::id(), 'type' => $request->type])->first();
            if ($alreadyWallet) {
                return response()->json(['status' => 'error', 'message' => __("You already have this type of wallet")]);
            }
            try {
                DB::beginTransaction();
                $wallet = new Wallet();
                $wallet->user_id = Auth::id();
                $wallet->type = $request->type ?? PERSONAL_WALLET;
                $wallet->name = $request->wallet_name;
                $wallet->coin_type = strtoupper($request->coin_type);
                $wallet->status = STATUS_SUCCESS;
                $wallet->balance = 0;
                $wallet->coin_id = $coin->id;
                if (co_wallet_feature_active() && $request->type == CO_WALLET) {
                    $key = Str::random(64);
                    while (true) {
                        $keyExists = Wallet::where(['key' => $key])->first();
                        if (!empty($keyExists)) $key = Str::random(64);
                        else break;
                    }
                    $wallet->key = $key;
                }
                $wallet->save();

                if (co_wallet_feature_active() && $request->type == CO_WALLET) {
                    WalletCoUser::create([
                        'user_id' => Auth::id(),
                        'wallet_id' => $wallet->id
                    ]);
                }
                DB::commit();
                $redirectRoute = co_wallet_feature_active() && $request->type == CO_WALLET ? 'myPocket' : 'back';
                return response()->json([
                    'status' => 'success',
                    'message' => __("Pocket created successfully"),
                    'redirect' => route($redirectRoute, ['tab' => 'co-pocket'])
                ]);
            } catch (\Exception $e) {
                Log::alert($e->getMessage());
                DB::rollBack();
                return response()->json(['status' => 'error', 'message' => __("Something went wrong.")]);
            }
        }
        return response()->json(['status' => 'error', 'message' => __("Pocket name can't be empty")]);
    }

    // create new wallet
    public function importWallet(Request $request)
    {
        if (!empty($request->key)) {
            $wallet = Wallet::where(['key' => $request->key, 'status' => STATUS_ACTIVE])->first();
            if (empty($wallet)) {
                return response()->json(['status' => 'error', 'message' => __('Invalid Key')]);
            }

            $alreadyCoUser = WalletCoUser::where(['user_id' => Auth::id(), 'wallet_id' => $wallet->id])->first();
            if (!empty($alreadyCoUser)) {
                return response()->json(['status' => 'error', 'message' => __('Already imported')]);
            }

            $maxCoUser = settings(MAX_CO_WALLET_USER_SLUG);
            $maxCoUser = !empty($maxCoUser) ? $maxCoUser : 2;
            $coUserCount = WalletCoUser::where(['wallet_id' => $wallet->id])->count();
            if ($coUserCount >= $maxCoUser) {
                return response()->json(['status' => 'error', 'message' => __("Can't import this pocket. Max co user limit reached.")]);
            }

            try {
                WalletCoUser::create([
                    'user_id' => Auth::id(),
                    'wallet_id' => $wallet->id
                ]);
            } catch (\Exception $e) {
                Log::alert($e->getMessage());
                return response()->json(['status' => 'error', 'message' => __("Something went wrong.")]);
            }

            return response()->json([
                'status' => 'success',
                'message' => __("Co Pocket imported successfully"),
                'redirect' => route('myPocket', ['tab' => 'co-pocket'])
            ]);
        }

        return response()->json(['status' => 'error', 'message' => __("Key can't be empty")]);
    }

    public function walletDetails(Request $request, $id)
    {
        $data['wallet_id'] = $id;
        $data['wallet'] = Wallet::join('coins', 'coins.id', '=', 'wallets.coin_id')
            ->where(['wallets.user_id' => Auth::id(), 'coins.status' => STATUS_ACTIVE, 'wallets.id' => $id])
            ->select('wallets.*', 'coins.status as coin_status', 'coins.is_withdrawal', 'coins.minimum_withdrawal',
                'coins.maximum_withdrawal', 'coins.withdrawal_fees')
            ->first();

        // Checking if co-wallet
        if (co_wallet_feature_active() && empty($data['wallet'])) {
            $data['wallet'] = Wallet::select('wallets.*')
                ->join('wallet_co_users', 'wallet_co_users.wallet_id', '=', 'wallets.id')
                ->join('coins', 'coins.id', '=', 'wallets.coin_id')
                ->where(['wallets.id' => $id, 'wallets.type' => CO_WALLET, 'wallet_co_users.user_id' => Auth::id(), 'coins.status' => STATUS_ACTIVE])
                ->first();

            $data['ac_tab'] = $request->has('ac_tab') ? $request->ac_tab : null;
        }

        if (empty($data['wallet'])) {
            return response()->json(['status' => 'error', 'message' => __('Wallet not found')]);
        }

        if (co_wallet_feature_active()) {
            $data['tempWithdraws'] = TempWithdraw::where(['wallet_id' => $id, 'status' => STATUS_PENDING])->orderBy('id', 'desc')->get();
        }

        $exists = WalletAddressHistory::where('wallet_id', $id)->orderBy('created_at', 'desc')->first();
        $data['histories'] = DepositeTransaction::where('receiver_wallet_id', $id)->orderBy('id', 'desc')->get();
        $data['withdraws'] = WithdrawHistory::where('wallet_id', $id)->orderBy('id', 'desc')->get();
        $data['active'] = $request->q;
        $data['ac_tab'] = $request->q;
        $data['title'] = $request->q;
        $wallet = Wallet::find($id);

        if ($wallet->coin_type == DEFAULT_COIN_TYPE) {
            $repo = new WalletRepository();
            $repo->generateTokenAddress($data['wallet']->id);
            $data['wallet_address'] = WalletAddressHistory::where('wallet_id', $id)->orderBy('created_at', 'desc')->first();

            return response()->json([
                'status' => 'success',
                'data' => $data,
                'view' => 'default_wallet_details'
            ]);
        }

        $data['address'] = (!empty($exists)) ? $exists->address : get_coin_payment_address($data['wallet']->coin_type);
        if (!empty($data['address'])) {
            if (empty($exists)) {
                $history = new \App\Services\wallet();
                $history->AddWalletAddressHistory($id, $data['address'], $data['wallet']->coin_type);
            }
            $data['address_histories'] = WalletAddressHistory::where('wallet_id', $id)->paginate(10);

            return response()->json([
                'status' => 'success',
                'data' => $data,
                'view' => 'wallet_details'
            ]);
        }

        return response()->json(['status' => 'error', 'message' => __('Wallet address not found.')]);
    }

    // generate new wallet address
    public function generateNewAddress(Request $request)
    {
        try {
            $walletService = new \App\Services\wallet();
            $myWallet = Wallet::where(['id' => $request->wallet_id, 'user_id' => Auth::id()])->first();

            if ($myWallet) {
                if ($myWallet->coin_type == DEFAULT_COIN_TYPE) {
                    $repo = new WalletRepository();
                    $response = $repo->generateTokenAddress($myWallet->id);

                    if ($response['success'] == true) {
                        return response()->json(['status' => 'success', 'message' => $response['message']]);
                    } else {
                        return response()->json(['status' => 'error', 'message' => $response['message']]);
                    }
                } else {
                    $address = get_coin_payment_address($myWallet->coin_type);
                    if (!empty($address)) {
                        $walletService->AddWalletAddressHistory($request->wallet_id, $address, $myWallet->coin_type);
                        return response()->json(['status' => 'success', 'message' => __('Address generated successfully')]);
                    } else {
                        return response()->json(['status' => 'error', 'message' => __('Address not generated')]);
                    }
                }
            } else {
                return response()->json(['status' => 'error', 'message' => __('Wallet not found')]);
            }

        } catch (\Exception $e) {
            return response()->json(['status' => 'error', 'message' => $e->getMessage()]);
        }
    }


    // generate qr code
    public function qrCodeGenerate(Request $request)
    {
        $image = QRCode::text($request->address)->png();
        return response($image)->header('Content-type', 'image/png');
    }

    // withdraw balance
    public function WithdrawBalance(withDrawRequest $request)
    {
        $transactionService = new TransactionService();

        $wallet = Wallet::join('coins', 'coins.id', '=', 'wallets.coin_id')
            ->where(['wallets.id' => $request->wallet_id, 'wallets.user_id' => Auth::id()])
            ->select('wallets.*', 'coins.status as coin_status', 'coins.is_withdrawal', 'coins.minimum_withdrawal',
                'coins.maximum_withdrawal', 'coins.withdrawal_fees')
            ->first();

        // Checking if co-wallet
        if (co_wallet_feature_active() && empty($wallet)) {
            $wallet = Wallet::join('wallet_co_users', 'wallet_co_users.wallet_id', '=', 'wallets.id')
                ->join('coins', 'coins.id', '=', 'wallets.coin_id')
                ->select('wallets.*', 'coins.status as coin_status', 'coins.is_withdrawal', 'coins.minimum_withdrawal',
                    'coins.maximum_withdrawal', 'coins.withdrawal_fees')
                ->where(['wallets.id' => $request->wallet_id, 'wallets.type' => CO_WALLET, 'wallet_co_users.user_id' => Auth::id()])
                ->first();
        }

        $address = $request->address;
        $user = Auth::user();

        if ($request->ajax()) {
            if (empty($wallet)) {
                return response()->json(['success' => false, 'message' => __('Pocket not found.')]);
            }

            if ($wallet->balance >= $request->amount) {
                $checkValidate = $transactionService->checkWithdrawalValidation($request, $user, $wallet);

                if ($checkValidate['success'] == false) {
                    return response()->json(['success' => false, 'message' => $checkValidate['message']]);
                }

                $checkKyc = $transactionService->kycValidationCheck($user->id);

                if ($checkKyc['success'] == false) {
                    return response()->json(['success' => false, 'message' => $checkKyc['message']]);
                }

                return response()->json(['success' => true]);

            } else {
                return response()->json(['success' => false, 'message' => __('Wallet has no enough balance')]);
            }

        } else {
            if (empty($wallet)) {
                return response()->json(['status' => 'error', 'message' => __('Pocket not found.')]);
            }

            $checkValidate = $transactionService->checkWithdrawalValidation($request, $user, $wallet);

            if ($checkValidate['success'] == false) {
                return response()->json(['status' => 'error', 'message' => $checkValidate['message']]);
            }

            $checkKyc = $transactionService->kycValidationCheck($user->id);
            if ($checkKyc['success'] == false) {
                return response()->json(['status' => 'error', 'message' => $checkKyc['message']]);
            }

            $google2fa = new Google2FA();
            if (empty($request->code)) {
                return response()->json(['status' => 'error', 'message' => __('Verify code is required')]);
            }

            $valid = $google2fa->verifyKey($user->google2fa_secret, $request->code);

            if ($valid) {
                if ($wallet->balance >= $request->amount) {
                    try {
                        if ($wallet->type == PERSONAL_WALLET) {
                            dispatch(new Withdrawal($request->all()))->onQueue('withdrawal');
                            return response()->json(['status' => 'success', 'message' => __('Withdrawal placed successfully')]);
                        } else if (co_wallet_feature_active() && $wallet->type == CO_WALLET) {
                            DB::beginTransaction();
                            $tempWithdraw = TempWithdraw::create([
                                'user_id' => $user->id,
                                'wallet_id' => $wallet->id,
                                'amount' => $request->amount,
                                'address' => $request->address,
                                'message' => $request->message
                            ]);

                            CoWalletWithdrawApproval::create([
                                'temp_withdraw_id' => $tempWithdraw->id,
                                'wallet_id' => $wallet->id,
                                'user_id' => $user->id
                            ]);
                            DB::commit();

                            if ($transactionService->isAllApprovalDoneForCoWalletWithdraw($tempWithdraw)['success']) {
                                dispatch(new Withdrawal($tempWithdraw->toArray()))->onQueue('withdrawal');
                                return response()->json(['status' => 'success', 'message' => __('Withdrawal placed successfully')]);
                            }

                            return response()->json(['status' => 'success', 'message' => __('Process successful. Need other co users approval.')]);
                        } else {
                            return response()->json(['status' => 'error', 'message' => __('Invalid Pocket type.')]);
                        }

                    } catch (\Exception $e) {
                        DB::rollBack();
                        Log::error($e->getMessage());
                        return response()->json(['status' => 'error', 'message' => __('Something went wrong.')]);
                    }
                } else {
                    return response()->json(['status' => 'error', 'message' => __('Wallet has no enough balance')]);
                }
            } else {
                return response()->json(['status' => 'error', 'message' => __('Google two factor authentication is invalid')]);
            }
        }
    }

    //check internal address
    private function isInternalAddress($address)
    {
        $data = WalletAddressHistory::where('address', $address)->with('wallet')->first();
        return response()->json(['data' => $data]);

    }

    // transaction history
    public function transactionHistories(Request $request)
    {
        $tr = new TransactionService();

        $histories = [];
        if ($request->type == 'deposit') {
            $histories = $tr->depositTransactionHistories(Auth::id())->get();
        } else if ($request->type == 'withdrawal') {
            $histories = $tr->withdrawTransactionHistories(Auth::id())->get();
        }

        $formattedHistories = $histories->map(function ($item) use ($request) {
            return [
                'address' => $item->address,
                'amount' => $item->amount,
                'hashKey' => $request->type == 'deposit' ? $item->transaction_id : $item->transaction_hash,
                'status' => statusAction($item->status)
            ];
        });

        return response()->json(['data' => $formattedHistories]);

    }

    // withdraw rate
    public function withdrawCoinRate(Request $request)
    {
        $data['amount'] = isset($request->amount) ? $request->amount : 0;
        $wallet = Wallet::find($request->wallet_id);
        $data['coin_type'] = $wallet->coin_type;

        $data['coin_price'] = bcmul(settings('coin_price'), $request->amount, 8);
        $coinpayment = new CoinPaymentsAPI();
        $api_rate = $coinpayment->GetRates('');

        $data['btc_dlr'] = converts_currency($data['coin_price'], $data['coin_type'], $api_rate);
        $data['btc_dlr'] = custom_number_format($data['btc_dlr']);

        return response()->json(['data' => $data]);
    }

    // coin swap history
    public function coinSwapHistory(Request $request)
    {
        $list = WalletSwapHistory::where(['user_id' => Auth::id()])->get();

        $formattedList = $list->map(function ($item) {
            return [
                'from_wallet_name' => $item->fromWallet->name,
                'to_wallet_name' => $item->toWallet->name,
                'requested_amount' => $item->requested_amount . ' ' . check_default_coin_type($item->from_coin_type),
                'converted_amount' => $item->converted_amount . ' ' . check_default_coin_type($item->to_coin_type),
            ];
        });

        return response()->json(['data' => $formattedList]);

    }


    // coin swap
    public function coinSwap()
    {
        $data['title'] = __('Coin Swap');
        $data['wallets'] = Wallet::where(['user_id' => Auth::id()])->where('coin_type', '<>', DEFAULT_COIN_TYPE)->get();
        return response()->json(['data' => $data]);

//        return view('user.pocket.coin_swap', $data);
    }


    //co wallet users
    public function coWalletUsers(Request $request) {
        $data['title'] = __('Co Pocket Users');
        $data['wallet'] = Wallet::select('wallets.*')
            ->join('wallet_co_users', 'wallet_co_users.wallet_id','=','wallets.id')
            ->where(['wallets.id'=>$request->id, 'wallets.type'=> CO_WALLET, 'wallet_co_users.user_id'=>Auth::id()])
            ->first();
        if(empty($data['wallet'])) return back();

        $data['co_users'] = $data['wallet']->co_users;
        return response()->json(['data' => $data]);

//        return view('user.pocket.co_users', $data);
    }

    //co wallet withdraw approval list
    public function coWalletApprovals(Request $request) {
        $data['title'] = __('Withdraw Approvals');
        $data['tempWithdraw'] = TempWithdraw::where(['status'=>STATUS_PENDING, 'id'=>$request->id])->first();
        if(empty($data['tempWithdraw'])) return redirect()->route('myPocket', ['tab'=>'co-pocket']);
        $response = (new TransactionService())->approvalCounts($data['tempWithdraw']);
        $data['total_required_approval'] = $response['requiredUserApprovalCount'];
        $data['approved_count'] = $response['alreadyApprovedUserCount'];
        $data['wallet'] = Wallet::select('wallets.*')
            ->join('wallet_co_users', 'wallet_co_users.wallet_id','=','wallets.id')
            ->where(['wallets.id'=>$data['tempWithdraw']->wallet_id, 'wallets.type'=> CO_WALLET, 'wallet_co_users.user_id'=>Auth::id()])
            ->first();
        if(empty($data['wallet'])) return redirect()->route('myPocket', ['tab'=>'co-pocket']);

        $data['co_users'] = WalletCoUser::select(DB::raw('wallet_co_users.*,
                            (CASE WHEN wallet_co_users.user_id=co_wallet_withdraw_approvals.user_id THEN '
            .STATUS_ACCEPTED.' ELSE '.STATUS_PENDING.' END) approved'))
            ->leftJoin('co_wallet_withdraw_approvals', function ($join) use ($data) {
                $join->on('wallet_co_users.wallet_id', '=', 'co_wallet_withdraw_approvals.wallet_id')
                    ->on('wallet_co_users.user_id', '=', 'co_wallet_withdraw_approvals.user_id')
                    ->on('co_wallet_withdraw_approvals.temp_withdraw_id','=', DB::raw($data['tempWithdraw']->id));
            })
            ->where('wallet_co_users.wallet_id', $data['wallet']->id)
            ->get();
        return response()->json(['data' => $data]);

//        return view('user.pocket.co_approvals', $data);
    }

    //approve co wallet withdraw
    public function approveCoWalletWithdraw(Request $request)
    {
        $tempWithdraw = TempWithdraw::where(['status' => STATUS_PENDING, 'id' => $request->id])->first();

        if (empty($tempWithdraw)) {
            return response()->json(['success' => false, 'message' => __('Invalid withdrawal.')]);
        }

        $userAlreadyApproved = CoWalletWithdrawApproval::where(['temp_withdraw_id' => $tempWithdraw->id, 'user_id' => Auth::id()])->first();
        if (!empty($userAlreadyApproved)) {
            return response()->json(['success' => false, 'message' => __('You already approved.')]);
        }

        $wallet = Wallet::join('wallet_co_users', 'wallet_co_users.wallet_id', '=', 'wallets.id')
            ->where(['wallets.id' => $tempWithdraw->wallet_id, 'wallets.type' => CO_WALLET, 'wallet_co_users.user_id' => Auth::id()])
            ->first();

        if (empty($wallet)) {
            return response()->json(['success' => false, 'message' => __('Invalid pocket.')]);
        }

        try {
            CoWalletWithdrawApproval::create([
                'temp_withdraw_id' => $tempWithdraw->id,
                'wallet_id' => $wallet->id,
                'user_id' => Auth::id()
            ]);

            $transactionService = new TransactionService();
            if ($transactionService->isAllApprovalDoneForCoWalletWithdraw($tempWithdraw)['success']) {
                dispatch(new Withdrawal($tempWithdraw->toArray()))->onQueue('withdrawal');
                return response()->json(['success' => true, 'message' => __('All approval done and withdrawal placed successfully.')]);
            } else {
                return response()->json(['success' => true, 'message' => __('Approved successfully.')]);
            }
        } catch (\Exception $e) {
            Log::error($e->getMessage());
            return response()->json(['success' => false, 'message' => __('Something went wrong.')]);
        }
    }


    //reject co wallet withdraw by withdraw requester
    public function rejectCoWalletWithdraw(Request $request)
    {
        $tempWithdraw = TempWithdraw::where([
            'status' => STATUS_PENDING,
            'id' => $request->id,
            'user_id' => Auth::id()
        ])->first();

        if (empty($tempWithdraw)) {
            return response()->json(['success' => false, 'message' => __('Invalid withdrawal.')]);
        }

        try {
            $tempWithdraw->status = STATUS_REJECTED;
            $tempWithdraw->save();
            return response()->json(['success' => true, 'message' => __('Withdraw rejected successfully.')]);
        } catch (\Exception $e) {
            Log::error($e->getMessage());
            return response()->json(['success' => false, 'message' => __('Something went wrong.')]);
        }
    }



}
