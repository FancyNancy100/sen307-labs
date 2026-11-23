-- ============================================================
-- VUA-SEN307 Database Systems | Week 8 Practical
-- Lab 6: Aggregate Functions, Grouping and Subqueries
-- Name: IKE NANCY NNENNA        Matric No: VUG/SEN/24/12359
-- ============================================================


-- ------------------------------------------------------------
-- Task 1: Students enrolled in each course (including courses
--         with zero students).
-- ------------------------------------------------------------
SELECT c.course_title, COUNT(e.student_id) AS total_students
FROM Course c
LEFT JOIN Enrolment e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_title
ORDER BY total_students DESC;


-- ------------------------------------------------------------
-- Task 2: Courses with more than N students, using HAVING.
-- ------------------------------------------------------------

-- Threshold 3
SELECT c.course_title, COUNT(e.student_id) AS total_students
FROM Course c
LEFT JOIN Enrolment e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_title
HAVING COUNT(e.student_id) > 3;

-- Threshold 5
SELECT c.course_title, COUNT(e.student_id) AS total_students
FROM Course c
LEFT JOIN Enrolment e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_title
HAVING COUNT(e.student_id) > 5;

-- Threshold 7
SELECT c.course_title, COUNT(e.student_id) AS total_students
FROM Course c
LEFT JOIN Enrolment e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_title
HAVING COUNT(e.student_id) > 7;


-- ------------------------------------------------------------
-- Task 3: Average number of courses per student, including
--         students with zero courses.
-- Inner query: one row per student with their course count
--              (LEFT JOIN so zero-course students appear with 0).
-- Outer query: average of those counts, rounded to 2 decimals.
-- ------------------------------------------------------------
SELECT ROUND(AVG(course_count), 2) AS avg_courses_per_student
FROM (
    SELECT s.student_id, COUNT(e.course_id) AS course_count
    FROM Student s
    LEFT JOIN Enrolment e ON s.student_id = e.student_id
    GROUP BY s.student_id
) AS per_student;


-- ------------------------------------------------------------
-- Task 4 (non-correlated subquery): Students not enrolled in
--         any course.
-- The inner query runs once and returns all enrolled student_ids.
-- NOT IN keeps students whose id is not in that list.
-- ------------------------------------------------------------
SELECT student_id, full_name
FROM Student
WHERE student_id NOT IN (SELECT student_id FROM Enrolment);


-- ------------------------------------------------------------
-- Task 5 (correlated subquery): For each department, the
--         student(s) with the highest number of enrolments.
-- ------------------------------------------------------------
SELECT d.dept_name, s.full_name,
       (SELECT COUNT(*)
        FROM Enrolment e
        WHERE e.student_id = s.student_id) AS courses
FROM Student s
JOIN Department d ON s.dept_id = d.dept_id
WHERE (SELECT COUNT(*)
       FROM Enrolment e
       WHERE e.student_id = s.student_id)
      >= ALL (
          SELECT COUNT(e2.student_id)
          FROM Student s2
          LEFT JOIN Enrolment e2 ON e2.student_id = s2.student_id
          WHERE s2.dept_id = s.dept_id
          GROUP BY s2.student_id
      )
ORDER BY d.dept_name;