-- ===============================================
-- STUDENT RECORDS MANAGEMENT SYSTEM (MySQL)
-- Created by: Lawrence Jembe
-- Description: Complete DB creation with sample data
-- ===============================================

-- Create the database
DROP DATABASE IF EXISTS student_records_db;
CREATE DATABASE student_records_db;
USE student_records_db;

-- ===============================
-- Table: Department
-- ===============================
CREATE TABLE Department (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL UNIQUE
);

-- Sample Departments
INSERT INTO Department (dept_name) VALUES
('Computer Science'),
('Business Administration'),
('Electrical Engineering'),
('Nursing'),
('Education');

-- ===============================
-- Table: Lecturer
-- ===============================
CREATE TABLE Lecturer (
    lecturer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

-- Sample Lecturers
INSERT INTO Lecturer (full_name, email, dept_id) VALUES
('Dr. Emily Mwangi', 'emily@zetech.ac.ke', 1),
('Prof. James Kimani', 'jkimani@zetech.ac.ke', 2),
('Dr. Alice Njeri', 'anjeri@zetech.ac.ke', 3),
('Mr. Tom Mwaura', 'tom@zetech.ac.ke', 1),
('Dr. Sarah Wanja', 'wanja@zetech.ac.ke', 4);

-- ===============================
-- Table: Student
-- ===============================
CREATE TABLE Student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    reg_no VARCHAR(50) NOT NULL UNIQUE,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) UNIQUE,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

-- Sample Students
INSERT INTO Student (full_name, reg_no, gender, date_of_birth, email, dept_id) VALUES
('Lawrence Jembe', 'CS2023001', 'Male', '2001-08-05', 'lawrence@zetech.ac.ke', 1),
('Grace Akinyi', 'BA2023002', 'Female', '2002-02-14', 'grace@zetech.ac.ke', 2),
('Kevin Otieno', 'EE2023003', 'Male', '2000-10-20', 'kevin@zetech.ac.ke', 3),
('Diana Wambui', 'CS2023004', 'Female', '2001-05-18', 'diana@zetech.ac.ke', 1),
('Brian Mutua', 'CS2023005', 'Male', '2003-04-21', 'brian@zetech.ac.ke', 1),
('Faith Chelangat', 'NU2023006', 'Female', '1999-12-12', 'faith@zetech.ac.ke', 4),
('Samuel Kariuki', 'ED2023007', 'Male', '2001-01-01', 'samuel@zetech.ac.ke', 5),
('Cynthia Naliaka', 'BA2023008', 'Female', '2002-03-22', 'cynthia@zetech.ac.ke', 2),
('George Owino', 'EE2023009', 'Male', '2000-07-07', 'george@zetech.ac.ke', 3),
('Janet Mumo', 'NU2023010', 'Female', '2001-11-11', 'janet@zetech.ac.ke', 4);

-- ===============================
-- Table: Course
-- ===============================
CREATE TABLE Course (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    course_name VARCHAR(100) NOT NULL,
    credit_hours INT NOT NULL,
    dept_id INT,
    lecturer_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id),
    FOREIGN KEY (lecturer_id) REFERENCES Lecturer(lecturer_id)
);

-- Sample Courses
INSERT INTO Course (course_code, course_name, credit_hours, dept_id, lecturer_id) VALUES
('CS101', 'Introduction to Programming', 3, 1, 1),
('CS102', 'Database Systems', 4, 1, 4),
('BA201', 'Principles of Management', 3, 2, 2),
('EE301', 'Digital Circuits', 4, 3, 3),
('NU401', 'Health Assessment', 3, 4, 5),
('CS201', 'Data Structures', 3, 1, 4),
('ED101', 'Educational Psychology', 2, 5, 2);

-- ===============================
-- Table: Enrollment (Many-to-Many)
-- ===============================
CREATE TABLE Enrollment (
    student_id INT,
    course_id INT,
    enrollment_date DATE NOT NULL,
    grade VARCHAR(2),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

-- Sample Enrollments
INSERT INTO Enrollment (student_id, course_id, enrollment_date, grade) VALUES
(1, 1, '2024-09-01', 'A'),
(1, 2, '2024-09-01', 'B'),
(2, 3, '2024-09-01', 'B+'),
(3, 4, '2024-09-01', 'A-'),
(4, 1, '2024-09-01', 'B'),
(4, 2, '2024-09-01', 'A'),
(5, 2, '2024-09-01', 'B+'),
(6, 5, '2024-09-01', 'A'),
(7, 7, '2024-09-01', 'C+'),
(8, 3, '2024-09-01', 'B'),
(9, 4, '2024-09-01', 'A'),
(10, 5, '2024-09-01', 'B-');
