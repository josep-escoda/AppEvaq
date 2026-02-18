<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('evacuacions', function (Blueprint $table) {
            $table->id();
            $table->timestamp('iniciada')->useCurrent();
            $table->timestamp('finalitzada')->nullable();
            $table->boolean('activa')->default(true);
            $table->foreignId('iniciada_per')->constrained('usuaris')->onUpdate('cascade')->onDelete('restrict');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('evacuacions');
    }
};
