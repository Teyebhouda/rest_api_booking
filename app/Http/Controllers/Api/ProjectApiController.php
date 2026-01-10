<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\ProjectResource;
use App\Models\Project;
use App\Models\HomePageSection;
use App\Models\Service;
use Illuminate\Http\Request;

class ProjectApiController extends Controller
{
    /**
     * Récupère tous les projets liés à la homepage
     */
    private function getHomepageProjects()
    {
        $sections = HomePageSection::all()->mapWithKeys(function ($section) {
            $content = $section->content;
            if (is_string($content)) {
                $content = json_decode($content, true);
            }
            return [$section->section_key => ['content' => $content]];
        })->toArray();

        $projectIds = $sections['projects']['content']['project_ids'] ?? [];
        return Project::with('images')->whereIn('id', $projectIds)->get();
    }

    /**
     * Liste des projets
     */
    public function index()
    {
        $projects = $this->getHomepageProjects();

        return response()->json([
            'success' => true,
            'data' => ProjectResource::collection($projects),
        ]);
    }

    /**
     * Détails d’un projet par slug
     */
    public function show($slug)
    {
        $project = Project::with('images')->where('slug', $slug)->firstOrFail();

        $projects = $this->getHomepageProjects(); // pour éventuellement afficher d'autres projets
        $services = Service::all(['id', 'title', 'slug', 'description', 'icon']);

        return response()->json([
            'success' => true,
            'data' => new ProjectResource($project),
            'projectsData' => ProjectResource::collection($projects),
            'services' => $services,
        ]);
    }
}
