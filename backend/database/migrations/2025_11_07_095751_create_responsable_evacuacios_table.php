<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('responsables_evacuacio', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_evacuacio')->constrained('evacuacions')->onUpdate('cascade')->onDelete('cascade');
            $table->foreignId('id_zona')->constrained('zones')->onUpdate('cascade')->onDelete('cascade');
            $table->string('correu', 120);
            $table->string('nom', 100)->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('responsables_evacuacio');
    }
};
