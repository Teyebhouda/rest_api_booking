<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\HomePageSection;
use Inertia\Inertia;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\Storage;
use Intervention\Image\Laravel\Facades\Image;
use App\Models\Project;
use App\Models\Service;


class HomeController extends Controller
{
    /**
     * Display the home page.
     */
    public function index()
    {
        
      $sections = HomePageSection::all()->mapWithKeys(function ($section) {
        // On ne décode que si c'est une chaîne JSON
        $content = $section->content;
        if (is_string($content)) {
            
            $content = json_decode($content, true);
        }
        $sections = HomePageSection::all()->mapWithKeys(function ($section) {
    $content = is_string($section->content) ? json_decode($section->content, true) : $section->content;

   

    return [$section->section_key => $content];
})->toArray();


        return [$section->section_key => $content];
    })->toArray();

     $allServices = Service::select('id', 'title')->get();

    
// Récupérer les projets sélectionnés
$projectIds = collect($sections['projects']['project_ids'] ?? [])
    ->filter(function ($id) {
        return Project::where('id', $id)->exists();
    })
    ->values()
    ->all();
   // dd($projectIds);

$projects = \App\Models\Project::with('images')
    ->whereIn('id', $projectIds)
    ->latest()
    ->get();



return Inertia::render('Admin/HomePage/edit', [
    'sections' => $sections,
    'AllProjects' => $projects,
    'allServices' => $allServices,
]);   

    }

    public function edit($sectionKey)
    {
        $section = HomePageSection::where('section_key', $sectionKey)->firstOrFail();
        
        return Inertia::render('Home/EditSection', [
            'section' => $section,
        ]);
    }




public function update(Request $request, $sectionKey)
{
   //dd($request->all(), $sectionKey, $request->project_ids);
if ($sectionKey === 'projects' && isset($data['project_ids'])) {
    $request['project_ids'] = array_values(
        \App\Models\Project::whereIn('id', $request['project_ids'])->pluck('id')->toArray()
    );
}
   try {
        // Validation
        $data = $this->getValidatedData($request, $sectionKey);

        // Logo
        foreach (['background_imageFile', 'imageFile'] as $fileField) {
    if ($request->hasFile($fileField) && $request->file($fileField)->isValid()) {
        $file = $request->file($fileField);
        $path = $file->store('uploads/homepage', 'public');

        // Ajouter la version finale dans $data
        if ($fileField === 'background_imageFile') {
            $data['background_image'] = asset("storage/$path");
        } else if ($fileField === 'imageFile') {
            $data['image'] = asset("storage/$path");
        }

        // Supprimer le champ file original
        unset($data[$fileField]);
    }
}

        // Slides (hero)
        if ($sectionKey === 'hero' && !empty($data['slides']) && is_array($data['slides'])) {
            foreach ($data['slides'] as &$slide) {
                if (!empty($slide['imageFile']) && $slide['imageFile'] instanceof \Illuminate\Http\UploadedFile) {
                    $file = $slide['imageFile'];
                    if ($file->isValid()) {
                        $path = $file->store('uploads/homepage', 'public');
                        $slide['background_image'] = asset("storage/$path");
                    }
                } else {
                    $slide['background_image'] = $slide['existingImage'] ?? null;
                }

                unset($slide['imageFile'], $slide['existingImage']);

                if (!empty($slide['background_image']) && str_starts_with($slide['background_image'], 'data:image')) {
                    unset($slide['background_image']);
                }
            }
            unset($slide);
        } else {
            $data = $this->processFilesRecursive($data, $request);
        }

        // Decode longDescription
        if (!empty($data['items']) && is_array($data['items'])) {
            foreach ($data['items'] as &$item) {
                if (!empty($item['longDescription'])) {
                    $item['longDescription'] = html_entity_decode(trim($item['longDescription']));
                }
            }
            unset($item);
        }

        // Sauvegarde en base
        HomePageSection::updateOrCreate(
            ['section_key' => $sectionKey],
            ['content' => json_encode($data, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE)]
        );

        return redirect()->back()->with('success', ucfirst($sectionKey) . ' section mise à jour !');

    } catch (\Illuminate\Validation\ValidationException $e) {
        // Erreurs de validation → Laravel les gère automatiquement
        return redirect()->back()->withErrors($e->validator)->withInput();
    } catch (\Throwable $e) {
        // Toute autre erreur
        \Log::error("Erreur lors de la mise à jour de la section {$sectionKey}: " . $e->getMessage());
        return redirect()->back()->with('error', 'Une erreur est survenue lors de la mise à jour. Veuillez réessayer.');
    }
}


private function processFilesRecursive(array $data, Request $request, $parentKey = '')
{
    foreach ($data as $key => &$value) {
        $fieldPath = $parentKey === '' ? $key : "$parentKey.$key";

        // Traitement récursif si c'est un tableau
        if (is_array($value)) {
            $value = $this->processFilesRecursive($value, $request, $fieldPath);
        }

        // Upload des fichiers
        if ($key === 'imageFile' && $request->hasFile($fieldPath)) {
            $file = $request->file($fieldPath);
            if ($file->isValid()) {
                $path = $file->store('uploads/homepage', 'public');

                // Accéder à la référence parent pour enregistrer background_image
                $parentKeys = explode('.', $fieldPath);
                array_pop($parentKeys);
                $parentRef = &$data;
                foreach ($parentKeys as $step) {
                    if (isset($parentRef[$step])) {
                        $parentRef = &$parentRef[$step];
                    }
                }
                $parentRef['background_image'] = asset("storage/$path");
            }
            unset($data[$key]);
        }

        // Supprimer les images en base64 si présentes
        if ($key === 'background_image' && is_string($value) && str_starts_with($value, 'data:image')) {
            unset($data[$key]);
        }
    }

    return $data;
}











   protected function getValidatedData(Request $request, string $sectionKey)
{
     switch ($sectionKey) {
       case 'hero':
    return $request->validate([
        'slides' => 'required|array|min:1',
        'slides.*.title' => 'nullable|string|max:255',
        'slides.*.subtitle' => 'nullable|string|max:500',
        'slides.*.button_text' => 'nullable|string|max:100',
        'slides.*.imageFile' => 'nullable|image|mimes:jpeg,avif,png,jpg,webp|max:20480',
        'slides.*.existingImage' => 'nullable|string|max:1000', // Pour conserver l'image existante si pas de nouveau upload
    ]);

       case 'howItWork':
    return $request->validate([
        'title' => 'required|string|max:255',
        'subtitle' => 'required|string|max:500',
        'steps' => 'required|array|size:3',
        'steps.*.icon' => 'required|string|max:10',
        'steps.*.title' => 'required|string|max:255',
        'steps.*.description' => 'required|string|max:500',
    ]);

          case 'services':
    return $request->validate([
        'title' => 'required|string|max:255',
        'subtitle' => 'nullable|string|max:500',
        'description' => 'nullable|string|max:2000',
        'services_ids' => 'nullable|array',
        'services_ids.*' => 'exists:services,id', // chaque ID doit exister
    ]);

        case 'testimonials':
            return $request->validate([
                'title' => 'required|string|max:255',
                'items' => 'required|array|min:1',
                'items.*.name' => 'required|string|max:100',
                'items.*.role' => 'required|string|max:500',
                'items.*.message' => 'nullable|string',
                'items.*.imageFile' => 'nullable|image|mimes:jpeg,png,jpg,webp|max:2048', // uniquement si fichier est uploadé

            ]);
       
        case 'whyChooseUs':
             return $request->validate([
                'imageFile' => 'nullable|image|mimes:jpeg,avif,png,jpg,webp|max:20480', // 20MB max
                'image' => 'nullable|string', // Pour conserver l'image existante si pas de nouveau upload
                'title' => 'nullable|string|max:255',
                'description' => 'nullable|string',
                'items' => 'nullable|array',
                'items.*.text' => 'required|string|max:255',
    ]);

case 'contact':
    return $request->validate([
        'fields_to_show' => 'nullable|array',
        'fields_to_show.*' => 'string|in:entreprise,email,phone,adress,logoFile,title,description,socials',
    ]);

        case 'aboutus':
            return $request->validate([
                'title' => 'required|string|max:255',
                'subtitle' => 'nullable|string|max:500',
                'long_description' => 'nullable|string',
                'imageFile' => 'nullable|image|mimes:jpeg,png,jpg,webp|max:2048', // 2MB max
            ]);
        case 'ParallaxStats':
    return $request->validate([
        'title' => 'required|string|max:255',
        'description' => 'nullable|string|max:1000',
        'badge' => 'nullable|string|max:255',

        // ✅ Image de fond et image décorative (avec AVIF)
        'background_imageFile' => 'nullable|file|mimes:jpeg,png,jpg,webp,avif|max:20480',
        'background_image' => 'nullable|string|max:1000', // Pour conserver l'image existante si pas de nouveau upload
        'imageFile' => 'nullable|file|mimes:jpeg,png,jpg,webp,avif|max:20480',
         'image' => 'nullable|string|max:1000', // Pour conserver l'image existante si pas de nouveau upload

        // ✅ Stats
        'stats' => 'nullable|array|min:1',
        'stats.*.value' => 'required_with:stats|string|max:100',
        'stats.*.label' => 'required_with:stats|string|max:255',
    ]);

        case 'projects':
    return $request->validate([
        'title' => 'nullable|string|max:255',
        'subtitle' => 'nullable|string|max:500',
        'description' => 'nullable|string|max:2000',
        'project_ids' => 'nullable|array',
        'project_ids.*' => 'exists:projects,id',
    ]);
     




        

        default:
            abort(404, 'Section inconnue');
    }
}
   
}
