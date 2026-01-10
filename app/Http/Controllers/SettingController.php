<?php

namespace App\Http\Controllers;

use App\Models\Setting;
use Illuminate\Http\Request;
use Inertia\Inertia;

class SettingController extends Controller
{
    // Affiche la page d'édition des paramètres via Inertia/Vue
    public function edit()
    {
        $settings = Setting::pluck('value', 'key')->toArray();
        return Inertia::render('Admin/Settings/edit', [
            'settings' => $settings
        ]);
    }

    // Met à jour les paramètres
   public function update(Request $request)
{
    $data = $request->except(['_token', 'logoFile', 'logo']); // ⚡ on ignore le base64

    // ✅ Gérer le logo uploadé
    if ($request->hasFile('logoFile')) {
        $path = $request->file('logoFile')->store('uploads/settings', 'public');
        $data['logo'] = '/storage/' . $path; // chemin public
    }

    // ✅ Enregistrer chaque paramètre
    foreach ($data as $key => $value) {
        Setting::updateOrCreate(['key' => $key], ['value' => $value]);
    }

    return redirect()->back()->with('success', 'Paramètres mis à jour !');
}


    // Récupère la valeur d'un paramètre
    public function get($key)
    {
        return Setting::where('key', $key)->value('value');
    }
}