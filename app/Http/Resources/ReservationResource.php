<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ReservationResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'status' => $this->status,
            'note' => $this->note,
            'check_in' => $this->check_in?->toDateTimeString(),
            'check_out' => $this->check_out?->toDateTimeString(),

            'client' => [
                'name' => $this->name,
                'email' => $this->email,
                'phone' => $this->phone,
            ],

            'service' => [
                'id' => $this->service?->id,
                'title' => $this->service?->title,
                'slug' => $this->service?->slug,
            ],
        ];
    }
}
