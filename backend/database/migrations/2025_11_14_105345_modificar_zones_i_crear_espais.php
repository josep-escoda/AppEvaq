<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Modify zones table
        Schema::table('zones', function (Blueprint $table) {
            // Drop columns no longer needed
            $table->dropColumn(['coordenades', 'estat']);
        });

        // Create spaces table
        Schema::create('spaces', function (Blueprint $table) {
            $table->id();
            $table->string('name', 100);
            $table->foreignId('zone_id')->constrained('zones')->onDelete('cascade');
            $table->json('coordinates')->nullable(); // relative coordinates (0-1)
            $table->enum('status', ['unverified', 'verified'])->default('unverified');
            $table->timestamps(); // created_at & updated_at
        });
    }

    public function down(): void
    {
        // Revert changes
        Schema::dropIfExists('spaces');

        Schema::table('zones', function (Blueprint $table) {
            $table->json('coordinates')->nullable();
            $table->enum('status', ['unverified','verified'])->default('unverified');
        });
    }
};
