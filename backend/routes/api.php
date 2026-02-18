<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\SpaceController;
use App\Http\Controllers\EvacuationResponsibleController;
use App\Http\Controllers\EvacuationController;
use App\Http\Controllers\ZoneController;

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::middleware('auth:sanctum')->post('/change-password', [AuthController::class, 'changePassword']);


Route::get('/evacuations/active', [EvacuationController::class, 'active']);
Route::patch('evacuations/stop', [EvacuationController::class, 'stopEvacuation']);
Route::post('/evacuations/start', [EvacuationController::class, 'store']);
Route::apiResource('evacuations', EvacuationController::class);


Route::patch('/spaces/{space}/status', [SpaceController::class, 'updateStatus']);
Route::get('/spaces/by-floor', [SpaceController::class, 'indexByFloor']);
Route::get('/spaces/by-floor-zone', [SpaceController::class, 'indexByFloorAndZone']);

Route::apiResource('spaces', SpaceController::class);
Route::apiResource('zones', ZoneController::class);

Route::apiResource('evacuation-responsibles', EvacuationResponsibleController::class);

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/user', function (Request $request) {
        return $request->user();
    });
});
