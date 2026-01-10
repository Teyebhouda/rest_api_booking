<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\HomePageSection;
use Illuminate\Support\Str;
use Inertia\Inertia;
use App\Models\Service;

class ServiceController extends Controller
{

      public function index()
    {
        $services = Service::all();
        return Inertia::render('Admin/Services/Index', [
            'services' => $services
        ]);
    }
    public function batchUpdate(Request $request)
{
   //dd($request->all());
    
    $validated = $request->validate([
        'items' => 'required|array',
        'items.*.id' => 'nullable|integer|exists:services,id',
        'items.*.title' => 'required|string|max:255',
        'items.*.description' => 'nullable|string',
        'items.*.long_description' => 'nullable|string',
        'items.*.icon' => 'nullable|string|max:255',
        'items.*.meta_title' => 'nullable|string|max:255',
        'items.*.meta_description' => 'nullable|string|max:1000',
        'items.*.meta_keywords' => 'nullable|string|max:1000',
        'items.*.imageFile' => 'nullable|image|max:20480', // New validation for uploaded file
        //'items.*.background_image' => 'nullable|string|max:500', // New field for background image URL
    ]);
   

    foreach ($request->input('items') as $index => $item) {
        // Handle uploaded logoFile (optional)
        if ($request->hasFile("items.$index.imageFile")) {
            $file = $request->file("items.$index.imageFile");
            $path = $file->store('uploads/services', 'public');
            $item['background_image'] = '/storage/' . $path;
        }
  if (!empty($item['long_description'])) {
        $item['long_description'] = html_entity_decode($item['long_description']);
    }

        // Générer le slug à partir du titre
        $item['slug'] = Str::slug($item['title']);
        // Create or update service
        if (!empty($item['id'])) {
            $service = Service::find($item['id']);
            if ($service) {
                $service->update($item);
            }
        } else {
            Service::create($item);
        }
    }

    return redirect()->back()->with('success', 'Services mis à jour !');
}


public function show($slug)
{
    
    // ✅ Récupérer directement le service via le slug
    $service = Service::where('slug', $slug)
        ->select('id', 'title', 'slug', 'description', 'icon','background_image', 'long_description', 'meta_title', 'meta_description', 'meta_keywords')
        ->firstOrFail();

    // ✅ Récupérer tous les services pour la liste
    $services = Service::all(['id', 'title', 'slug', 'description', 'icon'])->toArray();

    // ✅ Récupérer le footer si besoin
    $footer = HomePageSection::where('section_key', 'footer')->first();
    

    return Inertia::render('Front/ServiceDetail', [
        'service' => $service,
        'sections' => [
            'services' => ['content' => ['items' => $services]],
            'footer' => ['content' => $footer ? json_decode($footer->content, true) : []],
        ],
        // ✅ SEO dynamique
        'seo' => [
            'meta_title' => $service->meta_title ?? $service->title,
            'meta_description' => $service->meta_description ?? Str::limit(strip_tags($service->description), 160),
            'meta_keywords' => $service->meta_keywords ?? '',
        ]
    ]);
}

public function destroy(Service $service)
{
    $service->delete();
    return redirect()->back()->with('success', 'Service supprimé avec succès !');
}


}
