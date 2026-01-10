<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Setting;
use Illuminate\Http\Request;

class SettingsApiController extends Controller
{
    /**
     * Récupérer tous les paramètres pour le front
     */
    public function index()
    {
        $settings = Setting::pluck('value', 'key')->toArray();

        return response()->json([
            'success' => true,
            'data' => $settings,
        ]);
    }

    /**
     * Récupérer un paramètre spécifique
     */
    public function show($key)
    {
        $value = Setting::where('key', $key)->value('value');

        if (is_null($value)) {
            return response()->json([
                'success' => false,
                'message' => "Paramètre '$key' introuvable",
            ], 404);
        }

        return response()->json([
            'success' => true,
            'key' => $key,
            'value' => $value,
        ]);
    }

    /**
     * Mettre à jour un paramètre côté front (optionnel)
     */
    public function update(Request $request)
    {
        $data = $request->except(['_token', 'logoFile', 'logo']);

        if ($request->hasFile('logoFile')) {
            $path = $request->file('logoFile')->store('uploads/settings', 'public');
            $data['logo'] = '/storage/' . $path;
        }

        foreach ($data as $key => $value) {
            Setting::updateOrCreate(['key' => $key], ['value' => $value]);
        }

        return response()->json([
            'success' => true,
            'message' => 'Paramètres mis à jour !',
            'data' => Setting::pluck('value', 'key')->toArray(),
        ]);
    }
}
