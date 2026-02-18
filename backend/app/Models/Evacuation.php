<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Evacuation extends Model
{
   protected $fillable = [
        'started_at',
        'ended_at',
        'active',
        'started_by',
        'unverified_spaces_count',
    ];

    protected $casts = [
        'active' => 'boolean',
        'ended_at' => 'datetime',
        'unverified_spaces_count' => 'integer',
    ];
}
