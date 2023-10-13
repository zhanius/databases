create database lab2;

--tasks with foreign,primary key
create table employees(
    emp_no      serial primary key,
    birth_date  date,
    first_name  varchar(14),
    last_name   varchar(16),
    gender      char,
    hire_date   date
);

create table titles(
    emp_no      int,
    title       varchar(50),
    from_date   date,
    to_date     date,
    foreign key (emp_no) references employees (emp_no)
);

create table salaries(
    emp_no      int,
    salary      int,
    from_date   date,
    to_date     date,
    foreign key (emp_no) references employees (emp_no)
);

create table departments(
    dept_no     char(4) primary key,
    dept_name   varchar(40)
);

create table dept_manager(
    dept_no     int,
    emp_no      int,
    from_date   date,
    to_date     date,
    foreign key (emp_no) references employees (emp_no),
    foreign key (dept_no) references departments (dept_no)
);

create table dept_emp(
    emp_no    int,
    dept_no   int,
    from_date date,
    to_date   date,
    foreign key (emp_no) references employees (emp_no),
    foreign key (dept_no) references departments (dept_no)
);


--tasks with tables
create table students(
    student_id      serial not null primary key,
    full_name       varchar(100) not null,
    age             int check(age>=5),
    birth_date      date not null,
    gender          char(1) check (gender in ('M','F')),
    average_grade   int check(average_grade>=0 and average_grade<=100),
    nationalty      varchar(50),
    phone_number    char(11) unique,
    social_category varchar(50)
);

create table instructors(
    instructors_id  serial not null primary key,
    first_name      varchar(50),
    languages       text[],
    work_experince  int check(work_experince>=0),
    remote_lessons  boolean
);

create table student_relatives(
    relative_id  serial not null primary key,
    student_id   int not null,
    full_name    varchar(100) not null,
    address      text,
    phone_number char(11) unique,
    position     varchar(50),
    foreign key (student_id) references students (student_id)
);

create table student_social_data(
    student_id      int not null,
    school          varchar(100) not null,
    graduation_date date,
    address         text,
    region          varchar(100),
    country         varchar(100),
    gpa             numeric(3,2),
    honors          text[]
);




--examples of insertion, update, deletion of data in the tables from ex2

--insert
insert into employees(birth_date, first_name, last_name, gender, hire_date)
values ('1985-08-10', 'Bob', 'Marley', 'F', '2010-02-15'),
       ('1995-11-25', 'Bob', 'Dylan', 'F', '2018-09-10'),
       ('1984-04-03', 'Jason', 'Statham', 'F', '2005-06-30'),
       ('1990-06-23', 'Jason', 'Derulo','F','2009-03-27'),
       ('1989-07-09', 'Lady','Gaga','M','2010-12-16');

--update
update employees
set first_name = 'Billie'
where first_name = 'Bob';

update employees
set hire_date = '2010-12-12'
where first_name = 'Jason';

--delete
delete from employees where first_name = 'Billie';
delete from employees where first_name = 'Jason';
delete from employees where gender = 'M';








/*
 DDL is used for defining and managing the structure of a database,
 including tables, schemas, indexes, constraints, and other database objects.
 */
 --examples of ddl
create table musicians(
    full_name varchar(100) not null,
    nickname varchar(50) not null,
    age int,
    carier_start int not null
);

alter table musicians
add column albums_number int;

alter table musicians
add column songs int;

alter table musicians
add column rule varchar(100);

drop table musicians;

/*
 DML is used for managing and manipulating data within a database.
 It involves operations like querying, inserting, updating, and deleting data in tables.
 */
--examples of dml
insert into musicians(full_name, nickname, age, carier_start,rule)
values ('James Marshall Hendrix', 'Jimi Hendrix', 28, '1966', 'American guitarist'),
       ('Marshall Bruce Mathers', 'Eminem', 48, '1998','Rapper');

update musicians
set age = 50
where nickname = 'Eminem';

select * from musicians;

delete from musicians where rule = 'Rapper';




