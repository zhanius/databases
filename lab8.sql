create table employees(
    employee_id int primary key,
    first_name varchar(50),
    last_name varchar(50),
    gender varchar(10),
    department varchar(50),
    salary decimal(10,2)
);

insert into employees values
(1, 'John', 'Doe', 'Male', 'IT', 75000),
(2, 'Jane', 'Smith', 'Female', 'HR', 60000),
(3, 'Mark', 'Johnson', 'Male', 'Marketing', 80000),
(4, 'Emily', 'Davis', 'Female', 'Finance', 70000),
(5, 'Alex', 'Turner', 'Male', 'IT', 85000);

create table countries(
  country_id int primary key,
  country_name varchar(50),
  population bigint,
  continent varchar(50),
  capital varchar(50)
);

insert into countries values
(1, 'United States', 331002651, 'North America', 'Washington, D.C.'),
(2, 'China', 1402775000, 'Asia', 'Beijing'),
(3, 'Brazil', 212559417, 'South America', 'Brasília'),
(4, 'Germany', 83783942, 'Europe', 'Berlin'),
(5, 'Australia', 25499884, 'Australia', 'Canberra');


create table departments (
    id int primary key,
    department_name varchar(50) not null
);

insert into departments values
(1, 'IT'),
(2, 'HR'),
(3, 'Marketing'),
(4, 'Finance');

alter table employees
add column department_id int,
add foreign key (department_id) references departments(id);

alter table departments
add column budjet int;

update departments
set budjet = 500000 where department_name = 'IT';
update departments
set budjet = 700000 where department_name = 'HR';
update departments
set budjet = 800000 where department_name = 'Marketing';
update departments
set budjet = 400000 where department_name = 'Finance';

--1. Create index for queries like below:
--   SELECT* FROM countries WHERE name = ‘string’;
create index index_countries_names on countries(country_name);

--2. Create index for queries like below:
--   SELECT * FROM employees WHERE name = ‘string’ AND surname = ‘string’;
create index index_employees_names_surnames on employees(first_name, last_name);

--3. Create unique index for queries like below:
--   SELECT * FROM employees WHERE salary < value1 AND salary > value2;
create index index_employees_salaries on employees(salary) where salary > 60000 and salary < 80000;

--4. Create index for queries like below:
--   SELECT * FROM employees WHERE substring (name from 1 for 4) = ‘abcd’;
create index index_employees_names on employees(first_name) where first_name ilike 'jane';

--5. Create index for queries like below:
--   SELECT * FROM employees e JOIN departments d ON d.department_id = e.department_id WHERE d.budget > value2 AND e.salary < value2;
-- Index on employees.department_id
CREATE INDEX idx_employees_department_id ON employees (department_id);

-- Index on departments.department_id
CREATE INDEX idx_departments_department_id ON departments (id);

-- Index on departments.budget
CREATE INDEX idx_departments_budget ON departments (budjet);

-- Index on employees.salary
CREATE INDEX idx_employees_salary ON employees (salary);

select * from employees;







