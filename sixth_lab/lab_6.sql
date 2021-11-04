--1A combine each row of dealer table with each row of client table
select * from client inner join dealer on dealer.id = client.dealer_id;

--1B find all dealers along with client name, city, grade, sell number, date, and amount
select client.name, client.city, client.priority, sell.id, date, amount, dealer.name from sell inner join dealer on dealer_id = dealer.id
    inner join client on client_id = client.id;

--1C find the dealer and client who belongs to same city
select * from client inner join dealer on dealer.id = client.dealer_id where client.city = dealer.location;

--1D find sell id, amount, client name, city those sells where sell amount exists between 100 and 500
select sell.id, amount, client.name, client.city from sell inner join dealer on dealer_id = dealer.id
    inner join client on client_id = client.id where amount >= 100  and amount <= 500;

--1E find dealers who works either for one or more client or not yet join under any of the clients
select * from dealer left outer join client on dealer_id = dealer.id;

--1F find the dealers and the clients he service, return client name, city, dealer name, commission.
select client.name, client.city, dealer.name, dealer.charge from dealer left outer join client on dealer_id = dealer.id;

--1G find client name, client city, dealer, commission those dealers who received a commission from the sell more than 12%
select client.name, client.city, dealer.name, dealer.charge from dealer left outer join client on dealer_id = dealer.id where charge > 0.12;

--1H make a report with client name, city, sell id, sell date, sell amount, dealer name and commission to find that either any of the existing clients haven’t made a
--purchase(sell) or made one or more purchase(sell) by their dealer or by own
select client.name, client.city, sell.id, sell.date, sell.amount, dealer.name, dealer.charge from client
    left outer join sell on client.id = sell.client_id left outer join dealer on dealer.id = sell.dealer_id;

--1I find dealers who either work for one or more clients. The client may have made, either one or more purchases, or purchase amount above 2000 and must have a
-- grade, or he may not have made any purchase to the associated dealer. Print client name, client grade, dealer name, sell id, sell amount
select client.name, sum(amount) from sell right outer join client on sell.client_id = client.id left outer join dealer on sell.dealer_id = dealer.id group by client.name;
select client.name, client.priority, dealer.name, sell.id, sell.amount from sell right outer join client on sell.client_id = client.id left outer join dealer on sell.dealer_id = dealer.id where amount >= 2000 or dealer.id is NULL group by client.name, client.priority, dealer.name, sell.id;

--2A count the number of unique clients, compute average and total purchase amount of client orders by each date.
CREATE VIEW first_view
    as select sell.date, count(client_id) as unique_clients, avg(amount) as average, sum(amount) as total from sell group by sell.date;
select * from first_view;

--2B find top 5 dates with the greatest total sell amount
CREATE VIEW second_view
    as select sell.date, sum(amount) as total from sell group by sell.date order by total desc limit 5;
select * from second_view;

--2C count the number of sales, compute average and total amount of all sales of each dealer

CREATE VIEW third_view
    as select sell.dealer_id, count(dealer_id), avg(amount), sum(amount) from sell group by sell.dealer_id;
select * from third_view;

--2D compute how much all dealers earned from charge(total sell amount * charge) in each location

CREATE VIEW fourth_view
    as select dealer.location, sum(amount*dealer.charge) from sell inner join dealer on dealer_id = dealer.id
    group by dealer.location;
select * from fourth_view;

--2E compute number of sales, average and total amount of all sales dealers made in each location
CREATE VIEW fifth_view
    as select location, count(location), avg(amount), sum(amount) from sell inner join dealer on dealer_id = dealer.id
     group by dealer.location;
select * from fifth_view;


--2F compute number of sales, average and total amount of expenses in each city clients made.
CREATE VIEW sixth_view
    as select client.city, count(client_id), (sum(amount*dealer.charge+amount) / count(client_id)) as avg_expenses, sum(amount*dealer.charge + amount) from client inner join sell on client.id = sell.client_id
     inner join dealer on sell.dealer_id = dealer.id
     group by client.city;
select * from sixth_view;



--2G Find cities where total expenses more than total amount of sales in locations
select location from sell inner join dealer on dealer_id = dealer.id
     where (amount*dealer.charge+amount) > sell.amount group by dealer.location ;




INSERT INTO client values (666, 'Test', 'Almaty', 100,101);
delete from client where id = 666;
INSERT INTO dealer (id, name, location, charge) VALUES (141, 'Тест', 'Алматы', 0.15);
delete from dealer where id = 141;