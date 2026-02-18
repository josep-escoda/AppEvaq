<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Zone;

class ZoneController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Zone::all();
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
        ]);
        $zone = Zone::create($request->all());
        return response()->json($zone, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(Zone $zone)
    {
        return $zone;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Zone $zone)
    {
        $request->validate([
            'name' => 'sometimes|required|string|max:255',
        ]);
        $zone->update($request->all());
        return response()->json($zone, 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Zone $zone)
    {
        $zone->delete();
        return response()->json(null, 204);
    }
}
