<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('responsible_tokens', function (Blueprint $table) {
            $table->id();
            $table->string('email');
            $table->unsignedBigInteger('zone_id');
            $table->string('token', 100)->unique();
            $table->dateTime('expires_at')->nullable();
            $table->boolean('used')->default(false);
            $table->timestamps();

            // Optional: foreign key if zones exist
            // $table->foreign('zone_id')->references('id')->on('zones')->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('responsible_tokens');
    }
};
    