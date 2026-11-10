INSERT INTO Lecturer (staff_no, full_name, email, dept_id) VALUES
('VUA/ST/101', 'Dr Amaka Okafor',      'amakaokafor.okafor@vua.edu.ng',     5),
('VUA/ST/102', 'Dr Musa Bello',        'musabello.bello@vua.edu.ng',      4),
('VUA/ST/103', 'Prof Ngozi Eze',       'ngozieze.eze@vua.edu.ng',        7),
('VUA/ST/104', 'Dr Ibrahim Abdullahi', 'ibrahimabdullahi.abdullahi@vua.edu.ng',  6),
('VUA/ST/105', 'Dr Folake Adeyemi',    'folake.adeyemi@vua.edu.ng',    3),
('VUA/ST/106', 'Mr Chinedu Nwosu',     'chinedu.nwosu@vua.edu.ng',      5),
('VUA/ST/107', 'Dr Hauwa Yusuf',       'hauwa.yusuf@vua.edu.ng',      4),
('VUA/ST/108', 'Dr Emeka Obi',         'emeka.obi@vua.edu.ng',        7),
('VUA/ST/109', 'Mrs Blessing Okon',    'blessing.okon@vua.edu.ng',       3),
('VUA/ST/110', 'Dr Tunde Balogun',     'tunde.balogun@vua.edu.ng',    3);

INSERT INTO Student (matric_no, full_name, gender, date_of_birth, dept_id) VALUES
('20231234', 'Ada Obi',           'F', '2005-03-14', 5),
('20231235', 'John Musa',         'M', '2004-11-02', 4),
('12359', 'Ike Nancy Nnenna',       'F', '2005-07-21', 3),
('20231237', 'Chidi Okonkwo',     'M', '2004-01-09', 6),
('20231238', 'Aisha Mohammed',    'F', '2005-09-30', 3),
('20231239', 'Tolu Ogunleye',     'M', '2004-05-17', 5),
('20231240', 'Zainab Lawal',      'F', '2005-12-04', 5),
('20231241', 'Samuel Adebayo',    'M', '2003-08-25', 4),
('20231242', 'Ifeoma Chukwu',     'F', '2004-10-12', 4),
('20231243', 'Yusuf Danjuma',     'M', '2005-02-28', 6),
('20231244', 'Chiamaka Nnamdi',   'F', '2004-06-19', 7),
('20231245', 'Aminu Garba',       'M', '2003-11-07', 7),
('20231246', 'Grace Effiong',     'F', '2005-04-23', 4),
('20231247', 'Kelechi Anyanwu',   'M', '2004-09-15', 5),
('20231248', 'Rukayya Abubakar',  'F', '2005-01-31', 3),
('20231249', 'Obinna Okeke',      'M', '2004-03-06', 3),
('20231250', 'Bukola Afolabi',    'F', '2005-08-11', 7),
('20231251', 'Emmanuel Udoh',     'M', '2003-12-20', 5),
('20231252', 'Nneka Eze',         'F', '2004-07-02', 4),
('20231253', 'Segun Ajayi',       'M', '2005-05-26', 5);

SELECT student_id, matric_no, full_name FROM Student;
SELECT lecturer_id, full_name FROM Lecturer;

INSERT INTO Enrolment (student_id, course_id) VALUES
(22,1),(22,2),(22,5),
(23,1),(23,3),
(24,1),(24,4),(24,8),
(25,1),(25,6),
(26,2),(26,5),(26,7),
(27,1),(27,3),(27,9),
(28,2),(28,4),
(29,3),(29,10),
(30,1),(30,5),(30,6),
(31,4),(31,8),
(32,2),(32,7),(32,9),
(33,3),(33,6),
(34,1),(34,10),
(35,5),(35,8),
(36,4),(36,7),
(37,6),(37,9),
(38,3),(38,10);

INSERT INTO CourseAllocation (course_id, lecturer_id) VALUES
(1, 31), (1, 32),
(2, 33),
(3, 34),
(4, 35),
(5, 36),
(6, 37),
(7, 38),
(8, 39),
(9, 40),
(10, 31);

SET SQL_SAFE_UPDATES = 0;
SELECT matric_no, full_name, dept_id FROM Student WHERE matric_no = '20231234';
UPDATE Student SET dept_id = 4 WHERE matric_no = '20231234';
SELECT matric_no, full_name, dept_id FROM Student WHERE matric_no = '20231234';
SET SQL_SAFE_UPDATES = 1;


INSERT INTO Department (dept_name) VALUES ('Library and Information Science');

INSERT INTO Student (matric_no, full_name, gender, date_of_birth, dept_id)
VALUES ('20239999', 'Transfer Student', 'M', '2005-01-01',
(SELECT dept_id FROM Department WHERE dept_name = 'Library and Information Science'));

SELECT matric_no, full_name, dept_id FROM Student WHERE matric_no = '20239999';

DELETE FROM Department WHERE dept_name = 'Library and Information Science';

UPDATE Student
SET dept_id = (SELECT dept_id FROM Department

WHERE dept_name = 'Software Engineering')

WHERE matric_no = '20239999';
DELETE FROM Department WHERE dept_name = 'Library and Information Science';
SELECT * FROM Department;

SELECT 'Departments' AS tbl, COUNT(*) AS total FROM Department
UNION ALL SELECT 'Lecturers', COUNT(*) FROM Lecturer
UNION ALL SELECT 'Students', COUNT(*) FROM Student
UNION ALL SELECT 'Courses', COUNT(*) FROM Course
UNION ALL SELECT 'Enrolments', COUNT(*) FROM Enrolment
UNION ALL SELECT 'Allocations', COUNT(*) FROM CourseAllocation;