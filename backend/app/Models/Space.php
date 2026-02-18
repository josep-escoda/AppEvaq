<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Space extends Model
{
    protected $fillable = [
        'name',
        'zone_id',
        'floor',
        'coordinates',
        'status'
    ];

    protected $casts = [
        'coordinates' => 'array', 
    ];

    public function zone()
    {
        return $this->belongsTo(Zone::class);
    }
}
