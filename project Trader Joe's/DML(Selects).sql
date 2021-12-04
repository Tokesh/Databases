--A
select store_id, product_id, count(product_id) from orders inner join order_items on orders.order_id = order_items.order_id group by product_id, store_id ;
select store_id, product_id, coun from(
    select store_id, product_id, count(product_id) as coun, row_number() over(partition by store_id order by count(product_id) desc) rowNum from orders
        inner join order_items on orders.order_id = order_items.order_id group by product_id, store_id
    )tbl
where rowNum <= 20 order by store_id, coun desc;


select store_id, product_id, sum(count) from orders inner join order_items on orders.order_id = order_items.order_id group by product_id, store_id order by sum(count);
select store_id, product_id, coun from(
    select store_id, product_id, sum(count) as coun, row_number() over(partition by store_id order by sum(count) desc) rowNum from orders
        inner join order_items on orders.order_id = order_items.order_id group by product_id, store_id
    )tbl
where rowNum <= 20 order by store_id, coun desc;


--B
select state_name, product_id, coun from(
select state_name, product_id, sum(count) as coun,row_number() over(partition by state_name order by sum(count) desc) rowNum from order_items
    inner join orders on orders.order_id = order_items.order_id inner join stores on orders.store_id=stores.store_id
    group by product_id, state_name,count order by sum(count) desc
) tbl
where rowNum <= 20 order by state_name, coun desc;


--C
select store_id, count(store_id) from orders where date_time > '01.01.2015' group by store_id order by count(store_id);
select store_id, coun, z from(
select store_id, count(store_id) as coun, dense_rank() over(order by count(store_id) desc) as z from orders where date_time > '01.01.2015' group by store_id
)tbz
where z <= 5 order by coun desc, store_id;

--D

select product_id, count(product_id) from order_items group by product_id order by count(product_id);
select store_id, product_id, sum(count) from orders inner join order_items on orders.order_id = order_items.order_id where product_id=19 or product_id = 33 group by product_id, store_id order by sum(count);
select count(*) from (select store_id, sum(count) as sum1 from orders inner join order_items on orders.order_id = order_items.order_id where product_id = 19 group by store_id)
    as z full join (select store_id, sum(count) as sum2 from orders inner join order_items on orders.order_id = order_items.order_id where product_id = 33 group by store_id) as k on z.store_id =k.store_id where sum1 > sum2;

--E

select order_id, product_id from order_items where order_id in (select distinct order_id from order_items where product_id = 14)group by order_id, product_id, count order by order_id, count;
select product_id, count(product_id) as k from (select order_id, product_id, count from order_items where order_id in (select distinct order_id from order_items where product_id = 14)group by order_id, product_id, count order by order_id, count) as Z where product_id != 14 group by product_id order by k desc;


select product_type_id, sum(count) from products inner join
    (select product_id, count from (select product_id, count from order_items where order_id in (select distinct order_id from order_items where product_id = 14)
    group by product_id, count order by count) as Z
    where product_id != 14 group by product_id,count) as qwer
        on qwer.product_id = products.product_id group by product_type_id order by sum(count) desc;


select product_type_id, r from(
    (select product_type_id, sum(count) as r from products inner join
    (select product_id, count from (select product_id, count from order_items where order_id in (select distinct order_id from order_items where product_id = 14)
    group by product_id, count order by count) as Z
    where product_id != 14 group by product_id,count) as qwer
    on qwer.product_id = products.product_id group by product_type_id order by sum(count) desc)) as k
where r > 5 limit 5;



--Index

create index main_ind on order_items(order_id, product_id);
create index second_ind on orders(order_id,store_id);
explain select * from order_items where product_id > 2 and order_id < 10;

