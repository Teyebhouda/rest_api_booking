<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Page;
use App\Http\Resources\PageResource;
use Illuminate\Http\Request;

class PageApiController extends Controller
{
    /**
     * Afficher une page par slug (front API)
     * GET /api/pages/{slug}
     */
    public function show(string $slug)
    {
        $page = Page::where('slug', $slug)->firstOrFail();

        return response()->json([
            'page' => new PageResource($page),
            'seo' => [
                'title' => $page->meta_title ?? $page->title,
                'description' => $page->meta_description 
                    ?? mb_substr(strip_tags($page->content), 0, 160),
                'keywords' => $page->meta_keywords ?? '',
            ],
        ]);
    }

    /**
     * (Optionnel) Liste des pages (footer, menu, etc.)
     * GET /api/pages
     */
    public function index()
    {
        return PageResource::collection(
            Page::select(
                'id',
                'title',
                'slug',
                'content',
                'meta_title',
                'meta_description',
                'meta_keywords'
            )->get()
        );
    }
}
