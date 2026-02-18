<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('evacuations', function (Blueprint $table) {
            // Primero elimina la foreign key si existe
            $table->dropForeign(['started_by']);
        });

        Schema::table('evacuations', function (Blueprint $table) {
            // Cambia el tipo de columna a unsignedBigInteger
            $table->unsignedBigInteger('started_by')->change();
            
            // Crea la foreign key
            $table->foreign('started_by')
                  ->references('id')
                  ->on('users')
                  ->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::table('evacuations', function (Blueprint $table) {
            $table->dropForeign(['started_by']);
        });
    }
};