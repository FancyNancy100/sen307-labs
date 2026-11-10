IKE NANCY NNENNA
VUG/SEN/24/12359



In Part 4 I got Error 1451: "Cannot delete or update a parent row: a foreign key
constraint fails" (constraint `student_ibfk_1`) when I tried to delete the
department "Library and Information Science". MySQL refuses because the Student
table has a foreign key on `dept_id` that references `Department(dept_id)`, and a
student still belonged to that department. Deleting it would leave an orphaned
student pointing at a department that no longer exists, so the default RESTRICT
rule blocks the delete to protect referential integrity. I fixed it by first
moving the student to one of the original five departments with an UPDATE, which
left the department with no children, and then deleting the department. Another
fix would have been to delete the student first and then the department.
Alternatively, the foreign key could be redefined with ON DELETE CASCADE, so
deleting the department also deletes its students, or with ON DELETE SET NULL, so
the students' dept_id becomes NULL (this needs `dept_id` to allow NULLs).