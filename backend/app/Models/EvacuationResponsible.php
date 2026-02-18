<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class EvacuationResponsible extends Model
{
    protected $fillable = [
        "evacuation_id",
        "zone_id",
        "email",
        "name",
        "created_at",
        "updated_at"
    ];

    protected $casts = [
        "created_at" => "datetime",
        "updated_at"=> "datetime"
    ];


}
