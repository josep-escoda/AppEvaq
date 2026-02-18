<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        // Users table
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('name', 100);
            $table->string('email', 120)->unique();
            $table->string('password');
            $table->enum('role', ['administrator', 'zone_responsible'])->default('administrator');
            $table->timestamps();
        });

        // Evacuations table
        Schema::create('evacuations', function (Blueprint $table) {
            $table->id();
            $table->timestamp('started_at')->useCurrent();
            $table->timestamp('ended_at')->nullable();
            $table->boolean('active')->default(true);
            $table->foreignId('started_by')->constrained('users')->onDelete('cascade');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('evacuations');
        Schema::dropIfExists('users');
    }
};
