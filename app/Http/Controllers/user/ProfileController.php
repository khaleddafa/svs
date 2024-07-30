<?php

namespace App\Http\Controllers\user;

use App\Http\Requests\driveingVerification;
use App\Http\Requests\passportVerification;
use App\Http\Requests\resetPasswordRequest;
use App\Http\Requests\UserProfileUpdate;
use App\Http\Requests\verificationNid;
use App\Http\Services\AuthService;
use App\Http\Services\SmsService;
use App\Model\ActivityLog;
use App\Model\VerificationDetails;
use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cookie;
use Illuminate\Support\Facades\Validator;

class ProfileController extends Controller
{
    //my profile
    public function userProfile(Request $request)
    {
        $data = [
            'user' => User::find(Auth::id()),
            'clubInfos' => get_plan_info(Auth::id()),
            'nid_front' => VerificationDetails::where('user_id', Auth::id())->where('field_name', 'nid_front')->first(),
            'nid_back' => VerificationDetails::where('user_id', Auth::id())->where('field_name', 'nid_back')->first(),
            'pass_front' => VerificationDetails::where('user_id', Auth::id())->where('field_name', 'pass_front')->first(),
            'pass_back' => VerificationDetails::where('user_id', Auth::id())->where('field_name', 'pass_back')->first(),
            'drive_front' => VerificationDetails::where('user_id', Auth::id())->where('field_name', 'drive_front')->first(),
            'drive_back' => VerificationDetails::where('user_id', Auth::id())->where('field_name', 'drive_back')->first(),
            'qr' => $request->input('qr', 'profile-tab')
        ];

        if ($request->ajax()) {
            $activities = ActivityLog::where('user_id', Auth::id())->get();
            return response()->json([
                'data' => $activities->map(function ($item) {
                    return [
                        'id' => $item->id,
                        'action' => userActivity($item->action),
                        // Add other necessary fields here
                    ];
                }),
            ]);
        }

        return response()->json($data);
    }

    // profile upload image
    public function uploadProfileImage(Request $request)
    {
        $rules = [
            'file_one' => 'required|image|max:2048|mimes:jpg,jpeg,png,gif,svg|dimensions:max_width=500,max_height=500'
        ];
        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            $message = $validator->errors()->first('file_one');
            return response()->json(['success' => false, 'message' => $message], 422);
        }

        try {
            $img = $request->file('file_one');
            $user = !empty($request->id) ? User::find(decrypt($request->id)) : Auth::user();

            if ($img !== null) {
                $photo = uploadFile($img, IMG_USER_PATH, !empty($user->photo) ? $user->photo : '');
                $user->photo = $photo;
                $user->save();
                return response()->json(['success' => true, 'message' => 'Profile picture uploaded successfully']);
            }

            return response()->json(['success' => false, 'message' => 'Please input an image'], 400);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage()], 500);
        }
    }

    // update user profile
    public function userProfileUpdate(UserProfileUpdate $request)
    {
        if (strpos($request->phone, '+') !== false) {
            return response()->json(['success' => false, 'message' => "Don't put plus sign with phone number"], 400);
        }

        $user = !empty($request->id) ? User::find(decrypt($request->id)) : Auth::user();
        $data = $request->only(['first_name', 'last_name', 'country', 'gender', 'phone']);

        if ($user->phone !== $request->phone) {
            $data['phone_verified'] = 0;
        }

        $user->update($data);

        return response()->json(['success' => true, 'message' => 'Profile updated successfully']);
    }

    // send sms
    public function sendSMS()
    {
        if (!empty(Auth::user()->phone)) {
            $key = Cookie::get('code') ?? randomNumber(8);
            Cookie::queue(Cookie::make('code', $key, 100 * 60));
            $text = 'Your verification code is ' . $key;
            $number = Auth::user()->phone;

            try {
                if (settings('sms_getway_name') == 'twillo') {
                    app(SmsService::class)->send("+" . $number, $text);
                }

                return response()->json(['success' => true, 'message' => 'We sent a verification code to your phone.']);
            } catch (\Exception $exception) {
                Cookie::queue(Cookie::forget('code'));
                return response()->json(['success' => false, 'message' => 'Something went wrong. Please contact your system admin.'], 500);
            }
        }

        return response()->json(['success' => false, 'message' => 'You should add your phone number first.'], 400);
    }

    // phone verification process
    public function phoneVerify(Request $request)
    {
        $code = $request->input('code');
        $cookie = Cookie::get('code');

        if ($code) {
            if ($cookie) {
                if ($code == $cookie) {
                    $user = User::find(Auth::id());
                    $user->phone_verified = 1;
                    $user->save();
                    Cookie::queue(Cookie::forget('code'));

                    return response()->json(['success' => true, 'message' => 'Phone verified successfully.']);
                }

                return response()->json(['success' => false, 'message' => 'You entered the wrong OTP.'], 400);
            }

            return response()->json(['success' => false, 'message' => 'Your OTP has expired.'], 400);
        }

        return response()->json(['success' => false, 'message' => "OTP can't be empty."], 400);
    }

    // upload NID
    public function nidUpload(verificationNid $request)
    {
        $img = $request->file('file_two');
        $img2 = $request->file('file_three');

        if ($img) {
            $details = VerificationDetails::updateOrCreate(
                ['user_id' => Auth::id(), 'field_name' => 'nid_front'],
                ['status' => STATUS_PENDING, 'photo' => uploadFile($img, IMG_USER_PATH)]
            );
        }

        if ($img2) {
            $details = VerificationDetails::updateOrCreate(
                ['user_id' => Auth::id(), 'field_name' => 'nid_back'],
                ['status' => STATUS_PENDING, 'photo' => uploadFile($img2, IMG_USER_PATH)]
            );
        }

        return response()->json(['success' => true, 'message' => 'NID photo uploaded successfully']);
    }

    // upload passport
    public function passUpload(passportVerification $request)
    {
        $img = $request->file('file_two');
        $img2 = $request->file('file_three');

        if ($img) {
            VerificationDetails::updateOrCreate(
                ['user_id' => Auth::id(), 'field_name' => 'pass_front'],
                ['status' => STATUS_PENDING, 'photo' => uploadFile($img, IMG_USER_PATH)]
            );
        }

        if ($img2) {
            VerificationDetails::updateOrCreate(
                ['user_id' => Auth::id(), 'field_name' => 'pass_back'],
                ['status' => STATUS_PENDING, 'photo' => uploadFile($img2, IMG_USER_PATH)]
            );
        }

        return response()->json(['success' => true, 'message' => 'Passport photo uploaded successfully']);
    }

    // upload driving licence
    public function driveUpload(driveingVerification $request)
    {
        $img = $request->file('file_two');
        $img2 = $request->file('file_three');

        if ($img) {
            VerificationDetails::updateOrCreate(
                ['user_id' => Auth::id(), 'field_name' => 'drive_front'],
                ['status' => STATUS_PENDING, 'photo' => uploadFile($img, IMG_USER_PATH)]
            );
        }

        if ($img2) {
            VerificationDetails::updateOrCreate(
                ['user_id' => Auth::id(), 'field_name' => 'drive_back'],
                ['status' => STATUS_PENDING, 'photo' => uploadFile($img2, IMG_USER_PATH)]
            );
        }

        return response()->json(['success' => true, 'message' => 'Driving licence photo uploaded successfully']);
    }

    // change password
    public function changePasswordSave(resetPasswordRequest $request)
    {
        $service = new AuthService();
        $change = $service->changePassword($request);

        if ($change['success']) {
            return response()->json(['success' => true, 'message' => $change['message']]);
        } else {
            return response()->json(['success' => false, 'message' => $change['message']], 400);
        }
    }
}
