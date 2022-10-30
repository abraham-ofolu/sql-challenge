CREATE TABLE departments (
	dept_no VARCHAR(20) PRIMARY KEY NOT NULL,
	dept_name VARCHAR UNIQUE NOT NULL
);



CREATE TABLE titles(
	title_id VARCHAR PRIMARY KEY NOT NULL,
	title VARCHAR(50) UNIQUE NOT NULL
);



CREATE TABLE employees (
	emp_no INTEGER PRIMARY KEY NOT NULL,
	emp_title_id VARCHAR(20) NOT NULL,
	FOREIGN KEY(emp_title_id) REFERENCES titles(title_id),
	birth_date DATE NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	sex VARCHAR(1) NOT NULL,
	hire_date DATE NOT NULL
);



CREATE TABLE dept_emp (
	emp_no INTEGER NOT NULL,
	dept_no VARCHAR(20) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);



CREATE TABLE dept_manager (
	dept_no VARCHAR (20) NOT NULL,
	emp_no INT NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);




CREATE TABLE salaries (
	emp_no INTEGER NOT NULL,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	salary INTEGER NOT NULL
);


SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;



-- DATA ANALYSIS
1.--List the employee number, last name, first name, sex, and salary of each employee
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees as e
JOIN salaries as s
ON e.emp_no = s.emp_no;



2.--List the first name, last name, and hire date for the employees who were hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' and '1986-12-31';



3.--List the manager of each department along with their department number, department name,
--employee number, last name, and first name.



SELECT m.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name
FROM dept_manager as m
JOIN departments as d
ON m.dept_no = d.dept_no
JOIN employees as e
ON e.emp_no = m.emp_no;



--4. List the department number for each employee along with that employeee's
--employee number, last name, first name and department number
SELECT m.dept_no, m.emp_no, e,last_name, e.first_name, d.dept_name
FROM dept_manager as m
JOIN departments as d
ON m.dept_no = d.dept_no
JOIN employees as e
ON e.emp_no = m.emp_no;


--5. List first name, last name, and sex of each employee whose first name is 
--Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';



--6. List each employee in sales department, including their employee number,
--last name, and first name.
SELECT e.emp_no, e.last_name, e.first_name
FROM employees AS e
JOIN dept_emp AS deptem
ON e.emp_no = deptem.emp_no
JOIN departments AS d
ON deptem.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';



--7.List each employee in Sales amd development departments, including their 
--employee number, last name, first name and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS deptem
ON e.emp_no = deptem.emp_no
JOIN departments as d
ON deptem.dept_no = d.dept_no
WHERE d.dept_name = 'Sales'
OR d.dept_name = 'Development';



--8.List the frequency counts, in descending order, of all the employee
--last names(that is, how many employees share each last name).
SELECT last_name,
COUNT(last_name) as "frequency"
FROM employees
GROUP BY last_name
ORDER BY frequency desc;