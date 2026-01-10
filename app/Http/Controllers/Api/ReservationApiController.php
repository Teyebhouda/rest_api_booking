<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\ReservationResource;
use App\Models\Reservation;
use App\Models\Service;
use App\Models\HomePageSection;
use Illuminate\Http\Request;
   use Carbon\Carbon;

class ReservationApiController extends Controller
{
    /**
     * Récupérer le footer de la homepage
     */
    private function getFooter(): array
    {
        $footer = HomePageSection::where('section_key', 'footer')->first();
        return $footer ? json_decode($footer->content, true) : [];
    }

    /**
     * Liste des services pour le front
     */
    private function getServices(): array
    {
        return Service::all(['id', 'title', 'slug', 'description', 'icon'])->toArray();
    }

    /**
     * Lister les réservations de l'utilisateur (ou toutes si admin)
     */
    public function index(Request $request)
    {
        $userId = $request->user()?->id;

        $query = Reservation::with('service')->latest();

        if ($userId) {
            $query->where('user_id', $userId);
        }

        $reservations = $query->get();

        return response()->json([
            'success' => true,
            'data' => ReservationResource::collection($reservations),
            'services' => $this->getServices(),
            'footer' => $this->getFooter(),
        ]);
    }

    /**
     * Créer une réservation depuis le front
     */
    public function store(Request $request)
    {
   

$validated = $request->validate([
    'service_id' => 'required|exists:services,id',

    'check_in' => [
        'required',
        'date',
        function ($attr, $value, $fail) {
            if (Carbon::parse($value)->startOfDay()->lt(now()->startOfDay())) {
                $fail('Check-in must be today or later.');
            }
        }
    ],

    'check_out' => [
        'required',
        'date',
        function ($attr, $value, $fail) use ($request) {
            if (
                Carbon::parse($value)
                    ->startOfDay()
                    ->lte(Carbon::parse($request->check_in)->startOfDay())
            ) {
                $fail('Check-out must be at least one night after check-in.');
            }
        }
    ],

    'name'  => 'required|string|max:255',
    'email' => 'required|email|max:255',
    'phone' => 'nullable|string|max:20',
    'note'  => 'nullable|string|max:500',
]);



        $validated['user_id'] = $request->user()?->id;

        $reservation = Reservation::create($validated);

        return response()->json([
            'success' => true,
            'message' => 'Réservation créée avec succès',
            'data' => new ReservationResource($reservation->load('service')),
            'services' => $this->getServices(),
            'footer' => $this->getFooter(),
        ], 201);
    }


    public function prepare(Request $request)
{
    
    $serviceSlug = $request->query('service');

    $service = null;

    if ($serviceSlug) {
        $service = Service::where('slug', $serviceSlug)->firstOrFail();
    }
   

    return response()->json([
        'success' => true,
        'service' => $service,
        'services' => $this->getServices(),
        'footer' => $this->getFooter(),
    ]);
}

    /**
     * Détails d'une réservation
     */
    public function show($id)
    {
        $reservation = Reservation::with('service')->findOrFail($id);

        return response()->json([
            'success' => true,
            'data' => new ReservationResource($reservation),
            'services' => $this->getServices(),
            'footer' => $this->getFooter(),
        ]);
    }


// check disponibilité 


public function checkAvailability(Request $request)
{
    $request->validate([
        'service_id' => 'required|exists:services,id',
        'check_in' => 'required|date',
        'check_out' => 'required|date|after:check_in',
    ]);

    $overlap = Reservation::where('service_id', $request->service_id)
    ->where(function ($q) use ($request) {
        $q->where('check_in', '<', $request->check_out)
          ->where('check_out', '>', $request->check_in);
    })
    ->exists();

if ($overlap) {
    return response()->json([
        'success' => false,
        'message' => 'Room not available for selected dates'
    ], 422);
}

    return response()->json([
        'available' => !$overlap
    ]);
}


}
