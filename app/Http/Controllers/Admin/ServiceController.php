<?php

namespace App\Http\Controllers\Admin;
use App\Http\Controllers\Controller;
use App\Models\Service;
use Illuminate\Http\Request;
use Inertia\Inertia;

class ServiceController extends Controller
{
    public function index()
    {
        return Inertia::render('Admin/Services/Index', [
            'services' => Service::all()
        ]);
    }

    public function create()
    {
        return Inertia::render('Admin/Services/Create');
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'long_description' => 'nullable|string', 
            'icon' => 'nullable|string|max:2048'
        ]);

        if ($request->hasFile('icon')) {
            $data['icon'] = $request->file('icon')->store('services', 'public');
        }
        
        if (isset($data['long_description'])) {
            // On décode les entités HTML si nécessaire
            $data['long_description'] = html_entity_decode($data['long_description']);
        }
           
       
    

        Service::create($data);

        return redirect()->route('services.index')->with('success', 'Service ajouté avec succès');
    }

    public function edit(Service $service)
    {
        return Inertia::render('Admin/Services/Edit', [
            'service' => $service
        ]);
    }

    public function update(Request $request, Service $service)
    {
        $data = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'long_description' => 'nullable|string', // Description longue en HTML
            'icon' => 'nullable|string|max:2048'
        ]);

        if ($request->hasFile('icon')) {
            $data['icon'] = $request->file('icon')->store('services', 'public');
        }
        if (isset($data['long_description'])) {
            // On décode les entités HTML si nécessaire
            $data['long_description'] = html_entity_decode($data['long_description']);
        }

        $service->update($data);

        return redirect()->route('services.index')->with('success', 'Service mis à jour');
    }

    public function destroy(Service $service)
    {
        $service->delete();
        return redirect()->route('services.index')->with('success', 'Service supprimé');
    }
}