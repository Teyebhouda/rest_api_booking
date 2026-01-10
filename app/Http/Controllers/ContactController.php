<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use App\Mail\ContactRequestMail;
use App\Mail\DevisRequestMail;

class ContactController extends Controller
{
    public function send(Request $request)
    {
      //  dd($request->all());
        // Valider les données
        $data = $request->validate([
            'nom' => 'required|string|max:255',
            'email' => 'required|email|max:255',
            'telephone' => 'required|string|max:50',
            'service' => 'required|string|max:255',
            'message' => 'required|string|max:2000',
        ]);

        

        // Envoyer l'email à l'admin
        Mail::to(config('mail.admin_address'))->send(new DevisRequestMail($data));

        // Répondre (Inertia attend une réponse 200)
       // return back()->with('success', 'Demande envoyée avec succès');
        return response()->json([
        'success' => true,
        'message' => 'Merci, nous avons reçu votre demande, nous vous répondrons dans les plus brefs délais.'
        ])->setStatusCode(200);
   
    }

    public function sendcontact(Request $request)
    {
        // Valider les données
        $data = $request->validate([
            'nom' => 'required|string|max:255',
            'email' => 'required|email|max:255',
            'telephone' => 'nullable|string|max:50',
            'message' => 'required|string|max:2000',
        ]);

        // Envoyer l'email à l'admin
        Mail::to(config('mail.admin_address'))->send(new ContactRequestMail($data));

        // Répondre (Inertia attend une réponse 200)
       // return back()->with('success', 'Demande envoyée avec succès');
        return response()->json([
        'success' => true,
        'message' => 'Merci, nous avons reçu votre demande, nous vous répondrons dans les plus brefs délais.'
        ])->setStatusCode(200);
   
    }
}
