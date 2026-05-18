<?php

declare(strict_types=1);

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;

/**
 * REFERENCE ONLY — create via `php artisan make:controller ExplorationController`
 * then paste/adapt method bodies as needed.
 *
 * Routes companion:
 *   Route::get('/exploration/hello-controller', [ExplorationController::class, 'hello']);
 */
final class ExplorationController extends Controller
{
    /**
     * Tiny JSON probe mirroring the closure route pattern.
     */
    public function hello(): JsonResponse
    {
        return response()->json([
            'ok' => true,
            'via' => 'controller',
            'at' => now()->toIso8601String(),
        ]);
    }
}
