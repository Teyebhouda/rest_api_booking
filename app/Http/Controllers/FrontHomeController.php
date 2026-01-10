<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\HomePageSection;
use Inertia\Inertia;
use App\Models\Project;
use App\Models\Service;

class FrontHomeController extends Controller
{
     public function index()
{
    $sections = HomePageSection::all()->mapWithKeys(function ($section) {
        $content = $section->content;
        // Décoder si c'est une chaîne JSON
        if (is_string($content)) {
            $content = json_decode($content, true);
        }
        return [$section->section_key => ['content' => $content]];
    })->toArray();

    $pages = \App\Models\Page::all(['id', 'title', 'slug']);
     // Récupérer les IDs des services configurés dans la section "services"
    $servicesIds = $sections['services']['content']['services_ids'] ?? [];
//dd($servicesIds);
    // Si des IDs sont définis → on ne prend que ceux-ci
    $services = Service::query()
        ->when(!empty($servicesIds), function ($query) use ($servicesIds) {
            $query->whereIn('id', $servicesIds)
                  ->orderByRaw("FIELD(id, " . implode(',', $servicesIds) . ")");
        })
        ->get(['id', 'title', 'description','long_description', 'icon', 'background_image', 'meta_title', 'meta_description', 'meta_keywords', 'slug']);
//dd($services);
        
    $sections['services']['content']['items'] = $services;


    
       $projectIds = $sections['projects']['content']['project_ids'] ?? [];
   
$projects = Project::with('images')->whereIn('id', $projectIds)->get();
 $sections['projects']['content']['items'] = $projects;
//dd($projects);
//dd($projects);
    return Inertia::render('Front/Home', [
        'sections' => $sections,
        //'projectsData' => $projects,
        'footerPages' => $pages, 
    ]);
}

 public function contact()
{
    return Inertia::render('Front/Contact');


}
    
}
