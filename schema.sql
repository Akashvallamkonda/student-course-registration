-- Student Course Registration System - PostgreSQL Schema
-- Run this script before starting the application:
-- psql -U postgres -f schema.sql

CREATE DATABASE scrs_db;
\c scrs_db;

-- Students Table
CREATE TABLE IF NOT EXISTS students (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(100)        NOT NULL,
    email       VARCHAR(100)        NOT NULL UNIQUE,
    password    VARCHAR(255)        NOT NULL,
    phone       VARCHAR(15),
    branch      VARCHAR(100),
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Courses Table
CREATE TABLE IF NOT EXISTS courses (
    id          SERIAL PRIMARY KEY,
    title       VARCHAR(150)        NOT NULL,
    description TEXT,
    instructor  VARCHAR(100),
    duration    INT,                            -- duration in weeks
    seats       INT DEFAULT 30
);

-- Enrollments Table
CREATE TABLE IF NOT EXISTS enrollments (
    id          SERIAL PRIMARY KEY,
    student_id  INT         NOT NULL REFERENCES students(id) ON DELETE CASCADE,
    course_id   INT         NOT NULL REFERENCES courses(id)  ON DELETE CASCADE,
    enrolled_on TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (student_id, course_id)
);

-- Sample Course Data
INSERT INTO courses (title, description, instructor, duration, seats) VALUES
('Core Java Programming',    'Learn Java fundamentals: OOP, Collections, Exception Handling', 'Dr. Ravi Kumar',  8, 30),
('Spring Boot & REST APIs',  'Build backend services using Spring Boot, JPA and REST API',    'Prof. Sneha Rao',  6, 25),
('PostgreSQL Database',      'Relational database design, SQL queries and optimisation',      'Mr. Arjun Reddy',  4, 35),
('Web Dev with HTML/CSS/JS', 'Frontend basics: HTML5, CSS3, JavaScript and DOM manipulation', 'Ms. Priya Nair',   5, 40),
('Git & GitHub Essentials',  'Version control with Git, branching, merging and GitHub',       'Mr. Kiran Babu',   2, 50);
