<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Page extends Model
{
    protected $table = 'pages';
    protected $fillable = ['title', 'content', 'slug', 'meta_title', 'meta_description', 'meta_keywords'];
    public $timestamps = true;

    
}
