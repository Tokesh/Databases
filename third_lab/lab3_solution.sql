/*
 Ex 1.
 */
select * from course where credits > 3;

select * from classroom where building = 'Watson' or building = 'Packard';

select * from department where dept_name = 'Comp. Sci.';

select * from teaches where semester = 'Fall';

select * from student where tot_cred > 45 and tot_cred < 90;

select * from student where name like '%a' or name like '%e' or name like '%o' or  name like '%u' or name like '%i';
select * from student where name similar to '%[aeouiAEOUI]';

select * from prereq where prereq_id = 'CS-101';
/*
 Ex 2.
 */
select dept_name,avg(salary) from instructor
group by dept_name order by avg(salary);

select dept_name,count(*) from course group by dept_name order by count(*) desc limit 1;

select dept_name,count(*) from course group by dept_name order by count(*) limit 1;

select name, count(name) as counter from (select student.id, student.name from student, takes, course where takes.course_id = course.course_id and course.dept_name='Comp. Sci.' and takes.id = student.id) as zxc
group by name;
select name, count(name) as counter from (select student.id, student.name from student, takes, course where takes.course_id = course.course_id and course.dept_name='Comp. Sci.' and takes.id = student.id) as zxc
group by name having count(name) > 3;

select distinct name, course.dept_name from teaches, instructor,course where teaches.id = instructor.id and teaches.course_id = course.course_id
and (course.dept_name = 'Biology' or course.dept_name = 'Philosophy' or course.dept_name = 'Music');

select distinct name, teaches.year from teaches, instructor where teaches.year = '2018' and teaches.id = instructor.id;

/*
 Ex 3.
 */

select distinct name from student, takes, course where (takes.grade = 'A' or takes.grade = 'A-') and takes.course_id = course.course_id
and course.dept_name = 'Comp. Sci.' and student.id = takes.id order by name;

select distinct instructor.name from takes, advisor, instructor
where takes.grade > 'B' and takes.id = advisor.s_id and advisor.i_id = instructor.id;

select distinct takes.id, student.name, grade, student.dept_name from student, takes, department where grade > 'B+' and takes.id = student.id;
select distinct department.dept_name from student, takes, department where grade > 'B+' and takes.id = student.id and student.dept_name = department.dept_name;
select * from department where dept_name not in
    (select distinct department.dept_name from student, takes, department where grade > 'B+' and takes.id = student.id and student.dept_name = department.dept_name);

select distinct instructor.id from student, takes, instructor, teaches where grade = 'A' and takes.semester = teaches.semester and takes.sec_id = teaches.sec_id
and takes.year = teaches.year and takes.course_id = teaches.course_id and teaches.id = instructor.id;
select instructor.name from instructor where instructor.id not in
(select distinct instructor.id from student, takes, instructor, teaches where grade = 'A' and takes.semester = teaches.semester and takes.sec_id = teaches.sec_id
and takes.year = teaches.year and takes.course_id = teaches.course_id and teaches.id = instructor.id);

select distinct time_slot_id from time_slot where end_hr < 13;
select section.course_id from section where section.time_slot_id in (select distinct time_slot_id from time_slot where end_hr < 13);




