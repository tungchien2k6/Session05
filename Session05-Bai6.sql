CREATE TABLE departments (
	dept_id SERIAL PRIMARY KEY,
	dept_name VARCHAR(100)
);

CREATE TABLE employees (
	emp_id SERIAL PRIMARY KEY,
	emp_name VARCHAR(100),
	dept_id INT REFERENCES departments(dept_id),
	salary NUMERIC(10,2),
	hire_date DATE
);

CREATE TABLE projects (
	project_id SERIAL PRIMARY KEY
	project_name VARCHAR(100),
	dept_id INT REFERENCES departments(dept_id)
);

INSERT INTO departments (dept_name) VALUES
('IT'),
('HR'),
('Finance'),
('Marketing');

INSERT INTO employees (emp_name, dept_id, salary, hire_date) VALUES
('Nguyen Van A', 1, 20000000, '2023-01-10'),
('Tran Thi B', 1, 15000000, '2023-03-15'),
('Le Van C', 2, 12000000, '2022-07-20'),
('Pham Thi D', 3, 18000000, '2021-11-05'),
('Hoang Van E', 3, 16000000, '2022-02-25'),
('Do Thi F', 4, 14000000, '2023-06-01');

INSERT INTO projects (project_name, dept_id) VALUES
('Project A', 1),
('Project B', 2),
('Project C', 3),
('Project D', 4);

-- 1. ALIAS (INNER JOIN)
SELECT 
    e.emp_name AS "Ten nhan vien",
    d.dept_name AS "Phong ban",
    e.salary AS "Luong"
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;

-- 2. Aggregate Functions
SELECT 
    SUM(salary) AS total_salary,
    AVG(salary) AS avg_salary,
    MAX(salary) AS max_salary,
    MIN(salary) AS min_salary,
    COUNT(emp_id) AS total_employees
FROM employees;

-- 3. GROUP BY / HAVING (INNER JOIN)
SELECT 
    d.dept_name,
    AVG(e.salary) AS avg_salary
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
HAVING AVG(e.salary) > 15000000;

-- 4. JOIN (INNER JOIN 3 bảng)
SELECT 
    p.project_name,
    d.dept_name,
    e.emp_name
FROM projects p
INNER JOIN departments d ON p.dept_id = d.dept_id
INNER JOIN employees e ON e.dept_id = d.dept_id;

-- 5. Subquery
SELECT 
    e.emp_name,
    d.dept_name,
    e.salary
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
WHERE e.salary IN (
    SELECT MAX(salary)
    FROM employees
    GROUP BY dept_id
);