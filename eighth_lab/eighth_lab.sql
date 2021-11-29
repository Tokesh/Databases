
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
b. Computes the age of a person when persons’ date of birth is inserted.
c. Adds 12% tax on the price of the inserted item.
d. Prevents deletion of any row from only one table.
e. Launches functions 1.d and 1.e.
 */
 --2A
drop table employees;
drop table employee_audits;

CREATE TABLE employees(
   id INT GENERATED ALWAYS AS IDENTITY,
   first_name VARCHAR(40) NOT NULL,
   last_name VARCHAR(40) NOT NULL,

   PRIMARY KEY(id)
);
CREATE TABLE employee_audits (
    date_occured date
);


CREATE OR REPLACE FUNCTION date_ret()
  RETURNS TRIGGER
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
	INSERT INTO employee_audits(date_occured) values(CURRENT_TIMESTAMP);
	RETURN NEW;
END;
$$
CREATE TRIGGER last_name_changes
  BEFORE insert
  ON employees
  FOR EACH ROW
  EXECUTE PROCEDURE date_ret();

insert into employees( first_name, last_name) values('Tokesh','Niyazbek');


--2B
drop table employee_audits;
drop table employeeszz;
drop function age_ret();

CREATE TABLE employeeszz(
    id INT GENERATED ALWAYS AS IDENTITY,
    date_birth date,
    PRIMARY KEY(id)
);

CREATE TABLE employee_audits (
    age integer
);

CREATE OR REPLACE FUNCTION age_ret()
  RETURNS TRIGGER
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
	INSERT INTO employee_audits(age) values(EXTRACT(year FROM age(current_date,new.date_birth)) :: int);
	RETURN NEW;
END;
$$

CREATE TRIGGER b2
  BEFORE insert
  ON employeeszz
  FOR EACH ROW
  EXECUTE PROCEDURE age_ret();

insert into employeeszz(date_birth) values('27.10.2002');


--2C
drop table employtest;
drop table employee_test;
CREATE TABLE employtest(
    id INT GENERATED ALWAYS AS IDENTITY,
    price float8,
    PRIMARY KEY(id)
);

CREATE TABLE employee_test (
    total float8
);

CREATE OR REPLACE FUNCTION new_price()
  RETURNS TRIGGER
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
	insert into employee_test(total) values(new.price * 1.05);
	RETURN NEW;
END;
$$

CREATE TRIGGER c2
  BEFORE insert
  ON employtest
  FOR EACH ROW
  EXECUTE PROCEDURE new_price();

insert into employtest(price) values(14);
--2D
CREATE TABLE employtest_2d(
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar,
    last_name varchar,
    PRIMARY KEY(id)
);
CREATE TABLE test2d (
    name varchar,
    last_name varchar
);

CREATE OR REPLACE FUNCTION del_1()
  RETURNS TRIGGER
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
	insert into test2d(name,last_name) values(old.name,old.last_name);
	RETURN OLD;
END;
$$

CREATE TRIGGER d2
  before delete
  ON employtest_2d
  FOR EACH ROW
  EXECUTE PROCEDURE del_1();

insert into employtest_2d(name,last_name) values('Tokesh', 'Niyazbek');
delete  from employtest_2d where name = 'Tokesh';
--2E
CREATE TABLE employtest_2e(
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar,
    password varchar,
    PRIMARY KEY(id)
);

CREATE OR REPLACE FUNCTION check_pas()
  RETURNS TRIGGER
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
	if(pass_val(old.password) = false) THEN
        RETURN NEW;
    ELSE
	    return OLD;
    end if;
END;
$$

CREATE TRIGGER e2
  before insert
  ON employtest_2e
  FOR EACH ROW
  EXECUTE PROCEDURE check_pas();
insert into employtest_2e(name, password) values('Tokesh', 'lookatme2');

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


--4A
create or replace procedure transfer(
   id_e int
)
language plpgsql
as $$
    declare
        workexperiencez integer;
begin
    workexperiencez := (select workexperience from ss where id = id_e);
    -- subtracting the amount from the sender's account
    if(workexperiencez > 2) then
        update ss set salary = salary*1.10 where id = id_e;
        update ss set discount = discount + 10 where id = id_e;
    end if;
    if(workexperiencez > 5) then
        update ss set discount = discount + 1 where id = id_e;
    end if;
    commit;
end;$$

call transfer(2);

--4B

create or replace procedure adult_transfer(
   id_e int
)
language plpgsql
as $$
    declare
        agez integer;
        workexperiencez integer;
begin
    agez := (select age from ss where id = id_e);
    workexperiencez := (select workexperience from ss where id = id_e);
    -- subtracting the amount from the sender's account
    if(agez > 40) then
        update ss set salary = salary*1.15 where id = id_e;
    end if;
    if(workexperiencez > 8) then
        update ss set salary = salary*1.15 where id = id_e;
        update ss set discount = discount + 20 where id = id_e;
    end if;
    commit;
end;$$

call adult_transfer(5);


--5
with recursive recommenders(recommender, member) as (
	select memid,recommendedby
		from cd.members
	union all
	select mems.recommendedby, recommenders.member
		from recommenders
		inner join cd.members mems
			on mems.memid = recommenders.recommendedby
)
select cd.members.firstname, cd.members.surname
	from recommenders
	inner join cd.members.members
		on recommenders.recommender = cd.members.memid
	where recommenders.member = 22 or recommenders.member = 12
order by recommenders.member asc, recommenders.recommender desc
