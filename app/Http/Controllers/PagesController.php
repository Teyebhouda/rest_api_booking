<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Page;
use Inertia\Inertia;

class PagesController extends Controller
{ 
    public function index()
    {
        // Logique pour récupérer les pages depuis la base de données
        $pages = \App\Models\Page::all();
        return inertia('Admin/Pages/Index', ['pages' => $pages]);   

    }
    public function edit($pageId)
    {
        $page = \App\Models\Page::findOrFail($pageId);
        return inertia('Admin/Pages/Edit', ['page' => $page]);
    }
    public function update(Request $request, $pageId)
    {
        $page = \App\Models\Page::findOrFail($pageId);

        $validatedData = $request->validate([
            'title' => 'required|string|max:255',
            'slug' => 'required|string|max:255|unique:pages,slug,' . $page->id,
            'content' => 'required|string',
            'meta_title' => 'nullable|string|max:255',
            'meta_description' => 'nullable|string|max:1000',
            'meta_keywords' => 'nullable|string|max:1000',
        ]);
         // Décode les entités HTML si besoin
    $validatedData['content'] = html_entity_decode($validatedData['content']);

        $page->update($validatedData);

        return redirect()->route('pages')->with('success', 'Page mise à jour avec succès.');
    }
    public function create()
    {
        return inertia('Admin/Pages/Create');
    }
  public function store(Request $request)
{
    $validatedData = $request->validate([
        'title' => 'required|string|max:255',
        'content' => 'required|string',
        'slug' => 'required|string|max:255|unique:pages,slug',
        'meta_title' => 'nullable|string|max:255',
        'meta_description' => 'nullable|string|max:1000',
        'meta_keywords' => 'nullable|string|max:1000',
    ]);

 // Décode les entités HTML si besoin
    $validatedData['content'] = html_entity_decode($validatedData['content']);  
    Page::create($validatedData);

    return redirect()->route('pages')->with('success', 'Page créée avec succès.');
}

    public function destroy($pageId)
    {
        $page = \App\Models\Page::findOrFail($pageId);
        $page->delete();

        return redirect()->route('pages')->with('success', 'Page supprimée avec succès.');
    }


     public function show($slug)
    {
        $page = Page::where('slug', $slug)->firstOrFail();

        return Inertia::render('Front/Page', [
            'page' => $page,
             'seo' => [
                'title' => $page->meta_title ?? $page->title,
                'description' => $page->meta_description ?? substr(strip_tags($page->content), 0, 160),
                'keywords' => $page->meta_keywords ?? '',
            ],
        ]);
    }
}
