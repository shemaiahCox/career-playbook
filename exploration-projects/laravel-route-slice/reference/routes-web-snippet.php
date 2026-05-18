<?php

/**
 * REFERENCE ONLY — paste fragments into a real Laravel app's routes/web.php
 *
 * Prerequisites:
 *   composer create-project laravel/laravel your-app && cd your-app
 *
 * Laravel ships web middleware groups (sessions, cookies, CSRF on POST forms).
 * This GET route stays intentionally tiny for exploration.
 */

use Illuminate\Support\Facades\Route;

Route::get('/exploration/hello', function () {
    // response()->json wraps Symfony JsonResponse — stable HTTP JSON envelope.
    return response()->json([
        'ok' => true,
        'via' => 'closure-route',
        // now() is Laravel's Carbon-backed clock helper — handy for probes/logs.
        'at' => now()->toIso8601String(),
    ]);
});
