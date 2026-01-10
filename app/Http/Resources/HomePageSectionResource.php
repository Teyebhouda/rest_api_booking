<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;


class HomePageSectionResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'key' => $this->section_key,
            'content' => $this->content,
        ];
    }
}

