<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::table('evacuations', function (Blueprint $table) {
            $table->unsignedInteger('unverified_spaces_count')
                ->default(0)
                ->after('ended_at');
        });
    }

    public function down()
    {
        Schema::table('evacuations', function (Blueprint $table) {
            $table->dropColumn('unverified_spaces_count');
        });
    }

};
