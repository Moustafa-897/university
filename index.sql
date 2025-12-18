CREATE DATABASE university_db;
CREATE TABLE departments( 
    dept_id INT PRIMARY KEY, 
    dept_name VARCHAR(50) NOT NULL );
CREATE TABLE courses( course_id INT PRIMARY KEY, course_name VARCHAR(50) NOT NULL, credits INT NOT NULL DEFAULT 3, dept_id INT, FOREIGN KEY (dept_id) REFERENCES departments(dept_id) ON DELETE CASCADE );   
CREATE TABLE students( student_id INT PRIMARY KEY, student_name VARCHAR(50) NOT NULL );
CREATE TABLE enrollments ( enrollment_id INT PRIMARY KEY, student_id INT, course_id INT, CONSTRAINT fk_enrollments_student FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE, CONSTRAINT fk_enrollments_course FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE );
CREATE TABLE health_records ( record_id INT PRIMARY KEY, student_id INT, blood_group TEXT, CONSTRAINT fk_health_records_student FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE );
INSERT INTO departments (dept_id, dept_name) VALUES (1, 'computer science');
INSERT INTO departments (dept_id, dept_name) VALUES (2, 'mathematics');
INSERT INTO departments (dept_id, dept_name) VALUES (3, 'physics');

INSERT INTO courses (course_id, course_name, credits, dept_id) VALUES
(1000, 'database systems', 4, 1),
(1001, 'algorithms', 3, 1),
(1002, 'calculus', 4, 2),
(1003, 'quantum mechanics', 5, 3);

INSERT INTO students VALUES (1, 'alice');
INSERT INTO students VALUES (2, 'bob');
INSERT INTO students VALUES (3, 'charlie');
INSERT INTO students VALUES (4, 'samy');
INSERT INTO students VALUES (5, 'eva');

INSERT INTO enrollments (enrollment_id, student_id, course_id) VALUES (1, 1, 1000), (2, 1, 1001), (3, 2, 1000), (4, 3, 1001), (5, 3, 1002), (6, 4, 1002), (7, 4, 1003), (8, 5, NULL);
INSERT INTO health_records (record_id, student_id, blood_group) VALUES (1, 1, 'A+'), (2, 2, 'B+'), (3, 3, 'O'), (4, 4, 'AB+'), (5, 5, 'A');
SELECT s.student_name,
       h.blood_group
FROM students s
JOIN health_records h
  ON s.student_id = h.student_id;

SELECT s.student_name,
       h.blood_group,
       c.course_name
FROM students s
JOIN health_records h
  ON s.student_id = h.student_id
JOIN enrollments e
  ON s.student_id = e.student_id
JOIN courses c
  ON e.course_id = c.course_id
ORDER BY s.student_name;

SELECT s.student_name,
       c.course_name
FROM students s
LEFT JOIN enrollments e
  ON s.student_id = e.student_id
LEFT JOIN courses c
  ON e.course_id = c.course_id
ORDER BY s.student_name;

SELECT c.course_name,
       s.student_name
FROM courses c
LEFT JOIN enrollments e
  ON c.course_id = e.course_id
LEFT JOIN students s
  ON e.student_id = s.student_id
ORDER BY c.course_name;

DELETE FROM departments
WHERE dept_id = 2;

DELETE FROM students
WHERE student_id = 2;

SELECT COUNT(*) AS total_students
FROM students;

SELECT AVG(credits) AS average_credits
FROM courses;

SELECT MAX(credits) AS highest_credit
FROM courses;

SELECT MIN(credits) AS lowest_credit
FROM courses;

SELECT COUNT(*) AS students_with_A_plus
FROM health_records
WHERE blood_group = 'A+';

SELECT 
    AVG(credits) AS average_credits,
    MAX(credits) AS highest_credit,
    MIN(credits) AS lowest_credit
FROM courses;