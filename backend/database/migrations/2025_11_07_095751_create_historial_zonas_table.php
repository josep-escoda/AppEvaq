<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('historial_zones', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_zona')->constrained('zones')->onUpdate('cascade')->onDelete('cascade');
            $table->foreignId('id_evacuacio')->constrained('evacuacions')->onUpdate('cascade')->onDelete('cascade');
            $table->string('correu_responsable', 120);
            $table->enum('estat', ['no_verificada', 'verificada']);
            $table->timestamp('canviada_el')->useCurrent();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('historial_zones');
    }
};
