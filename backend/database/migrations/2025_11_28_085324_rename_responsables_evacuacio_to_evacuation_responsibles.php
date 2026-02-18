<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // 1. Rename table
        Schema::rename('responsables_evacuacio', 'evacuation_responsibles');

        // 2. Rename columns
        Schema::table('evacuation_responsibles', function (Blueprint $table) {
            $table->renameColumn('id_evacuacio', 'evacuation_id');
            $table->renameColumn('id_zona', 'zone_id');
            $table->renameColumn('correu', 'email');
            $table->renameColumn('nom', 'name');
        });

        // 3. Modify data fields (must be separate)
        Schema::table('evacuation_responsibles', function (Blueprint $table) {
            $table->string('email', 120)->nullable()->change();
            $table->string('name', 100)->nullable(false)->change();

            // Drop old FKs if names are known — if not, skip
            // (safe version: just recreate on top)

            // 4. Add foreign keys (safe version)
            $table->foreign('evacuation_id')
                ->references('id')->on('evacuations')
                ->onDelete('cascade');

            $table->foreign('zone_id')
                ->references('id')->on('zones')
                ->onDelete('cascade');
        });
    }

    public function down(): void
    {
        // Reverse foreign keys
        Schema::table('evacuation_responsibles', function (Blueprint $table) {
            $table->dropForeign(['evacuation_id']);
            $table->dropForeign(['zone_id']);
        });

        // Reverse field changes
        Schema::table('evacuation_responsibles', function (Blueprint $table) {
            $table->string('email', 120)->nullable(false)->change();
            $table->string('name', 100)->nullable()->change();

            $table->renameColumn('evacuation_id', 'id_evacuacio');
            $table->renameColumn('zone_id', 'id_zona');
            $table->renameColumn('email', 'correu');
            $table->renameColumn('name', 'nom');
        });

        // Reverse table rename
        Schema::rename('evacuation_responsibles', 'responsables_evacuacio');
    }
};