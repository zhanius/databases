--2. Create following tables
create table locations
(
    location_id    serial primary key,
    street_address varchar(25),
    postal_code    varchar(12),
    city           varchar(30),
    state_province varchar(12)
);

create table departments
(
    department_id   serial primary key,
    department_name varchar(50) unique,
    budget          integer,
    location_id     integer references locations
);

create table employees
(
    employee_id   serial primary key,
    first_name    varchar(50),
    last_name     varchar(50),
    email         varchar(50),
    phone_number  varchar(20),
    salary        integer,
    department_id integer references departments
);
--3. Enter 5 values rows to each table locations, departments, employees.
--   The values of column department id should be: 30, 50, 60, 70, 80.
insert into locations(street_address, postal_code, city, state_province)
values ('123 Main St', '12345', 'New York', 'NY'),
       ('456 Elm St', '54321', 'Los Angeles', 'CA'),
       ('789 Oak St', '98765', 'Chicago', 'IL'),
       ('101 Pine St', '11111', 'San Francisco', 'CA'),
       ('202 Maple St', '22222', 'Houston', 'TX');

insert into departments(department_id, department_name, budget, location_id)
values (30, 'HR', 100000, 1),
       (50, 'IT', 150000, 2),
       (60, 'Finance', 120000, 3),
       (70, 'Marketing', 90000, 4),
       (80, 'Sales', 110000, 5);

insert into employees(first_name, last_name, email, phone_number, salary, department_id)
values ('John', 'Doe', 'john.doe@example.com', '123-456-7890', 60000, 30),
       ('Jane', 'Smith', 'jane.smith@example.com', '234-567-8901', 70000, 50),
       ('David', 'Johnson', 'david.johnson@example.com', '345-678-9012', 80000, 60),
       ('Sarah', 'Williams', 'sarah.williams@example.com', '456-789-0123', 75000, 70),
       ('Michael', 'Brown', 'michael.brown@example.com', '567-890-1234', 90000, 80);
--4. Select  the  first  name, last  name,  department  id,
--   and department name for each employee.
select e.first_name, e.last_name, e.department_id, d.department_name
from employees e
         join departments d on e.department_id = d.department_id;

--5. Select  the  first  name,  last  name,  department  id
--   and department name, for all employees for departments 80 or 30.
select e.first_name, e.last_name, e.department_id, d.department_name
from employees e
         join departments d on e.department_id = d.department_id
where d.department_id >= 30
  and d.department_id <= 80;

--6. Select the first and last name, department, city, and state province for
--   each employee.
select e.first_name, e.last_name, d.department_name, l.city, l.state_province
from employees e
         join departments d on e.department_id = d.department_id
         join locations l on d.location_id = l.location_id;

--7. Select all departments including those where does not have any employee.
select *
from departments d
         left join employees e on d.department_id = e.department_id;

--8. Select the first name, last name, department id and name,
--   for all employees who have or have not any department.
select e.first_name, e.last_name, e.department_id, d.department_name
from employees e
         left outer join departments d on e.department_id = d.department_id;

--9. Select the employee last name, first name, who works in New York.
select e.last_name, e.first_name, l.city
from employees e
         join departments d on e.department_id = d.department_id
         join locations l on d.location_id = l.location_id
where l.city = 'New York';














