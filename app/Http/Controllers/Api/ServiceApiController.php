<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Service;
use App\Http\Resources\ServiceResource;
use Illuminate\Support\Str;

class ServiceApiController extends Controller
{
    /**
     * GET /api/services
     * Liste des services (front)
     */
    public function index()
    {
        $services = Service::query()
            ->orderBy('id')
            ->get();

        return response()->json([
            'data' => ServiceResource::collection($services)
        ]);
    }

    /**
     * GET /api/services/{slug}
     * Détail d’un service
     */
    public function show(string $slug)
    {
        $service = Service::where('slug', $slug)
            ->firstOrFail();

        return response()->json([
            'data' => new ServiceResource($service),
            'seo' => [
                'title' => $service->meta_title ?? $service->title,
                'description' => $service->meta_description
                    ?? Str::limit(strip_tags($service->description), 160),
                'keywords' => $service->meta_keywords ?? '',
            ]
        ]);
    }
}
