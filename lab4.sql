--1
create database lab4;

--3
INSERT INTO Warehouses(code, location, capacity)
VALUES (1, 'Chicago', 3);
INSERT INTO Warehouses(code, location, capacity)
VALUES (2, 'Rocks', 4);
INSERT INTO Warehouses(code, location, capacity)
VALUES (3, 'New York', 7);
INSERT INTO Warehouses(code, location, capacity)
VALUES (4, 'Los Angeles', 2);
INSERT INTO Warehouses(code, location, capacity)
VALUES (5, 'San Francisko', 8);

INSERT INTO Packs(code, contents, value, warehouse)
VALUES ('0MN7', 'Rocks', 180, 3);
INSERT INTO Packs(code, contents, value, warehouse)
VALUES ('4H8P', 'Rocks', 250, 1);
INSERT INTO Packs(code, contents, value, warehouse)
VALUES ('4RT3', 'Scissors', 190, 4);
INSERT INTO Packs(code, contents, value, warehouse)
VALUES ('7G3H', 'Rocks', 200, 1);
INSERT INTO Packs(code, contents, value, warehouse)
VALUES ('8JN6', 'Papers', 75, 1);
INSERT INTO Packs(code, contents, value, warehouse)
VALUES ('8Y6U', 'Papers', 50, 3);
INSERT INTO Packs(code, contents, value, warehouse)
VALUES ('9J6F', 'Papers', 175, 2);
INSERT INTO Packs(code, contents, value, warehouse)
VALUES ('LL08', 'Rocks', 140, 4);
INSERT INTO Packs(code, contents, value, warehouse)
VALUES ('P0H6', 'Scissors', 125, 1);
INSERT INTO Packs(code, contents, value, warehouse)
VALUES ('P2T6', 'Scissors', 150, 2);
INSERT INTO Packs(code, contents, value, warehouse)
VALUES ('TUSS', 'Papers', 90, 5);

--2
create table warehouses
(
    code     integer not null,
    location varchar(255),
    capacity integer,
    primary key (code)
);

create table packs
(
    code      char(4) not null,
    contents  varchar(255),
    value     real,
    warehouse integer,
    foreign key (warehouse) references warehouses (code)
);


--4 Select all packs with all columns
select *
from packs;

--5 Select all packs with a value larger than $190
select *
from packs
where value > 190;

--6 Select all the packs distinct by contents
select distinct on (contents) *
from packs;

--7 Select the warehouse code and the number of the packs in each warehouse
select code, count(warehouse)
from packs
group by code;

--8 Select only those warehouses where the number of the packs is greater than 2
select *
from warehouses
where code in (select warehouse from packs group by warehouse having count(contents) > 2);

--9 Create a new warehouse in Texas with a capacity for 5 packs
insert into warehouses(code, location, capacity)
values (4, 'Texas', 5);

--10 Create a new pack, with code "H5RT", containing "Papers"with a value of $150, and located in warehouse
insert into packs(code, contents, value, warehouse)
values ('H5RT', 'Papers', 150, 4);

--11 Reduce the value of the third largest pack by 18%
update packs
set value = value * 0.82
where code =
      (select code from (select code, row_number() over (order by value desc) as row from packs) as bla where row = 3);

--12 Remove all packs with a value lower than $150
delete
from packs
where value < 150;

--13 Remove all packs which is located in Chicago. Statement should return all deleted data
delete
from packs
where warehouse = (select code
                   from warehouses
                   where location = 'Chicago');

drop table packs cascade;
drop table warehouses cascade;


