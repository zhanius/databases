-- 1.Write a stored procedure named increase_value that takes one integer parameter and returns the parameter value increased by 10.
CREATE OR REPLACE FUNCTION increase_to_10(in value INT)
    RETURNS INT AS
$$
BEGIN
    value := value + 10;
    RETURN value;
END;
$$ LANGUAGE plpgsql;



select increase_to_10(8);
-- 2.Create a stored procedure compare_numbers that takes two integers and returns 'Greater', 'Equal', or ‘Lesser' as an out parameter,
-- depending on the comparison result of these two numbers.
create or replace function compare_numbers(in value int, in value2 int, out result varchar)
    returns varchar as
$$
begin
    if value > value2 then
        result := 'Greater';
    elseif value < value2 then
        result := 'Lesser';
    else
        result := 'Equal';
    end if;
end;
$$ language plpgsql;

select compare_numbers(6, 7);

-- 3.Write a stored procedure number_series that takes an integer n and returns a series from 1 to n. Use a looping construct within the procedure.
create or replace function number_series(in n int)
    returns setof int as
$$
declare
    i int := 1;
begin
    while i <= n
        loop
            return next i;
            i := i + 1;
        end loop;
    return;
end;
$$ language plpgsql;

select number_series(7);

-- 4.Write a stored procedure find_employee that takes an employee name as a parameter and returns the employee details by performing a query.
CREATE TABLE employees
(
    employee_id INT,
    first_name  VARCHAR(255),
    last_name   VARCHAR(255),
    department  VARCHAR(255),
    salary      DECIMAL(10, 2)
);

alter table employees add column bonus decimal(10,2);
alter table employees drop column bonus;
INSERT INTO employees
VALUES (1, 'John', 'Doe', 'HR', 50000.00),
       (2, 'Jane', 'Smith', 'IT', 60000.00),
       (3, 'Bob', 'Johnson', 'Finance', 75000.00),
       (4, 'Alice', 'Williams', 'Marketing', 55000.00);

create or replace function find_employee(in name varchar)
    returns table
            (
                id int,
                f_name  varchar,
                l_name   varchar,
                depart  varchar,
                salar      decimal
            )
as
$$
begin
    return query
        select employee_id,
               first_name,
               last_name,
               department,
               salary
        from employees
        where first_name = name;
end;
$$ language plpgsql;

drop function find_employee(name varchar);
drop table employees cascade ;
select find_employee('John');
select * from find_employee('John');

-- 5.Develop a stored procedure list_products that returns a table with product details from a given category.
create table products(
    product_name varchar,
    category_name varchar,
    price decimal(10,2)
);

insert into products (product_name, category_name, price)
values
    ('Laptop', 'Electronics', 1200.00),
    ('Smartphone', 'Electronics', 699.99),
    ('Running Shoes', 'Sports', 89.99),
    ('Dress Shirt', 'Clothing', 49.99),
    ('Coffee Maker', 'Appliances', 79.99),
    ('Headphones', 'Electronics', 99.99),
    ('Basketball', 'Sports', 29.99),
    ('Backpack', 'Accessories', 39.99),
    ('Blender', 'Appliances', 49.99);

create or replace function list_products(in category varchar)
returns table (name varchar, categoryy varchar, cost decimal) as
$$  begin
    return query
        select product_name, category_name, price from products where category_name = category;
    end;
    $$ language plpgsql;

select list_products('Electronics');

-- 6.Create two stored procedures where the first procedure calls the second one. For example, a procedure calculate_bonus
-- that calculates a bonus, and another procedure update_salary that uses calculate_bonus to update the salary of an employee.
create or replace function calculate_bonus(in name varchar)
returns decimal as
$$
    declare bonus decimal;
begin
    select salary*0.8 into bonus from employees where first_name = name;
    return bonus;
end;
$$ language plpgsql;

drop function calculate_bonus(name varchar);

create or replace function update_salary(in name varchar)
returns void as
$$  declare bonus decimal;
    begin
    bonus := calculate_bonus(name);
    update employees set salary = salary + bonus where first_name = name;

end;
$$ language plpgsql;

select update_salary('John');

select * from employees;

-- 7. •Write a stored procedure named complex_calculation.
--    •The procedure should accept multiple parameters of various types (e.g., INTEGER, VARCHAR).
--    •The main block should include at least two nested subblocks.
--    •Each subblock should perform a distinct operation (e.g., a string manipulation and a numeric computation).
--    •The main block should then combine results from these subblocks in some way.•Return a final result that depends on both subblocks' outputs.
--    •Use labels to differentiate the main block and subblocks.
create or replace function complex_calculation (in str_param varchar, in num_param int)
returns int as
$$
declare
  reversed_str varchar;
  square_num int;
begin
  -- Subblock 1: String manipulation
  reversed_str := reverse(str_param);

  -- Subblock 2: Numeric computation
  square_num := num_param * num_param;

  -- Combine results
  if reversed_str like '%a%' then
    -- The string contains 'a'
    return square_num + 1;
  else
    -- The string does not contain 'a'
    return square_num - 1;
  end if;
end;
$$ language plpgsql;

select complex_calculation('gabdyq',12);





