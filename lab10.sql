--books
create table books(
    book_id int primary key not null,
    title varchar,
    author varchar,
    price decimal,
    quantity integer
);
--customers
create table customers(
    customer_id int not null primary key,
    name varchar,
    email varchar
);
--orders
create table orders(
    order_id int not null primary key,
    book_id int references books (book_id),
    customer_id int references customers(customer_id),
    order_date date,
    quantity integer
);
drop table orders cascade ;
insert into books(book_id,title, author, price, quantity)
values (1, 'Database 101','A.Smith',40.0,10),
       (2, 'Learn SQL','B.Johnson',35.0,15),
       (3, 'Advanced DB','C.Lee',50.0,5);

INSERT INTO customers (customer_id, name, email)
VALUES
  (101, 'John Doe', 'johndoe@example.com'),
  (102, 'Customer 2', 'johndoe@example.com');
update customers set name = 'Jane Doe', email = 'janedoe@example.com' where name = 'Customer 2';

--1. Transaction for Placing an Order
-- - Scenario: A customer places an order for a book. This should decrease the quantity of the book in the `Books` table and create a new record in the `Orders` table.
-- - Task:     - Start a transaction.
--             - Insert an order into the `Orders` table for `customer_id` 101 ordering 2 quantities of `book_id` 1.
--             - Update the `Books` table by reducing the quantity of `book_id` 1 by 2.
--             - Commit the transaction.
--             - Expected Outcome: The `Orders` table has a new record, and the `Books` table shows 8 as the new quantity for `book_id` 1.
start transaction;
insert into orders(order_id,book_id, customer_id, order_date, quantity)
values (1,1,101,current_date,2);
update books set quantity = quantity - 2 where book_id = 1;
commit;


--2. Transaction with Rollback
-- - Scenario: A customer attempts to order more books than are in stock, which should not be allowed.
-- - Task:     - Start a transaction.
--             - Attempt to insert an order into the `Orders` table for `customer_id` 102 ordering 10 quantities of `book_id` 3.
--             - Check if the quantity in `Books` is sufficient. If not, rollback the transaction.
--             - Expected Outcome: No change in the `Orders` or `Books` tables due to the rollback.

start transaction;
insert into orders(order_id, book_id, customer_id, order_date, quantity)
values (2, 3, 102, current_date, 10);
if (select quantity from books where book_id = 3) >= 10 then
    commit;
    update books set quantity = quantity - 10 where book_id = 3;
else
    rollback;
end if;
end transaction;

--3. Isolation Level Demonstration
-- - Scenario: Show the effect of different isolation levels in concurrent transactions.
-- - Task:      - In one session, start a transaction at READ COMMITTED isolation level, and update the price of a book in the `Books` table.
--              - In a second session, start another transaction at the same isolation level and read the price of the same book.
--              - Commit the first transaction and re-read the price in the second session.
--              - Expected Outcome: The second session reads the updated price after the first transaction commits, demonstrating the READ COMMITTED isolation level.

begin transaction isolation level read committed;
update books set price = price * 2 where book_id = 2;
commit;

begin transaction isolation level read committed;
select price from books where book_id = 2;
commit;

select price from books where book_id = 2;

select * from books;
--4. Durability Check
-- - Scenario: Ensure that the changes made by a transaction are permanent.
-- - Task:      - Perform a transaction where you update a customer's email in the `Customers` table.
--              - Commit the transaction.
--              - Restart the database server.
--              - Check the `Customers` table for the update.
--              - Expected Outcome: The new email address persists even after a database restart, demonstrating durability.
start transaction;
update customers set email = 'jaaanedoe@example.com' where name = 'Jane Doe';
commit;

select *
from customers;
