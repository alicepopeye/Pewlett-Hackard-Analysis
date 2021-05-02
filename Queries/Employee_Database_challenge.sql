--Deliverable 1: The number of retiring employees by title
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_list_title
FROM employees as e
	INNER JOIN titles as t
	ON (e.emp_no = t.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rlt.emp_no) rlt.emp_no,
rlt.first_name,
rlt.last_name,
rlt.title
INTO unique_titles
FROM retirement_list_title as rlt
ORDER BY rlt.emp_no, rlt.to_date DESC;


--Count by Titles
SELECT 
	COUNT(title),
	title
INTO retiring_titles
FROM unique_titles
GROUP BY (title)
ORDER BY COUNT(title)DESC;


--Deliverable 2: The employees eligible for the Mentorship Program
SELECT DISTINCT ON (e.emp_no)e.emp_no,
	e.first_name,
	e.last_name, 
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees as e
	INNER JOIN dept_emp as de
		ON (e.emp_no = de.emp_no)
	INNER JOIN titles as t
		ON (e.emp_no = t.emp_no)
WHERE e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
AND de.to_date = '9999-01-01'
ORDER BY e.emp_no, de.to_date DESC;

--Mentorship group by title
SELECT 
	COUNT(emp_no),
	title
--INTO mentorship_eligible_title
FROM mentorship_eligibilty
GROUP BY title
ORDER BY count(emp_no) DESC;

--Adddional: How many current/active employees by title?
SELECT 
	count(t.title),
	t.title
--INTO active_employee
FROM employees as e
	INNER JOIN dept_emp as de
		ON (e.emp_no = de.emp_no)
	INNER JOIN titles as t
		ON (e.emp_no = t.emp_no)
WHERE de.to_date = '9999-01-01'
GROUP BY t.title;


--Additional Analysis: CURRENT EMPLOYEE ONLY
--retire unique title -only current employee
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_list_title_current
FROM employees as e
	INNER JOIN titles as t
	ON (e.emp_no = t.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
AND t.to_date = '9999-01-01'
ORDER BY e.emp_no;

SELECT 
	COUNT(emp_no)
FROM retirement_List_title_current;

SELECT 
	COUNT(emp_no)
FROM retirement_List_title;



SELECT DISTINCT ON (rlt.emp_no) rlt.emp_no,
rlt.first_name,
rlt.last_name,
rlt.title
INTO unique_titles_current
FROM retirement_list_title_current as rlt
ORDER BY rlt.emp_no, rlt.to_date DESC;

SELECT 
	COUNT (emp_no)
FROM unique_titles_current;


SELECT 
	COUNT (emp_no)
FROM unique_titles;

--Count by Titles
SELECT 
	COUNT(title),
	title
INTO retiring_titles_current
FROM unique_titles_current
GROUP BY (title)
ORDER BY COUNT(title)DESC;

SELECT * FROM retiring_titles_current;
