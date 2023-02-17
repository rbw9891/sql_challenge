-- list employee #, last name, first name, sex, salary for each employee
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e 
INNER JOIN salaries s 
ON e.emp_no = s.emp_no;

-- list first name, last name, and hire date for employees hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT('year' from hire_date)=1986;

-- list each manager w/ dept_no, dept_name, emp_no, last_name, first_name
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM dept_manager dm
LEFT JOIN departments d 
ON dm.dept_no = d.dept_no
LEFT JOIN employees e 
ON dm.emp_no = e.emp_no;

-- list dept_no for each employee w/ emp_no, last_name, first_name, dept_name
SELECT de.dept_no, de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
LEFT JOIN employees e 
ON de.emp_no = e.emp_no
LEFT JOIN departments d 
ON de.dept_no = d.dept_no;

-- list first_name, last_name, sex of employees whose first name is Hercules and last name begins with B
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

-- list each employee in the sales department w/ emp_no, last_name, first_name
SELECT emp_no, last_name, first_name
FROM employees
WHERE emp_no IN (
    SELECT emp_no
    FROM dept_emp
    WHERE dept_no IN (
        SELECT dept_no
        FROM departments
        WHERE dept_name = 'Sales'
    )
);

-- list each employee in the sales and development departments w/ emp_no, last_name, first_name, and dept_name
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e 
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales','Development');

-- list frequency counts, in descending order, of all employee last names
SELECT last_name, Count(last_name) AS name_frequency
FROM employees
GROUP BY last_name
ORDER BY name_frequency DESC;