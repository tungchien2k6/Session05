CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    full_name VARCHAR(50),
    major VARCHAR(50)
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
	credit INT
);

CREATE TABLE enrollments (
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id),
    score NUMERIC(5,2) 
);

INSERT INTO students (full_name, major) VALUES
('Nguyen Van A', 'CNTT'),
('Tran Thi B', 'Kinh te'),
('Le Van C', 'CNTT'),
('Pham Thi D', 'Marketing'),
('Hoang Van E', 'CNTT'),
('Do Thi F', 'Kinh te');

INSERT INTO courses (course_name, credit) VALUES
('Co so du lieu', 3),
('Lap trinh Java', 4),
('Marketing can ban', 3),
('Ke toan', 3),
('Tri tue nhan tao', 4);

INSERT INTO enrollments (student_id, course_id, score) VALUES
(1, 1, 8.5),
(1, 2, 7.0),
(2, 3, 6.5),
(2, 4, 7.5),
(3, 1, 9.0),
(3, 5, 8.0),
(4, 3, 7.8),
(5, 2, 6.0),
(5, 5, 7.2),
(6, 4, 8.3);

--1
SELECT 
    s.full_name AS "Ten sinh vien",
    c.course_name AS "Mon hoc",
    e.score AS "Diem"
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON c.course_id = e.course_id;

--2
SELECT 
    s.student_id,
    s.full_name,
    AVG(e.score) AS avg_score,
    MAX(e.score) AS max_score,
    MIN(e.score) AS min_score
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.full_name;

--3
SELECT 
    s.major,
    AVG(e.score) AS avg_score
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.major
HAVING AVG(e.score) > 7.5;

--4
SELECT 
    s.full_name,
    c.course_name,
    c.credit,
    e.score
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON c.course_id = e.course_id;

--5
SELECT 
    s.student_id,
    s.full_name,
    AVG(e.score) AS avg_score
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.full_name
HAVING AVG(e.score) > (
    SELECT AVG(score) FROM enrollments
);