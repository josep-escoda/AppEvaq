<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Evacuation;
use Illuminate\Support\Facades\DB;


class EvacuationController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Evacuation::all();
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        Evacuation::where('active', true)->update([
            'active' => false,
            'ended_at' => now(),
        ]);

        $evacuation = Evacuation::create([
            'active' => true,
            'started_at' => now(),
            'ended_at' => null,
            'started_by' => auth()->check() ? auth()->id() : null,
        ]);

        return response()->json($evacuation, 201);
    }


    /**
     * Display the specified resource.
     */
    public function show(Evacuation $evacuation)
    {
        return $evacuation;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Evacuation $evacuation)
    {
        $request->validate([
            'ended_at' => 'sometimes|nullable|date',
            'active' => 'sometimes|required|boolean',
            'started_by' => 'required|integer|exists:users,id',
        ]);
        $evacuation->update($request->all());
        return response()->json($evacuation, 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Evacuation $evacuation)
    {
        $evacuation->delete();
        return response()->json(null, 204);
    }

    public function stopEvacuation()
    {
        $evacuation = Evacuation::where('active', true)->latest()->first();

        if (!$evacuation) {
            return response()->json(['message' => 'No active evacuation'], 404);
        }

        $unverifiedCount = DB::table('spaces')
            ->where('status', 'unverified')
            ->count();

        $evacuation->update([
            'active' => false,
            'ended_at' => now(),
            'unverified_spaces_count' => $unverifiedCount,
        ]);

        DB::table('spaces')->update([
            'status' => 'unverified'
        ]);



        return response()->json($evacuation, 200);
    }

    public function active()
    {
        $evacuation = Evacuation::where('active', true)
            ->latest('started_at')
            ->first();

        return response()->json($evacuation, 200);
    }


}
