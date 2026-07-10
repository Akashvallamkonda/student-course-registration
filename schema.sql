-- Student Course Registration System - Database Schema
-- Run this script in MySQL before starting the application

CREATE DATABASE IF NOT EXISTS scrs_db;
USE scrs_db;

-- Students Table
CREATE TABLE IF NOT EXISTS students (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    email       VARCHAR(100) NOT NULL UNIQUE,
    password    VARCHAR(255) NOT NULL,
    phone       VARCHAR(15),
    branch      VARCHAR(100),
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Courses Table
CREATE TABLE IF NOT EXISTS courses (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    title       VARCHAR(150) NOT NULL,
    description TEXT,
    instructor  VARCHAR(100),
    duration    INT COMMENT 'Duration in weeks',
    seats       INT DEFAULT 30
);

-- Enrollments Table
CREATE TABLE IF NOT EXISTS enrollments (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    student_id  INT NOT NULL,
    course_id   INT NOT NULL,
    enrolled_on DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id)  REFERENCES courses(id)  ON DELETE CASCADE,
    UNIQUE KEY unique_enrollment (student_id, course_id)
);

-- Sample Course Data
INSERT INTO courses (title, description, instructor, duration, seats) VALUES
('Core Java Programming',    'Learn Java fundamentals: OOP, Collections, Exception Handling', 'Dr. Ravi Kumar',  8, 30),
('Spring Boot & REST APIs',  'Build backend services using Spring Boot, JPA and REST API',    'Prof. Sneha Rao',  6, 25),
('MySQL Database Design',    'Relational database design, SQL queries and optimisation',      'Mr. Arjun Reddy',  4, 35),
('Web Dev with HTML/CSS/JS', 'Frontend basics: HTML5, CSS3, JavaScript and DOM manipulation', 'Ms. Priya Nair',   5, 40),
('Git & GitHub Essentials',  'Version control with Git, branching, merging and GitHub',       'Mr. Kiran Babu',   2, 50);
