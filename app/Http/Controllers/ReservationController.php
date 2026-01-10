<?php

namespace App\Http\Controllers;
use Inertia\Inertia;

use Illuminate\Http\Request;
use App\Models\Reservation;
use App\Models\Service;

class ReservationController extends Controller
{
 public function index(Request $request)
{
    $query = Reservation::with('service')->latest();

    if ($request->status) {
        $query->where('status', $request->status);
    }

    if ($request->search) {
        $search = $request->search;
        $query->where(function ($q) use ($search) {
            $q->where('name', 'like', "%$search%")
              ->orWhere('email', 'like', "%$search%")
              ->orWhereHas('service', fn($q) => $q->where('title', 'like', "%$search%"));
        });
    }

    $reservations = $query->paginate(10)->withQueryString();

    return Inertia::render('Admin/Reservations/Index', [
        'reservations' => $reservations,
        'filters' => $request->only(['status', 'search']),
    ]);
}

public function create()
{
    $services = Service::all(['id', 'title']);
    return Inertia::render('Admin/Reservations/Create', ['services' => $services]);
}

public function store(Request $request)
{
    $data = $request->validate([
        'service_id' => 'required|exists:services,id',
        'check_in' => 'required|date|after:now',
        'check_out' => 'required|date|after:check_in',
        'name' => 'required|string|max:255',
        'email' => 'required|email|max:255',
        'phone' => 'nullable|string|max:20',
        'note' => 'nullable|string|max:500'
    ]);

    $data['user_id'] = auth()->id();

    Reservation::create($data);

    return redirect()->route('reservations.index')->with('success', 'Réservation créée avec succès');
}

public function updateStatus(Request $request, Reservation $reservation)
{
    $request->validate(['status' => 'required|in:pending,confirmed,cancelled']);
    $reservation->update(['status' => $request->status]);
    return redirect()->back()->with('success', 'Statut mis à jour');
}

}

