
-- 1. Create a function that:
--1A Increments given values by 1 and returns it.
CREATE OR REPLACE FUNCTION inc(val integer) RETURNS integer AS
$$
BEGIN
    RETURN val + 1;
END;
$$
    LANGUAGE PLPGSQL;
select inc(1);


--1B Returns sum of 2 numbers.
CREATE OR REPLACE FUNCTION sumi(val1 integer, val2 integer) RETURNS integer AS
$$
BEGIN
    RETURN val1 + val2;
END;
$$
    LANGUAGE PLPGSQL;
select sumi(1,5);


--1C Returns true or false if numbers are divisible by 2.
CREATE OR REPLACE FUNCTION div_2(val integer) returns boolean AS
$$
BEGIN
    return MOD(val, 2) = 0;
END
$$
    Language plpgsql;

select div_2(6);

--1D Checks some password for validity.
CREATE OR REPLACE FUNCTION pass_val(in pass text, out z boolean) AS
$$
BEGIN
    z := (length(pass) > 7) and (length(pass) <=15) and (pass ~ '[!@#$%^&*()_+.,/]' is false);
END
$$
    language plpgsql;
select pass_val('lookatme2');

--1E Returns two outputs, but has one input
CREATE OR REPLACE FUNCTION square_m(in val integer, out casual integer, out squared integer) AS
$$
BEGIN
    casual := val;
    squared := val*val;
END
$$
    LANGUAGE plpgsql;

select square_m(4);
select * from square_m(4);

/*
2. Create a trigger that:
a. Return timestamp of the occured action within the database.
b. Computes the age of a person when persons’ date of birth is inserted.
c. Adds 12% tax on the price of the inserted item.
d. Prevents deletion of any row from only one table.
e. Launches functions 1.d and 1.e.
 */



/*
  3 What is the difference between procedure and function?
    Procedures can be reused and shared by multiple programs.
    Procedures can access or modify data in a database
  A procedure does not have a return type. But it returns values using the OUT parameters.
  You can use DML queries such as insert, update, select etc… with procedures.
  A procedure allows both input and output parameters.
  You can manage transactions inside a procedure.
  You can call a function from a stored procedure.
  You cannot call a procedure using select statements.
 */

/*
4.Create procedures that:
a) Increases salary by 10% for every 2 years of work experience and provides
10% discount and after 5 years adds 1% to the discount.
b) After reaching 40 years, increase salary by 15%. If work experience is more
than 8 years, increase salary for 15% of the already increased value for work
experience and provide a constant 20% discount.
 */
CREATE TABLE ss(
    id integer primary key,
    name varchar,
    date_of_birth date,
    age integer,
    salary integer,
    workexperience integer,
    discount integer
);
insert into ss(id, name, date_of_birth, age, salary, workexperience, discount) values(1, 'Tokesh', '27.10.2002', 19, 66000, 1, 10);
insert into ss(id, name, date_of_birth, age, salary, workexperience, discount) values(2, 'Zaur', '14.12.1998', 23, 190000, 3, 12);
insert into ss(id, name, date_of_birth, age, salary, workexperience, discount) values(3, 'Alexander', '23.04.1996', 25, 99999, 5, 14);
insert into ss(id, name, date_of_birth, age, salary, workexperience, discount) values(4, 'Torontokyo', '13.04.1992', 29, 625000, 8, 15);
insert into ss(id, name, date_of_birth, age, salary, workexperience, discount) values(5, 'Konstatin', '05.02.1980', 41, 2400000, 12, 22);
