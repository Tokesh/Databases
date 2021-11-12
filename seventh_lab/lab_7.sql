/*Ex 1. How can we store large-object types?
    photos,videos,CAD files, etc.
  blobl: binary large object -- object is a large collection of uninterpreted binary data(whose interpretation is left to an application
  outside of the database system)
  clob: character large object -- object is a large collection of character data
  * When query return a large object, a pointer is returned rather than the large object itself

 */


 /* Ex 2 What is the difference between privilege, role and user?
    Role is a collection of system object privileges and other roles.
    It simplifies privilege management by allowing you to manage bundles of privileges.
    We create a user - so that a specific person can enter and use the tables.
    Here, if everything is created and distributed correctly, then all data will be safe.
  */

--create accountant, administrator, support roles and grant appropriate privileges
create role accountant;
create role administrator;
create role support;
grant SELECT on transactions to accountant;
grant ALL on transactions, customers, accounts to administrator with grant option;
grant INSERT, UPDATE, DELETE on customers, accounts to support;

--create some users and assign them roles
--give to some of them permission to grant roles to other users
--revoke some privilege from particular user


create USER Ivan_Popov CREATEDB;
grant administrator to ivan_popov;

create USER Symbat_Essimkylova;
grant accountant to symbat_essimkylova;

create USER Nikita_Kim;
grant support to symbat_essimkylova;
grant support to nikita_kim;

revoke support from symbat_essimkylova;


select * from pg_roles;
SELECT * FROM   information_schema.table_privileges where grantee = 'administrator';

/* Ex 3
Add appropriate constraints
check if transaction has same currency for source and destination accounts (use assertion)
add not null constraints
 */

 /*
  Ex 4 Change currency column type to user-defined in accounts table
  */
create type Currency_new as ENUM('KZT', 'USD', 'EUR');
alter table accounts alter column currency type Currency_new using currency::currency_new;
SELECT pg_typeof("currency") from accounts;

/*
 Ex 5
 Create indexes:
○ index so that each customer can only have one account of one currency
○ index for searching transactions by currency and balance
 */
 create unique index customer on accounts(customer_id);
 create index b_sol on accounts(currency,balance);


/*
 Ex 6
 Write a SQL transaction that illustrates money transaction from one
account to another:
○ create transaction with “init” status
○ increase balance for destination account and decrease for source
account
○ if in source account balance becomes below limit, then make
rollback
○ update transaction with appropriate status(commit or rollback)
 */
DO $$
  DECLARE
    role_count int;
    limit_c int;
BEGIN
  insert into transactions(id, date, src_account, dst_account, amount, status) values(5, '11.11.2021', 'NK90123', 'AB10203', 200, 'init');
  role_count = (select balance from accounts where account_id = 'NK90123')-200;
  limit_c = (select limitz from accounts where account_id = 'NK90123');
  IF role_count < limit_c THEN
    update transactions set status = 'rollback' where id = 5;
  ELSE
    update accounts set balance = balance-200 where account_id='NK90123';
    update accounts set balance = balance+200 where account_id='AB10203';
    update transactions set status = 'commit' where id = 5;
    commit;
  END IF;
  commit;
END$$;