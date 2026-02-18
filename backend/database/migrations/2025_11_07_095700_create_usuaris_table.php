<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('usuaris', function (Blueprint $table) {
            $table->id();
            $table->string('nom', 100);
            $table->string('correu', 120)->unique();
            $table->string('contrasenya_hash', 255);
            $table->enum('rol', ['administrador', 'responsable_zona'])->default('responsable_zona');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('usuaris');
    }
};
