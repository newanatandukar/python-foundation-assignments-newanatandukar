-- Assignment: SQL Operators
-- Data lives in data/employees.csv.

CREATE TABLE employees (
    employee_id           INTEGER PRIMARY KEY,
    employee_code         TEXT,
    first_name            TEXT,
    last_name             TEXT,
    gender                TEXT,
    age                   INTEGER,
    city                  TEXT,
    department            TEXT,
    job_title             TEXT,
    employment_type       TEXT,
    join_date             TEXT,
    years_experience      INTEGER,
    monthly_salary        INTEGER,
    annual_bonus          INTEGER,
    performance_rating    REAL,
    projects_completed    INTEGER,
    leave_days_taken      INTEGER,
    overtime_hours        INTEGER,
    remote_worker         TEXT,
    employment_status     TEXT,
    education_level       TEXT,
    email                 TEXT,
    phone                 TEXT,
    emergency_contact     TEXT,
    manager_name          TEXT,
    certification         TEXT,
    work_shift            TEXT,
    performance_category  TEXT,
    promotion_eligible    TEXT
);


SELECT employee_id, monthly_salary, monthly_salary + 10000 AS increased_salary
FROM employees;

SELECT employee_id, monthly_salary, monthly_salary - 5000 AS reduced_salary
FROM employees;

SELECT employee_id, monthly_salary, monthly_salary * 12 AS annual_salary
FROM employees;

SELECT employee_id, annual_bonus, annual_bonus / 12.0 AS average_monthly_bonus
FROM employees;

SELECT employee_id, age, age % 2 AS remainder
FROM employees;

SELECT employee_id, (monthly_salary * 12) + annual_bonus AS total_compensation
FROM employees;

SELECT * FROM employees WHERE monthly_salary > 100000;

SELECT * FROM employees WHERE age < 30;

SELECT * FROM employees WHERE performance_rating >= 4.5;

SELECT * FROM employees WHERE years_experience <= 5;

SELECT * FROM employees WHERE department = 'IT';

SELECT * FROM employees WHERE employment_status <> 'Active';

SELECT * FROM employees WHERE city = 'Kathmandu' AND monthly_salary > 100000;

SELECT * FROM employees WHERE city = 'Kathmandu' OR city = 'Pokhara';

SELECT * FROM employees
WHERE (department = 'IT' OR department = 'Analytics') AND performance_rating > 4;

SELECT * FROM employees WHERE remote_worker = 'No';

SELECT * FROM employees
WHERE age < 40 AND years_experience > 5 AND employment_status = 'Active';

SELECT * FROM employees
WHERE employment_type = 'Full-Time' AND (monthly_salary > 80000 OR performance_rating > 4.5);

SELECT * FROM employees WHERE first_name LIKE 'A%';

SELECT * FROM employees WHERE first_name LIKE '%a';

SELECT * FROM employees WHERE first_name LIKE '%i%';

SELECT * FROM employees WHERE last_name LIKE 'S%';

SELECT * FROM employees WHERE job_title LIKE '%Analyst%';

SELECT * FROM employees WHERE email LIKE '%@company.com';

SELECT * FROM employees WHERE city IN ('Kathmandu', 'Pokhara', 'Lalitpur');

SELECT * FROM employees WHERE department IN ('IT', 'Analytics', 'Finance');

SELECT * FROM employees WHERE employment_type IN ('Full-Time', 'Contract');

SELECT * FROM employees WHERE education_level IN ('Bachelor', 'Master', 'PhD');

SELECT * FROM employees WHERE age BETWEEN 25 AND 40;

SELECT * FROM employees WHERE monthly_salary BETWEEN 80000 AND 150000;

SELECT * FROM employees WHERE performance_rating BETWEEN 3.5 AND 4.5;

SELECT * FROM employees WHERE years_experience BETWEEN 3 AND 10;

SELECT * FROM employees WHERE join_date BETWEEN '2020-01-01' AND '2024-12-31';

SELECT * FROM employees WHERE email IS NULL;

SELECT * FROM employees WHERE phone IS NULL;

SELECT * FROM employees WHERE emergency_contact IS NULL;

SELECT * FROM employees WHERE certification IS NULL;

SELECT * FROM employees WHERE email IS NOT NULL AND phone IS NOT NULL;

SELECT * FROM employees
WHERE employment_status = 'Active'
  AND (city = 'Kathmandu' OR city = 'Lalitpur')
  AND monthly_salary BETWEEN 90000 AND 180000;

SELECT * FROM employees
WHERE (department = 'IT' OR department = 'Analytics')
  AND first_name LIKE 'A%'
  AND performance_rating >= 4;

SELECT * FROM employees
WHERE employment_type <> 'Intern' AND projects_completed > 5;

SELECT * FROM employees WHERE certification IS NULL OR emergency_contact IS NULL;

SELECT * FROM employees
WHERE job_title LIKE '%Manager%' AND employment_status = 'Active';

SELECT * FROM employees
WHERE age BETWEEN 30 AND 50 AND remote_worker = 'Yes' AND monthly_salary > 120000;

SELECT
    employee_id,
    department,
    monthly_salary * 12 AS annual_salary,
    (monthly_salary * 12) + annual_bonus AS total_compensation
FROM employees
WHERE department IN ('Finance', 'IT', 'Analytics');

SELECT * FROM employees
WHERE promotion_eligible = 'Yes' AND performance_category = 'Excellent';

SELECT * FROM employees
WHERE overtime_hours BETWEEN 20 AND 60 AND leave_days_taken < 15;

SELECT * FROM employees
WHERE city <> 'Kathmandu' AND first_name LIKE '%u%';

SELECT * FROM employees WHERE monthly_salary > 100000 OR annual_bonus > 150000;

SELECT employee_id, employee_code, first_name, department, monthly_salary,
       monthly_salary * 12 AS annual_salary
FROM employees
WHERE employment_status = 'Active';
