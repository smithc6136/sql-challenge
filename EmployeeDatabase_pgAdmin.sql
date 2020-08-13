-- DATA ENGINEERING: Create a table for each csv to be imported
-- Create Departments table
CREATE TABLE "Departments" (
    "dept_no" VARCHAR(5)   NOT NULL,
    "dept_name" VARCHAR(40)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY ("dept_no")
);

-- Create Employees table
CREATE TABLE "Employees" (
    "emp_no" VARCHAR(6)   NOT NULL,
    "emp_title_id" VARCHAR(6)   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(20)   NOT NULL,
    "last_name" VARCHAR(20)   NOT NULL,
    "sex" VARCHAR(1)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY ("emp_no")
);

-- Create Dept_Emp table
CREATE TABLE "Dept_Emp" (
    "emp_no" VARCHAR(6)   NOT NULL,
    "dept_no" VARCHAR(6)   NOT NULL,
    CONSTRAINT "pk_Dept_Emp" PRIMARY KEY ("emp_no","dept_no")
);

-- Create Dept_Manager table
CREATE TABLE "Dept_Manager" (
    "dept_no" VARCHAR(6)   NOT NULL,
    "emp_no" VARCHAR(6)   NOT NULL,
    CONSTRAINT "pk_Dept_Manager" PRIMARY KEY ("dept_no","emp_no")
);

-- Create Salaries table
CREATE TABLE "Salaries" (
    "emp_no" VARCHAR(6)   NOT NULL,
    "salary" VARCHAR(9)   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY ("emp_no")
);

-- Create Titles table
CREATE TABLE "Titles" (
    "title_id" VARCHAR(6)   NOT NULL,
    "title" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY ("title_id")
);

-- DATA ANALYSIS
-- List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM "Employees" AS e
JOIN "Salaries" AS s
ON (e.emp_no = s.emp_no);

-- List first name, last name, and hire date for employees who were hired in 1986.
SELECT last_name, first_name, hire_date
FROM "Employees"
WHERE hire_date BETWEEN '12/31/1985' AND '01/01/1987';

-- List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT dm.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM "Employees" e
LEFT JOIN "Dept_Manager" dm
ON (e.emp_no = dm.emp_no)
JOIN "Departments" d
ON (dm.dept_no = d.dept_no);

-- List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM "Employees" e
RIGHT JOIN "Dept_Emp" de
ON (e.emp_no = de.emp_no)
JOIN "Departments" d
ON (de.dept_no = d.dept_no);

-- List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM "Employees"
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM "Employees" e
LEFT JOIN "Dept_Emp" de
ON (e.emp_no = de.emp_no)
JOIN "Departments" d
ON (de.dept_no = d.dept_no)
WHERE dept_name = 'Sales';

-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM "Employees" e
LEFT JOIN "Dept_Emp" de
ON (e.emp_no = de.emp_no)
JOIN "Departments" d
ON (de.dept_no = d.dept_no)
WHERE dept_name = 'Sales' OR dept_name='Development';

-- In descending order, list the frequency count of employee last names
SELECT last_name, count(last_name)
FROM "Employees"
GROUP BY last_name
ORDER BY count(last_name) DESC;