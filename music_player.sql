CREATE SCHEMA IF NOT EXISTS "public";

CREATE TABLE "public"."users_tracks" (
    "id" bigserial NOT NULL UNIQUE,
    "track_id" bigint NOT NULL,
    "user_id" bigint NOT NULL,
    PRIMARY KEY ("track_id", "user_id")
);

CREATE TABLE "public"."play_history" (
    "id" bigserial NOT NULL,
    "user_id" bigint NOT NULL,
    "track_id" bigint NOT NULL,
    "played_at" timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("id")
);

CREATE TABLE "public"."tracks" (
    "id" bigserial NOT NULL,
    "track_name" text,
    "file_path" text,
    "duration" int,
    "created_at" timestamp,
    PRIMARY KEY ("id")
);

CREATE TABLE "public"."users" (
    "id" bigserial NOT NULL,
    "username" text,
    "password" varchar(255),
    "created_at" timestamp,
    PRIMARY KEY ("id")
);

CREATE TABLE "public"."sessions" (
    "id" bigserial NOT NULL,
    "user_id" bigint NOT NULL,
    "is_active" boolean DEFAULT true,
    "created_at" timestamp DEFAULT CURRENT_TIMESTAMP,
    "last_login" timestamp,
    PRIMARY KEY ("id")
);

-- Foreign key constraints
-- Schema: public
ALTER TABLE "public"."users_tracks" ADD CONSTRAINT "fk_users_tracks_track_id_tracks_id" FOREIGN KEY("track_id") REFERENCES "public"."tracks"("id");
ALTER TABLE "public"."play_history" ADD CONSTRAINT "fk_play_history_track_id_tracks_id" FOREIGN KEY("track_id") REFERENCES "public"."tracks"("id");
ALTER TABLE "public"."users_tracks" ADD CONSTRAINT "fk_users_tracks_user_id_users_id" FOREIGN KEY("user_id") REFERENCES "public"."users"("id");
ALTER TABLE "public"."sessions" ADD CONSTRAINT "fk_sessions_user_id_users_id" FOREIGN KEY("user_id") REFERENCES "public"."users"("id");
ALTER TABLE "public"."play_history" ADD CONSTRAINT "fk_play_history_user_id_users_id" FOREIGN KEY("user_id") REFERENCES "public"."users"("id");