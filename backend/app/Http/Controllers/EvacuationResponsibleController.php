<?php

namespace App\Http\Controllers;

use App\Models\Evacuation;
use App\Models\EvacuationResponsible;
use Illuminate\Http\Request;

class EvacuationResponsibleController extends Controller
{
    public function index()
    {
        return EvacuationResponsible::all();
    }

    public function store(Request $request)
    {
        try {
            $request->validate([
                'zone_id' => 'required|integer|exists:zones,id',
                'name' => 'required|string|max:255',
                'email' => 'nullable|string|email|max:255',
            ]);

            $active = Evacuation::where('active', 1)->first();

            if (!$active) {
                return response()->json([
                    'error' => 'No hi ha cap evacuació activa'
                ], 400);
            }

            $existing = EvacuationResponsible::where('evacuation_id', $active->id)
                ->where('zone_id', $request->zone_id)
                ->where('name', $request->name)
                ->first();

            if ($existing) {
                return response()->json([
                    'message' => 'Responsable ja registrat',
                    'data' => $existing,
                    'existing' => true
                ], 200);
            }

            $responsible = EvacuationResponsible::create([
                'evacuation_id' => $active->id,
                'zone_id' => $request->zone_id,
                'name' => $request->name,
                'email' => $request->email, 
            ]);

            return response()->json([
                'message' => 'Responsable registrat correctament',
                'data' => $responsible,
                'existing' => false
            ], 201);

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['errors' => $e->errors()], 422);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Error al registrar el responsable',
                'message' => $e->getMessage()
            ], 500);
        }
    }

    public function show(EvacuationResponsible $responsable)
    {
        return $responsable;
    }

    public function update(Request $request, EvacuationResponsible $responsable)
    {
        $request->validate([
            'zone_id' => 'integer|exists:zones,id',
            'name' => 'string|max:255',
            'email' => 'nullable|string|email|max:255',
        ]);

        $responsable->update($request->all());

        return response()->json($responsable, 200);
    }

    public function destroy(EvacuationResponsible $responsable)
    {
        $responsable->delete();

        return response()->json(null, 204);
    }
}