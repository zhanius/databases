--1
create database lab1;

--2,6
create table students(
  id serial not null primary key,
  first_name varchar(50),
  last_name varchar(50)
);

--3
alter table students
add column isadmin int;

--4
ALTER TABLE students
ALTER COLUMN isadmin TYPE boolean
USING isadmin::boolean;

--5
alter table students
alter isadmin set default false;


--7
create table tasks(
    id serial not null primary key,
    name varchar(50),
    user_id int
);

--8
drop table tasks;
--9
drop database lab1;