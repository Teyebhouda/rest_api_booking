<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ServiceResource extends JsonResource
{
    public function toArray($request)
    {
        return [
            'id' => $this->id,
            'title' => $this->title,
            'slug' => $this->slug,
            'description' => $this->description,
            'long_description' => $this->long_description,
            'icon' => $this->icon,
            'background_image' => $this->background_image,
            'meta' => [
                'title' => $this->meta_title,
                'description' => $this->meta_description,
                'keywords' => $this->meta_keywords,
            ],
        ];
    }
}

