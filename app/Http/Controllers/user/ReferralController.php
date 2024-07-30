<?php
namespace App\Http\Controllers\user;

use App\Model\AffiliationCode;
use App\Model\AffiliationHistory;
use App\Repository\AffiliateRepository;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class ReferralController extends Controller
{
    protected $affiliateRepository;

    public function __construct(AffiliateRepository $affiliateRepository)
    {
        $this->affiliateRepository = $affiliateRepository;
        config()->set('database.connections.mysql.strict', false);
        DB::reconnect();
    }

    public function myReferral()
    {
        $user = Auth::user();
        $referrals = [];

        // Fetch referrals data
        $referrals['level_3'] = DB::table('referral_users as ru1')
            ->where('ru1.parent_id', $user->id)
            ->join('referral_users as ru2', 'ru2.parent_id', '=', 'ru1.user_id')
            ->join('referral_users as ru3', 'ru3.parent_id', '=', 'ru2.user_id')
            ->join('users', 'users.id', '=', 'ru3.user_id')
            ->select('ru3.user_id as id', 'users.email', 'users.first_name as full_name', 'users.created_at as joining_date', DB::raw('"Level 3" as level'))
            ->get();

        $referrals['level_2'] = DB::table('referral_users as ru1')
            ->where('ru1.parent_id', $user->id)
            ->join('referral_users as ru2', 'ru2.parent_id', '=', 'ru1.user_id')
            ->join('users', 'users.id', '=', 'ru2.user_id')
            ->select('ru2.user_id as id', 'users.email', 'users.first_name as full_name', 'users.created_at as joining_date', DB::raw('"Level 2" as level'))
            ->get();

        $referrals['level_1'] = DB::table('referral_users as ru1')
            ->where('ru1.parent_id', $user->id)
            ->join('users', 'users.id', '=', 'ru1.user_id')
            ->select('ru1.user_id as id', 'users.email', 'users.first_name as full_name', 'users.created_at as joining_date', DB::raw('"Level 1" as level'))
            ->get();

        // Check and create referral code if necessary
        if (!$user->Affiliate) {
            $created = $this->affiliateRepository->create($user->id);
            if ($created < 1) {
                return response()->json(['error' => __('Failed to generate new referral code.')], 400);
            }
        }

        $referralUrl = url('') . '/referral-reg?ref_code=' . $user->affiliate->code;

        // Get referral levels
        $maxReferralLevel = max_level();
        $referralQuery = $this->affiliateRepository->childrenReferralQuery($maxReferralLevel);

        $referralAll = $referralQuery['referral_all']->where('ru1.parent_id', $user->id)
            ->select('ru1.parent_id', DB::raw($referralQuery['select_query']))
            ->first();

        $referralLevels = [];
        for ($i = 0; $i < $maxReferralLevel; $i++) {
            $level = 'level' . ($i + 1);
            $referralLevels[($i + 1)] = $referralAll->{$level};
        }

        // Monthly earnings
        $monthlyEarnings = AffiliationHistory::select(
            DB::raw('DATE_FORMAT(`created_at`,\'%Y-%m\') as "year_month"'),
            DB::raw('SUM(amount) AS total_amount'),
            DB::raw('COUNT(DISTINCT(child_id)) AS total_child'))
            ->where('user_id', $user->id)
            ->where('status', 1)
            ->groupBy('year_month')
            ->get();

        $monthlyEarningData = [];
        foreach ($monthlyEarnings as $monthlyEarning) {
            $monthlyEarningData[$monthlyEarning->year_month] = [
                'year_month' => $monthlyEarning->year_month,
                'total_amount' => $monthlyEarning->total_amount
            ];
        }

        return response()->json([
            'user' => $user,
            'referrals' => $referrals,
            'referralUrl' => $referralUrl,
            'referralLevels' => $referralLevels,
            'monthlyEarningData' => $monthlyEarningData
        ]);
    }

    public function signup(Request $request)
    {
        $code = $request->get('ref_code');
        $parentUser = AffiliationCode::where('code', $code)->first();

        if ($parentUser) {
            return response()->json(['redirect' => route('auth.signup')]);
        } else {
            return response()->json(['error' => __('Invalid referral code.')], 400);
        }
    }

    public function myReferralEarning(Request $request)
    {
        if ($request->ajax()) {
            $items = AffiliationHistory::where(['user_id' => Auth::id(), 'status' => STATUS_ACTIVE])->select('*');

            return datatables()->of($items)
                ->addColumn('created_at', function ($item) {
                    return $item->created_at;
                })->addColumn('child_id', function ($item) {
                    return $item->child->first_name.' '.$item->child->last_name;
                })->addColumn('coin_type', function ($item) {
                    return find_coin_type($item->coin_type);
                })->addColumn('status', function ($item) {
                    return deposit_status($item->status);
                })
                ->make(true);
        }

        return response()->json(['title' => __('My referral Earning History')]);
    }

    public function __destruct()
    {
        config()->set('database.connections.mysql.strict', true);
        DB::reconnect();
    }
}
