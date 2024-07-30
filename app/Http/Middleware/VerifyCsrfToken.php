<?php

namespace App\Http\Middleware;

use Illuminate\Foundation\Http\Middleware\VerifyCsrfToken as Middleware;

class VerifyCsrfToken extends Middleware
{
    /**
     * Indicates whether the XSRF-TOKEN cookie should be set on the response.
     *
     * @var bool
     */
    protected $addHttpCookie = true;

    /**
     * The URIs that should be excluded from CSRF verification.
     *
     * @var array
     */
    protected $except = [
        'login-process',  // Add your API routes here
        'sign-up-process',
        'send-forgot-mail',
        'reset-password-save',
        'g2f-verify',
        'verify-email-post',
      'user/g2f-secret-save',
      'user/withdrawal-coin/callback',
      'user/withdrawal-coin/deposit/callback'
    ];
}
