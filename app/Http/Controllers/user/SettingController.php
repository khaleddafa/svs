<?php
namespace App\Http\Controllers\user;

use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use PragmaRX\Google2FA\Google2FA;

class SettingController extends Controller
{
    // User setting
    public function userSetting()
    {
        $data = [];
        $default = allsetting();
        $google2fa = new Google2FA();
        $google2fa->setAllowInsecureCallToGoogleApis(true);
        $data['google2fa_secret'] = $google2fa->generateSecretKey();

        $google2fa_url = $google2fa->getQRCodeGoogleUrl(
            $default['app_title'] ?? 'cPoket',
            Auth::user()->email ?? 'cpoket@email.com',
            $data['google2fa_secret']
        );
        $data['qrcode'] = $google2fa_url;

        return response()->json([
            'title' => __('Settings'),
            'adm_setting' => $default,
            'google2fa_secret' => $data['google2fa_secret'],
            'qrcode' => $data['qrcode']
        ]);
    }

    // Google 2FA secret save
    public function g2fSecretSave(Request $request)
    {
        if (!empty($request->code)) {
            $user = User::find(Auth::id());
            $google2fa = new Google2FA();

            if ($request->remove != 1) {
                $valid = $google2fa->verifyKey($request->google2fa_secret, $request->code);
                if ($valid) {
                    $user->google2fa_secret = $request->google2fa_secret;
                    $user->g2f_enabled = 1;
                    $user->save();

                    return response()->json(['message' => __('Google authentication code added successfully')]);
                } else {
                    return response()->json(['message' => __('Google authentication code is invalid')], 400);
                }
            } else {
                if (!empty($user->google2fa_secret)) {
                    $valid = $google2fa->verifyKey($user->google2fa_secret, $request->code);
                    if ($valid) {
                        $user->google2fa_secret = null;
                        $user->g2f_enabled = 0;
                        $user->save();
                        return response()->json(['message' => __('Google authentication code removed successfully')]);
                    } else {
                        return response()->json(['message' => __('Google authentication code is invalid')], 400);
                    }
                } else {
                    return response()->json(['message' => __('Google authentication code is invalid')], 400);
                }
            }
            return response()->json(['message' => __('Google authentication code is invalid')], 400);
        }
        return response()->json(['message' => __('Google authentication code cannot be empty')], 400);
    }

    // Enable Google login
    public function googleLoginEnable(Request $request)
    {
        if (!empty(Auth::user()->google2fa_secret)) {
            $user = Auth::user();

            if ($user->g2f_enabled == 0) {
                $user->g2f_enabled = 1;
                $user->save();
                return response()->json(['message' => __('Google two factor authentication is enabled')]);
            } else {
                $user->g2f_enabled = 0;
                $user->save();
                return response()->json(['message' => __('Google two factor authentication is disabled')]);
            }
        } else {
            return response()->json(['message' => __('For using Google two factor authentication, please set up your authentication')], 400);
        }
    }

    // Save preference
    public function savePreference(Request $request)
    {
        try {
            if ($request->lang) {
                User::where('id', Auth::id())->update(['language' => $request->lang]);
                return response()->json(['message' => __('Language changed successfully')]);
            }
        } catch (\Exception $e) {
            return response()->json(['message' => __('Something went wrong.')], 500);
        }
    }
}
