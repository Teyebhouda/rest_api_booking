<?php
use App\Http\Controllers\Api\HomeApiController;
use App\Http\Controllers\Api\ServiceApiController;
use App\Http\Controllers\Api\ProjectApiController;
use App\Http\Controllers\Api\PageApiController;
use App\Http\Controllers\Api\ReservationApiController;
use App\Http\Controllers\Api\SettingsApiController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;


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



Route::post('/contact', function (Request $request) {

    if ($request->website) {
        return response()->json(['success' => true]);
    }

    $request->validate([
        'nom' => 'required|string|max:255',
        'email' => 'required|email',
        'telephone' => 'nullable|string|max:20', // ✅ ajouté
        'service' => 'required|string',
        'message' => 'required|string',
    ]);

    Mail::send([], [], function ($mail) use ($request) {
        $mail->to(env('MAIL_TO'))
            ->replyTo($request->email)
            ->subject('Nouveau message de ' . $request->nom)
            ->html("
                <h2>📩 Nouveau message MR INFRA</h2>

                <p><strong>Nom :</strong> {$request->nom}</p>
                <p><strong>Email :</strong> {$request->email}</p>
                <p><strong>Téléphone :</strong> " . ($request->telephone ?? 'Non renseigné') . "</p>
                <p><strong>Service :</strong> {$request->service}</p>

                <hr>

                <p><strong>Message :</strong></p>
                <p>{$request->message}</p>
            ");
    });

    return response()->json(['success' => true]);
});

