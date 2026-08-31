<?php
use App\Http\Controllers\Api\HomeApiController;
use App\Http\Controllers\Api\ServiceApiController;
use App\Http\Controllers\Api\ProjectApiController;
use App\Http\Controllers\Api\PageApiController;
use App\Http\Controllers\Api\ReservationApiController;
use App\Http\Controllers\Api\SettingsApiController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Cache\RateLimiting\Limit;


RateLimiter::for(
    'contact-form',
    function (
        Request $request
    ) {
        return [
            Limit::perMinute(5)
                ->by(
                    $request->ip()
                )
        ];
    }
);


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

    // ==========================
    // HONEYPOT
    // ==========================
    if (!empty($request->website)) {
        // fake success pour ne pas révéler le blocage
        return response()->json([
            'success' => true
        ]);
    }

    // ==========================
    // ANTI BOT (temps minimum)
    // ==========================
    if (
        $request->filled('form_time')
        && (int) $request->form_time < 3000
    ) {
        return response()->json([
            'success' => false,
            'error' => 'Bot détecté'
        ], 403);
    }

    // ==========================
    // VALIDATION
    // ==========================
    $validated = $request->validate([
        'nom' => 'required|string|max:100',

        'email' => [
            'required',
            'email:rfc,dns',
            'max:150'
        ],

        'telephone' => [
            'nullable',
            'string',
            'max:20'
        ],

        'service' => [
            'required',
            'string',
            'max:100'
        ],

        'message' => [
            'required',
            'string',
            'max:3000'
        ],

        'company' => [
            'nullable',
            'string',
            'max:150'
        ],

        // honeypot validation
        'website' => [
            'nullable',
            'max:0'
        ],

        // anti-bot timer
        'form_time' => [
            'nullable',
            'integer'
        ]
    ]);

    try {

        Mail::send([], [], function ($mail) use ($validated) {

            $safeNom = e(
                $validated['nom']
            );

            $safeEmail = e(
                $validated['email']
            );

            $safeTelephone = e(
                $validated['telephone']
                ?? 'Non renseigné'
            );

            $safeService = e(
                $validated['service']
            );

            $safeCompany = e(
                $validated['company']
                ?? 'Non renseignée'
            );

            $safeMessage = nl2br(
                e($validated['message'])
            );

            $mail->to(
                env('MAIL_TO')
            )
            ->replyTo(
                $validated['email']
            )
            ->subject(
                'Nouveau message de ' .
                $safeNom
            )
            ->html("
                <h2>
                    📩 Nouveau message MR INFRA
                </h2>

                <p>
                    <strong>Nom :</strong>
                    {$safeNom}
                </p>

                <p>
                    <strong>Email :</strong>
                    {$safeEmail}
                </p>

                <p>
                    <strong>Téléphone :</strong>
                    {$safeTelephone}
                </p>

                <p>
                    <strong>Entreprise :</strong>
                    {$safeCompany}
                </p>

                <p>
                    <strong>Service :</strong>
                    {$safeService}
                </p>

                <hr>

                <p>
                    <strong>Message :</strong>
                </p>

                <p>
                    {$safeMessage}
                </p>
            ");
        });

        return response()->json([
            'success' => true
        ]);

    } catch (\Exception $e) {

        \Log::error(
            'Erreur formulaire contact',
            [
                'message' => $e->getMessage()
            ]
        );

        return response()->json([
            'success' => false,
            'error' =>
                "Erreur lors de l'envoi"
        ], 500);
    }
})->middleware('throttle:contact-form')
;

