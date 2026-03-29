<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\HomePageSection;
use App\Models\Project;
use App\Models\Service;
use App\Models\Page;

use App\Http\Resources\ServiceResource;
use App\Http\Resources\ProjectResource;
use App\Http\Resources\PageResource;

class HomeApiController extends Controller
{
   public function index()
{
    // Sections dynamiques
    $sections = HomePageSection::all()->mapWithKeys(function ($section) {
        $content = $section->content;

        if (is_string($content)) {
            $content = json_decode($content, true);
        }

        return [
            $section->section_key => [
                'content' => $content
            ]
        ];
    })->toArray();

    // Footer pages
    $footerPages = PageResource::collection(
        Page::select('id', 'title', 'slug', 'meta_title', 'meta_description', 'meta_keywords')->get()
    );

    // Services section
    $servicesIds = $sections['services']['content']['services_ids'] ?? [];

    $services = Service::query()
        ->when(!empty($servicesIds), function ($query) use ($servicesIds) {
            $query->whereIn('id', $servicesIds)
                  ->orderByRaw("FIELD(id, " . implode(',', $servicesIds) . ")");
        })
        ->get();
      
    $sections['services']['content']['items'] = ServiceResource::collection($services);

    // Projects section
    $projectIds = $sections['projects']['content']['project_ids'] ?? [];

    $projects = Project::with('images')
        ->whereIn('id', $projectIds)
        ->get();

    $sections['projects']['content']['items'] = ProjectResource::collection($projects);

    // RESPONSE API
    return response()->json([
        'sections' => $sections,
        'footerPages' => $footerPages,
    ]);
}

}
