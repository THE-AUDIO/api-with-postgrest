-- Active: 1703956512562@@127.0.0.1@5431
CREATE DATABASE theaudio;

\c theaudio;

CREATE SCHEMA IF NOT EXISTS api;

CREATE TYPE student_status AS ENUM ('active', 'desactive');
CREATE TYPE study_level AS ENUM ('L1', 'L2', 'L3');

CREATE TABLE IF NOT EXISTS api.foyers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS api.schools (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    acronyme VARCHAR(31),
    location VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS api.students (
    id SERIAL PRIMARY KEY,
    fistname VARCHAR(255) NOT NULL,
    lastname VARCHAR(255) NOT NULL,
    foyer_id INTEGER NOT NULL,
    level study_level NOT NULL,
    school_id INTEGER NOT NULL,
    status student_status NOT NULL DEFAULT 'active',
    CONSTRAINT fk_foyer_id_students FOREIGN KEY (foyer_id) REFERENCES api.foyers(id),
    CONSTRAINT fk_school_id_students FOREIGN KEY (school_id) REFERENCES api.schools(id)
);

CREATE ROLE anonyma nologin;
GRANT USAGE ON SCHEMA api TO anonyma;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA api TO anonyma;
