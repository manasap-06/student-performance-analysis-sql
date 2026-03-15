CREATE DATABASE studentdb;
use studentdb;
create table students(student_id int primary key,name varchar(20),department varchar(20));
insert into students VALUES
(1,'Akula','CSE'),
(2,'Rahul','ECE'),
(3,'Sneha','CSE');
select *from students;
create table subjects (subject_id int primary key,subject_name varchar(50));
insert into subjects values(101,'DBMS'),(102,'OS'),(103,'MATHS');
SELECT *FROM subjects;
create table mark(student_id int,subject_id int,marks int,foreign key(student_id) references students(student_id),foreign key(subject_id) references subjects(subject_id)
);
insert into mark values
(1,101,78),
(1,102,85),
(1,103,67),
(2,101,45),
(2,102,72),
(2,103,60),
(3,101,90),
(3,102,88),
(3,103,92);
select *from mark;
--analysis
--finding average 
select avg(marks) as avg_marks from mark;
--subject_wise average
select subject_id,avg(marks) as avg_marks
from mark
group by subject_id;
--top 2 students
select top 2
student_id,avg(marks) as avg_marks
from mark
group by student_id 
order by avg_marks desc;
--student average
select
student_id,avg(marks) as avg_marks
from mark
group by student_id 
order by avg_marks desc;
--subject wise performance 
select subject_id,
max(marks)as max_marks,
min(marks)as min_marks,
avg(marks)as avg_marks
from mark
group by subject_id;
--department_wise analysis
select s.department,avg(m.marks)as avg_marks 
from students s
join mark m on s.student_id=m.student_id
group by s.department;
--highest and lowest marks
select max(marks) as highest_marks,
min(marks) as lowest_marks
 from mark;
 --students below average(weak students)
 select student_id,marks
 from mark
 where marks<(select avg(marks) from mark);
 --subjectwise topper
 select m.subject_id,m.student_id,m.marks as highest_marks
 from mark m 
 where m.marks=(
 select max(m2.marks)
 from mark m2
 where m2.subject_id=m.subject_id 
 )
 order by m.subject_id;
 --overall ranking
 --rank based on average marks
 select student_id,avg (marks) as avg_marks,rank() over(order by avg(marks) desc) as rank from mark 
 group by student_id ;
 --department wise ranking 
 --rank students within each department 
 select s.department,m.student_id,avg(m.marks) as avg_marks,rank() over ( partition by s.department order by avg(m.marks) desc) as dept_rank
 from students s 
 join mark m on s.student_id =m.student_id
 group by s.department,m.student_id;
 --dense rank (no gaps)
 select student_id,avg(marks) as avg_marks,dense_rank() over (order by avg(marks) desc)as dense_rank
 from mark 
 group by student_id;
 --compare students(above average /below average )
 select student_id,avg(marks)as avg_mark,
 case 
 when avg(marks)>=(select avg(marks) from mark)
 then 'above average'
 else 'below average'
 end as performance 
 from mark 
 group by student_id;





