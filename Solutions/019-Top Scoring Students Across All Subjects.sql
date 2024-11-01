/*
Link: https://www.codewars.com/kata/64df390966e72e01f73c8ea8

Description:

Write an SQL query to identify the names of students who scored the
highest mark in comparison to their peers in every subject they attended.

Table Schema:

students:

    student_id (integer) - Unique identifier for each student.
    student_name (varchar) - Name of the student.
    details (varchar) - Additional details related to the student (for this challenge, it may have a static value like 'X').

subjects:

    subject_id  (varchar) - Unique identifier for each subject (e.g., 'M' for Math).
    subject_name (varchar) - Name of the subject (e.g., 'Math', 'English').

marks:

    student_id (integer) - Identifier linking to the students table.
    subject_id (varchar) - Identifier linking to the subjects table.
    mark_rate (integer) - The mark or score the student has received for the subject.

Resultant Dataset Columns:

    student_id - Unique identifier for the student.
    student_name - The name of the student.

The result should be ordered by student_id in descending order.

GLHF!
*/

-- Solution

WITH highest_mark_per_subject AS (
  SELECT
    marks.subject_id,
    MAX(marks.mark_rate) AS highest_mark
  FROM
    marks
  GROUP BY
    marks.subject_id
),
top_students AS (
  SELECT
    marks.student_id,
    COUNT(marks.subject_id) AS highest_mark_subjects
  FROM
    marks
  JOIN highest_mark_per_subject AS highest_mark_per_subject ON
    marks.subject_id = highest_mark_per_subject.subject_id AND
    marks.mark_rate = highest_mark_per_subject.highest_mark
  GROUP BY
    marks.student_id
)

SELECT DISTINCT
  students.student_id,
  students.student_name
FROM
  students AS students
JOIN top_students AS top_students
ON students.student_id = top_students.student_id
WHERE (
  SELECT COUNT(DISTINCT marks.subject_id) FROM marks WHERE marks.student_id = students.student_id
) = top_students.highest_mark_subjects
ORDER BY students.student_id DESC;
