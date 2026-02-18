<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('usuaris', function (Blueprint $table) {
            $table->renameColumn('contrasenya_hash', 'password');
            $table->renameColumn('rol', 'role');
        });
    }

    public function down(): void
    {
        Schema::table('usuaris', function (Blueprint $table) {
            $table->renameColumn('password', 'contrasenya_hash');
            $table->renameColumn('role', 'rol');
        });
    }
};
