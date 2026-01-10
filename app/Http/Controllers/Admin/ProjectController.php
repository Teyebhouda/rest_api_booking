<?php
namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Project;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use App\Models\HomePageSection;
use App\Models\Service;

class ProjectController extends Controller
{
    public function index()
    {
        $projects = Project::with('images')->latest()->get();

        return Inertia::render('Admin/Projects/Index', [
            'projects' => $projects,
        ]);
    }

    public function create()
    {
        return Inertia::render('Admin/Projects/Create');
    }

    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'content' => 'nullable|string',
            'location' => 'nullable|string|max:255',
            'date' => 'nullable|date',
            'images.*' => 'file|mimes:jpeg,png,jpg,avif,webp|max:20480',

        ]);
        $request['slug'] = Str::slug($request['title']);
         // Décode les entités HTML si besoin
    $request['content'] = html_entity_decode($request['content']);

        $project = Project::create($request->only(['title', 'description', 'content', 'location', 'date','slug','meta_title','meta_description','meta_keywords']));

        if ($request->hasFile('images')) {
            foreach ($request->file('images') as $file) {
                $path = $file->store('projects', 'public');
                $project->images()->create(['path' => $path]);
            }
        }

        return redirect()->route('projects.index')->with('success', 'Projet créé avec succès');
    }

   

    public function edit(Project $project)
    {
        $project->load('images');
        return Inertia::render('Admin/Projects/Edit', [
            'project' => $project,
        ]);
    }

  public function update(Request $request, Project $project)
{
    $request->validate([
        'title' => 'required|string|max:255',
        'description' => 'nullable|string',
        'content' => 'nullable|string',
        'location' => 'nullable|string|max:255',
        'date' => 'nullable|date',
        'images.*' => 'file|mimes:jpeg,png,jpg,webp,avif|max:20480',
        'removed_images' => 'array',
        'removed_images.*' => 'integer',
        'meta_title' => 'nullable|string|max:255',
        'meta_description' => 'nullable|string|max:1000',
        'meta_keywords' => 'nullable|string|max:1000',


    ]);
    $request['slug'] = Str::slug($request['title']);
     $request['content'] = html_entity_decode($request['content']);
    // ✅ Mettre à jour les champs du projet
    $project->update($request->only(['title', 'description','slug', 'content', 'location', 'date','meta_title','meta_description','meta_keywords']));

 

    // ✅ Supprimer les images retirées par l’utilisateur
    if ($request->has('removed_images')) {
        foreach ($request->removed_images as $id) {
            $img = $project->images()->find($id);
            if ($img) {
                Storage::disk('public')->delete($img->path);
                $img->delete();
            }
        }
    }

    // ✅ Ajouter les nouvelles images
    if ($request->hasFile('images')) {
        foreach ($request->file('images') as $file) {
            $path = $file->store('projects', 'public');
            $project->images()->create(['path' => $path]);
        }
    }

    return redirect()->route('projects.index')->with('success', 'Projet mis à jour');
}

    public function destroy(Project $project)
    {
        $project->delete();
        return redirect()->route('projects.index')->with('success', 'Projet supprimé');
    }
    public function apiIndex()
{
    $projects = Project::select('id', 'title')->latest()->get();
    return response()->json([
        'projects' => $projects,
    ]);
}
    public function frontIndex()
{
    $sections = HomePageSection::all()->mapWithKeys(function ($section) {
        $content = $section->content;
        // Décoder si c'est une chaîne JSON
        if (is_string($content)) {
            $content = json_decode($content, true);
        }
        return [$section->section_key => ['content' => $content]];
    })->toArray();

     $projectIds = $sections['projects']['content']['project_ids'] ?? [];
$projects = Project::with('images')->whereIn('id', $projectIds)->get();
        $footer = HomePageSection::where('section_key', 'footer')->first();


    return Inertia::render('Front/Projects/Index', [
        'projectsData' => $projects,
         'footer' => $footer,
           // ✅ SEO dynamique
        'seo' => [
            'meta_title' => 'Nos Projets',
            'meta_description' => 'Découvrez nos projets réalisés, illustrant notre expertise et notre engagement envers la qualité et la satisfaction client.',
            'meta_keywords' => 'projets, réalisations, construction, rénovation, expertise, qualité, satisfaction client',
        ],
    ]);

}
    public function frontShow($id)
{
     $sections = HomePageSection::all()->mapWithKeys(function ($section) {
        $content = $section->content;
        // Décoder si c'est une chaîne JSON
        if (is_string($content)) {
            $content = json_decode($content, true);
        }
        return [$section->section_key => ['content' => $content]];
    })->toArray();

     $projectIds = $sections['projects']['content']['project_ids'] ?? [];
$projects = Project::with('images')->whereIn('id', $projectIds)->get();
    $project = Project::with('images')->findOrFail($id);
    return Inertia::render('Front/Projects/Show', [
        'project' => $project,
       'projectsData' => $projects,
    ]);
}
    public function Show($slug)
{
   // dd($slug);
     $sections = HomePageSection::all()->mapWithKeys(function ($section) {
        $content = $section->content;
        // Décoder si c'est une chaîne JSON
        if (is_string($content)) {
            $content = json_decode($content, true);
        }
        return [$section->section_key => ['content' => $content]];
    })->toArray();

     $projectIds = $sections['projects']['content']['project_ids'] ?? [];
$projects = Project::with('images')->whereIn('id', $projectIds)->get();
    $project = Project::with('images')->where('slug', $slug)->firstOrFail();
        $footer = HomePageSection::where('section_key', 'footer')->first();
         // ✅ Récupérer tous les services pour la liste
    $services = Service::all(['id', 'title', 'slug', 'description', 'icon'])->toArray();


    return Inertia::render('Front/Projects/Show', [
        'project' => $project,
        'sections' => [
            'services' => ['content' => ['items' => $services]],
            'footer' => ['content' => $footer ? json_decode($footer->content, true) : []],
        ],
       'projectsData' => $projects,
           // ✅ SEO dynamique
        'seo' => [
            'meta_title' => $project->meta_title ?? $project->title,
            'meta_description' => $project->meta_description ?? Str::limit(strip_tags($project->description), 150),
            'meta_keywords' => $project->meta_keywords ?? '',
        ],
    ]);
}
}
