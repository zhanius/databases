create table dealer
(
    id         integer primary key,
    name       varchar(255),
    location   varchar(255),
    commission float
);

INSERT INTO dealer (id, name, location, commission)
VALUES (101, 'Oleg', 'Astana', 0.15);
INSERT INTO dealer (id, name, location, commission)
VALUES (102, 'Amirzhan', 'Almaty', 0.13);
INSERT INTO dealer (id, name, location, commission)
VALUES (105, 'Ademi', 'Taldykorgan', 0.11);
INSERT INTO dealer (id, name, location, commission)
VALUES (106, 'Azamat', 'Kyzylorda', 0.14);
INSERT INTO dealer (id, name, location, commission)
VALUES (107, 'Rahat', 'Satpayev', 0.13);
INSERT INTO dealer (id, name, location, commission)
VALUES (103, 'Damir', 'Aktobe', 0.12);

create table client
(
    id        integer primary key,
    name      varchar(255),
    city      varchar(255),
    priority  integer,
    dealer_id integer references dealer (id)
);

INSERT INTO client (id, name, city, priority, dealer_id)
VALUES (802, 'Bekzat', 'Satpayev', 100, 101);
INSERT INTO client (id, name, city, priority, dealer_id)
VALUES (807, 'Aruzhan', 'Almaty', 200, 101);
INSERT INTO client (id, name, city, priority, dealer_id)
VALUES (805, 'Али', 'Almaty', 200, 102);
INSERT INTO client (id, name, city, priority, dealer_id)
VALUES (808, 'Yerkhan', 'Taraz', 300, 102);
INSERT INTO client (id, name, city, priority, dealer_id)
VALUES (804, 'Aibek', 'Kyzylorda', 300, 106);
INSERT INTO client (id, name, city, priority, dealer_id)
VALUES (809, 'Arsen', 'Taldykorgan', 100, 103);
INSERT INTO client (id, name, city, priority, dealer_id)
VALUES (803, 'Alen', 'Shymkent', 200, 107);
INSERT INTO client (id, name, city, priority, dealer_id)
VALUES (801, 'Zhandos', 'Astana', null, 105);

create table sell
(
    id        integer primary key,
    amount    float,
    date      timestamp,
    client_id integer references client (id),
    dealer_id integer references dealer (id)
);

INSERT INTO sell (id, amount, date, client_id, dealer_id)
VALUES (201, 150.5, '2021-10-05 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id)
VALUES (209, 270.65, '2021-09-10 00:00:00.000000', 801, 105);
INSERT INTO sell (id, amount, date, client_id, dealer_id)
VALUES (202, 65.26, '2021-10-05 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id)
VALUES (204, 110.5, '2021-08-17 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id)
VALUES (207, 948.5, '2021-09-10 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id)
VALUES (205, 2400.6, '2021-07-27 00:00:00.000000', 807, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id)
VALUES (208, 5760, '2021-09-10 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id)
VALUES (210, 1983.43, '2021-10-10 00:00:00.000000', 804, 106);
INSERT INTO sell (id, amount, date, client_id, dealer_id)
VALUES (203, 2480.4, '2021-10-10 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id)
VALUES (212, 250.45, '2021-06-27 00:00:00.000000', 808, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id)
VALUES (211, 75.29, '2021-08-17 00:00:00.000000', 803, 107);
INSERT INTO sell (id, amount, date, client_id, dealer_id)
VALUES (213, 3045.6, '2021-04-25 00:00:00.000000', 802, 101);


--1
--a. find those clients with a priority less than 300
select name
from client
where priority < 300;

--b. combine each row of dealer table with each row of client table
select *
from dealer d
         CROSS JOIN client;

--c. find all dealers along with client name, city, priority, sell number, date, and amount
select c.id, c.name, c.dealer_id, c.city, c.priority
from client c
         left join dealer d on c.dealer_id = d.id;

--d. find the dealer and client who reside in the same city
select *
from dealer d
         join client c on d.location = c.city;

--e. find sell id, amount, client name, city those sells where sell amount exists between 200 and 500.
select s.id, s.amount, c.name, c.city
from client c
         join sell s on c.id = s.client_id
where s.amount between 200 and 500;

--f. find dealers who works either for one or more client or not yet join under any of the clients.
select *
from dealer d
         left join client c on d.id = c.dealer_id;

--g. find the dealers and the clients he service, return client name, city, dealer name, commission.
select c.name, c.city, d.name, d.commission
from dealer d
         join client c on d.id = c.dealer_id;

--h. find client name, client city, dealer, commission those dealers who received a commission from the sell more than 13%
select c.name, c.city, d.name, d.commission
from client c
         join dealer d on c.dealer_id = d.id
where d.commission > 0.13;

--i. make a report with client name, city, sell id, sell date, sell amount, dealer name and commission to find that either any of the
-- existing clients haven’t made a purchase(sell) or made one or more purchase(sell) by their dealer or by own.
select c.name, c.city, s.id, s.date, s.amount, d.name, d.commission
from client c
         left join sell s on s.client_id = c.id
         join dealer d on c.dealer_id = d.id;

--j. find dealers who either work for one or more clients. The client may have made, either one or more purchases,
-- or purchase amount above 2000 and must have a priority, or he may not have made any purchase to the associated dealer.
-- Print client name, client priority, dealer name, sell id, sell amount.
SELECT c.name AS client_name, c.priority, d.name AS dealer_name, s.id AS sell_id, s.amount
FROM client c
JOIN dealer d ON c.dealer_id = d.id
LEFT JOIN sell s ON c.id = s.client_id
WHERE
    s.amount > 2000 AND c.priority IS NOT NULL OR
    s.id IS NOT NULL AND c.priority IS NOT NULL OR
    s.id IS NULL AND c.priority IS NOT NULL;
--2. views:
--a. count the number of unique clients, compute average and total purchase amount of client orders by each date.
create or replace view view1 as
select count(distinct (c.id)),
       avg(s.amount),
       sum(s.amount)
from client c
         join sell s on c.id = s.client_id;

select *
from view1;
--b. find top 5 dates with the greatest total sell amount.
create view date1 as
select date
from sell
order by amount desc
limit 5;
select *
from date1;

--c. count the number of sales, compute average and total amount of all sales of each dealer.
create or replace view view2 as
select count(sell.*), avg(sell.amount), sum(sell.amount)
from sell
         join dealer on sell.dealer_id = dealer.id;
select *
from view2;

--d. compute how much all dealers earned from commission (total sell amount*commission) in each location.
create or replace view view3 as
select sum(d.commission * s.amount), d.location
from dealer d
         join sell s on d.id = s.dealer_id
group by d.location;
select *
from view3;

--e. compute number of sales, average and total amount of all sales dealers made in each location.
create or replace view view4 as
select count(sell.*), avg(sell.amount), sum(sell.amount)
from sell
         join dealer on sell.dealer_id = dealer.id
group by dealer.location;
select *
from view4;

--f. compute number of sales, average and total amount of expenses in each city clients made.
create or replace view view5 as
select count(sell.*), avg(sell.amount), sum(sell.amount)
from sell
         join client on sell.client_id = client.id
group by client.city;
select *
from view5;

--g. find cities where total expenses more than total amount of sales in locations.
create or replace view view6 as
select client.city
from client
         join dealer d on d.id = client.dealer_id
         join sell s on d.id = s.client_id;
select *
from view6;












