CREATE DATABASE university_db;
CREATE TABLE departments( 
    dept_id INT PRIMARY KEY, 
    dept_name VARCHAR(50) NOT NULL );
CREATE TABLE courses( course_id INT PRIMARY KEY, course_name VARCHAR(50) NOT NULL, credits INT NOT NULL DEFAULT 3, dept_id INT, FOREIGN KEY (dept_id) REFERENCES departments(dept_id) ON DELETE CASCADE );   
CREATE TABLE students( student_id INT PRIMARY KEY, student_name VARCHAR(50) NOT NULL );
CREATE TABLE enrollments ( enrollment_id INT PRIMARY KEY, student_id INT, course_id INT, CONSTRAINT fk_enrollments_student FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE, CONSTRAINT fk_enrollments_course FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE );