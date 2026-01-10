<?php
use App\Http\Controllers\Api\HomeApiController;
use App\Http\Controllers\Api\ServiceApiController;
use App\Http\Controllers\Api\ProjectApiController;
use App\Http\Controllers\Api\PageApiController;
use App\Http\Controllers\Api\ReservationApiController;
use App\Http\Controllers\Api\SettingsApiController;


Route::get('/home', [HomeApiController::class, 'index']);

Route::get('/services', [ServiceApiController::class, 'index']);
Route::get('/services/{slug}', [ServiceApiController::class, 'show']);

Route::get('/projects', [ProjectApiController::class, 'index']);
Route::get('/projects/{slug}', [ProjectApiController::class, 'show']);


Route::prefix('front/reservations')->group(function () {
    Route::get('/', [ReservationApiController::class, 'index']);
    Route::get('/{id}', [ReservationApiController::class, 'show']);
    Route::post('/', [ReservationApiController::class, 'store']);
  
});
Route::prefix('front/settings')->group(function () {
    Route::get('/', [SettingsApiController::class, 'index']);       // Tous les paramètres
    Route::get('/{key}', [SettingsApiController::class, 'show']);   // Paramètre spécifique
    Route::post('/', [SettingsApiController::class, 'update']);     // Mettre à jour / créer
   
});

Route::get('/pages', [PageApiController::class, 'index']);
Route::get('/pages/{slug}', [PageApiController::class, 'show']);

Route::get('/reservation', [ReservationApiController::class, 'prepare']); // hors middleware
Route::get('/reservation/check', [ReservationApiController::class, 'checkAvailability']);

