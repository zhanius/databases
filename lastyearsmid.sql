create table worker
(
    worker_id    int primary key,
    first_name   varchar(100),
    last_name    varchar(100),
    salary       int not null,
    joining_date timestamp,
    department   varchar(100)
);

create table bonus
(
    worker_ref_id int not null references worker (worker_id),
    bonus_date    timestamp,
    bonus_amount  int
);

create table title
(
    worker_ref_id int not null references worker (worker_id),
    worker_title  varchar(100),
    affected_from timestamp
);

insert into worker(worker_id, first_name, last_name, salary, joining_date, department)
values (1, 'Monika', 'Arora', 100000, '2014-02-20 09:00:00', 'HR'),
       (2, 'Niharika', 'Verma', 80000, '2014-06-11 09:00:00', 'Admin'),
       (3, 'Vishal', 'Singhal', 300000, '2014-02-20 09:00:00', 'HR'),
       (4, 'Amitabh', 'Singh', 500000, '2014-02-20 09:00:00', 'Admin'),
       (5, 'Vivek', 'Bhati', 500000, '2014-06-11 09:00:00', 'Admin'),
       (6, 'Vipul', 'Diwan', 200000, '2014-06-11 09:00:00', 'Account'),
       (7, 'Satish', 'Kumar', 75000, '2014-01-20 09:00:00', 'Account'),
       (8, 'Geetika', 'Chauhan', 90000, '2014-04-11 09:00:00', 'Admin');

insert into bonus(worker_ref_id, bonus_date, bonus_amount)
values (1, '2016-02-20 00:00:00', 5000),
       (2, '2016-06-11 00:00:00', 3000),
       (3, '2016-02-20 00:00:00', 4000),
       (1, '2016-02-20 00:00:00', 4500),
       (2, '2016-06-11 00:00:00', 3500);

insert into title(worker_ref_id, worker_title, affected_from)
values (1, 'Manager', '2016-02-20 00:00:00'),
       (2, 'Executive', '2016-06-11 00:00:00'),
       (8, 'Executive', '2016-06-11 00:00:00'),
       (5, 'Manager', '2016-06-11 00:00:00'),
       (4, 'Manager', '2016-06-11 00:00:00'),
       (7, 'Asst. Manager', '2016-06-11 00:00:00'),
       (6, 'Lead', '2016-06-11 00:00:00'),
       (3, 'Lead', '2016-06-11 00:00:00');


--1 Select workers which have letter «a» in their name.
select *
from worker
where first_name ilike '%a%';
--2 Select the top 5 workers by salary.
select *
from worker
order by salary desc
limit 5;
--3 Select the fifth largest salary of workers.
select *
from worker
order by salary desc
offset 4 limit 1;
--4 Select all workers which have more than 10000 bonus_amount in total
select w.first_name, w.last_name, sum(b.bonus_amount) total_bonus
from worker w
         join bonus b on w.worker_id = b.worker_ref_id
group by w.first_name, w.last_name
having sum(b.bonus_amount) > 10000;
--5 Select all workers except workers with title «Executive».
select *
from worker w
         join title t on w.worker_id = t.worker_ref_id
where t.worker_title not in ('Executive');
--6 Show all movies in the following format with aliases:
-- WorkerID    |  WorkerInfo
-- 1           |  The salary of Monika Arora is 100000 dollars
-- 2           |  The salary of Niharika Verma is 80000 dollars

select worker_id                                                                        as "WorkerID",
       concat('The salary of ', first_name, ' ', last_name, ' is ', salary, ' dollars') as "WorkerINFO"
from worker;

--8 Select departments that have more than three people in it
select department
from worker
group by department
having count(department) > 3;
--9 Select all worker by dividing to three categories (if NULL print «No salary»):
--  1) Small salary (0-50000); 2) Medium salary (50001-100000); 3) High salary
--  (>100000)
select worker_id,
       first_name,
       last_name,
       salary,
       case
           when salary is null then 'No salary'
           when salary <= 50000 then 'Small salary'
           when salary > 50000 and salary <= 100000 then 'Medium salary'
           when salary > 100000 then 'High salary'
           else 'Unknown' end as salary_category
from worker;
--10 Set the salary of all workers without salary to 0.
update worker set salary = 0 where salary is null;












