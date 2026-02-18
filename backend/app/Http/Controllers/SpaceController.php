<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Space;
use App\Events\SpaceStatusUpdated;


class SpaceController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Space::all();
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        try {
            $request->validate([
                'name' => 'required|string|max:255',
                'zone_id' => 'required|integer|exists:zones,id',
                'floor' => 'required|Integer',
                'coordinates' => 'required|array',
                'status' => 'required|string|in:unverified,verified',
            ]);
            $space = Space::create($request->all());
            return response()->json($space, 201);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['errors' => $e->errors()], 422);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(Space $space)
    {
        return $space;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Space $space)
    {
        $request->validate([
            'name' => 'sometimes|required|string|max:255',
            'zone_id' => 'sometimes|required|integer|exists:zones,id',
            'floor' => 'required|Integer',
            'coordinates' => 'sometimes|required|array',
            'status' => 'sometimes|required|string|in:unverified,verified',
        ]);
        $space->update($request->all());
        return response()->json($space, 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Space $space)
    {
        $space->delete();
        return response()->json(null, 204);
    }

    public function indexByFloor(Request $request)
    {
        $request->validate([
            'floor' => 'required|integer'
        ]);

        $spaces = Space::where('floor', $request->floor)->get();

        return response()->json($spaces);
    }

    public function indexByFloorAndZone(Request $request)
    {
        $request->validate([
            'floor' => 'required|integer',
            'zone_id' => 'required|integer|exists:zones,id'
        ]);

        $spaces = Space::where('floor', $request->floor)
            ->where('zone_id', $request->zone_id)
            ->get();

        return response()->json($spaces);
    }

    public function updateStatus(Request $request, Space $space)
    {
        $request->validate([
            'status' => 'required|in:verified,unverified',
        ]);

        $space->update([
            'status' => $request->status
        ]);
        return response()->json($space, 200);
    }

}
