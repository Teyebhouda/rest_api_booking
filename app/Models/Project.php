<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Project extends Model
{
  protected $fillable = ['title', 'description', 'content', 'location', 'date', 'meta_title', 'meta_description', 'meta_keywords', 'slug'];

    public function images()
    {
        return $this->hasMany(ProjectImage::class);
    }
}
