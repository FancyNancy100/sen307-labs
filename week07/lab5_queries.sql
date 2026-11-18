-- ============================================
-- VUA-SEN307 Lab 5: SELECT, Filtering and Joins
-- Name: IKE NANCY NNENNA  Matric: VUG/SEN/24/12359
-- ============================================
USE sen307_vug_sen_24_12359;
-- Task 1: Students in one department, sorted A-Z
SELECT s.student_id, s.full_name, s.matric_no, d.dept_name
FROM Student AS s
JOIN Department d
ON s.dept_id=d.dept_id
WHERE d.dept_name= 'Software Engineering'
ORDER BY s.full_name ASC;
-- JOIN Department ON s.dept_id = d.dept_id-this is what links each student to their department.
-- 	WHERE d.dept_name ='Software Engineering' this filters to only software engineering students
-- ORDER BY s.fullname ASC this sorts them A to Z by name			

-- Task 2: Courses with their lecturers (INNER JOIN)
SELECT c.course_title, l.full_name AS lecturer_name
FROM Course c
INNER JOIN CourseAllocation ca ON c.course_id = ca.course_id
INNER JOIN Lecturer l ON ca.lecturer_id = l.lecturer_id
ORDER BY c.course_title;
-- Explanation: Course and Lecturer are linked only through CourseAllocation,
-- so two INNER JOINs are needed. Only courses with an allocated lecturer
-- appear, and the course with two lecturers shows up twice (one row each).

-- Task 3: Students and their courses (LEFT JOIN)
SELECT s.full_name, c.course_title
FROM Student s
LEFT JOIN Enrolment e ON s.student_id = e.student_id
LEFT JOIN Course c ON e.course_id = c.course_id
ORDER BY s.full_name;
-- Explanation: LEFT JOIN keeps every student (left table). Students with no
-- enrolment get NULL in course_title instead of being dropped.


-- Task 4: Filtering with AND / OR / IN / BETWEEN
SELECT s.full_name, s.gender, s.date_of_birth, s.dept_id
FROM Student s
WHERE s.gender = 'F'
  AND s.dept_id IN (1, 3)
  AND s.date_of_birth BETWEEN '2004-01-01' AND '2005-12-31'
ORDER BY s.date_of_birth;
-- Explanation: Female students in department 1 or 3 (IN is shorthand for
-- dept_id = 1 OR dept_id = 3) born between 2004-01-01 and 2005-12-31
-- (BETWEEN is inclusive of both ends). Uses AND, IN and BETWEEN


-- Task 4 (part b): includes OR, with brackets
SELECT s.full_name, s.gender, s.dept_id
FROM Student s
WHERE (s.dept_id = 1 OR s.dept_id = 3)
  AND s.gender = 'F'
  AND s.date_of_birth BETWEEN '2004-01-01' AND '2005-12-31';
-- Explanation: Brackets make the OR apply to the departments only. Without
-- them, AND binds tighter than OR and the filter would give wrong results.




-- Task 5: Paginating enrolments with LIMIT and OFFSET
-- Page 1 (rows 1-10)
SELECT * FROM Enrolment
ORDER BY enrolment_id
LIMIT 10 OFFSET 0;
 
-- Page 2 (rows 11-20)
SELECT * FROM Enrolment
ORDER BY enrolment_id
LIMIT 10 OFFSET 10;
-- Explanation: LIMIT sets how many rows to return; OFFSET sets how many to
-- skip first. ORDER BY is essential because SQL tables have no guaranteed
-- row order: without it, the "first 10 rows" can differ between runs, and
-- pages 1 and 2 could overlap or miss rows.
 
 
-- Challenge: Task 3 rewritten with RIGHT JOIN
-- (Student is moved to the right side, so the table order is reversed.)
SELECT s.full_name, c.course_title
FROM Course c
RIGHT JOIN Enrolment e ON c.course_id = e.course_id
RIGHT JOIN Student s ON e.student_id = s.student_id
ORDER BY s.full_name;
-- Explanation: Gives the same result as Task 3. A RIGHT JOIN keeps all rows
-- from the right table, so Student must come last in the chain.
-- Readability: the LEFT JOIN version is easier to read because it starts
-- from Student, the table we care about, and reads left to right in the
-- order of the question. The RIGHT JOIN version puts the main table last.
 


