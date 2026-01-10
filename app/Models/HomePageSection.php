<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HomePageSection extends Model
{
    protected $table = 'home_page_section';

    protected $fillable = [
        'section_key',
        'content',
    ];

    protected $casts = [
        'content' => 'array',
    ];

     public static function getContentByKey($key)
    {
        return self::where('section_key', $key)->first()?->content;
    }


    public function getContentAttribute($value)
{
    return json_decode($value, true);
}
    
}
