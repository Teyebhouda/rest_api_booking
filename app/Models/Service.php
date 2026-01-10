<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Service extends Model
{
     protected $fillable = ['title', 'description', 'long_description', 'icon', 'background_image', 'meta_title', 'meta_description', 'meta_keywords', 'slug'];
}
