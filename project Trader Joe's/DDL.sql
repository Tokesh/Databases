drop table stores cascade;
drop table brands cascade;
drop table clients cascade;
drop table delivery_status cascade;
drop table order_delivery cascade;
drop table order_items cascade;
drop table orders cascade ;
drop table payment cascade ;
drop table product_type cascade ;
drop table products cascade ;
drop table store_inventory cascade ;
drop table vendor_delivery cascade ;
drop table vendors cascade ;

create table stores(
    store_id SERIAL PRIMARY KEY,
    state_name VARCHAR(100) CHECK(length(state_name) >= 5 and length(state_name) <= 30),
    city VARCHAR(100) CHECK(length(city) >= 5 and length(city) <= 40),
    street VARCHAR(255) not null,
    house_number VARCHAR(15) not null,
    phone_number VARCHAR not null CHECK(length(phone_number) >= 5 and length(state_name) <= 15),
    start_working_time time default '08:30',
    end_working_time time default '20:30'
);
create table clients(
    client_id SERIAL PRIMARY KEY,
    client_type varchar(7),
    client_name VARCHAR(150),
    date_of_birth date ,
    gender VARCHAR(15),
    phone_number VARCHAR not null CHECK(length(phone_number) >= 5 and length(phone_number) <= 15)
);
create table order_delivery(
    order_delivery_id SERIAL primary key,
    address varchar not null
);

create table delivery_status(
    delivery_status_id serial primary key,
    order_delivery_id integer references order_delivery(order_delivery_id),
    date_time date not null,
    status varchar(80)
);

create table payment(
    payment_id serial primary key,
    summ float8 not null CHECK(summ > 0),
    total_price float8 not null,
    payment_type varchar(50)
);
create table orders(
    order_id serial primary key,
    client_id integer references clients(client_id),
    delivery_number_id integer references order_delivery(order_delivery_id),
    payment_id integer references payment(payment_id),
    store_id integer references stores(store_id),
    date_time date not null,
    cash_air integer
);

create table brands(
    brand_id serial primary key,
    brand_name varchar(50)
);
create table vendors(
    vendor_id serial primary key,
    vendor_name varchar(50),
    address varchar(50) CHECK(length(address) >= 5 and length(address) <= 50),
    phone_number varchar(15)
);
create table vendor_delivery(
    vendor_delivery_id serial primary key,
    vendor_id integer references vendors(vendor_id),
    brand_id integer references brands(brand_id)
);

create table product_type(
    product_type_id serial primary key,
    product_type varchar(30),
    parent_id_ref integer
);

create table products(
    product_id serial primary key,
    product_type_id integer references product_type(product_type_id),
    upc_code varchar(20) unique,
    title text
);

create table order_items(
    order_items_id serial primary key,
    order_id integer references orders(order_id),
    product_id integer references products(product_id),
    count float8 not null default 1.0
);

create table store_inventory(
    store_inventory_id serial primary key ,
    store_id integer references stores(store_id),
    product_id integer references products(product_id),
    brand_id integer references brands(brand_id),
    price float8 not null CHECK( price > 0),
    quantity float8 CHECK(quantity >= 0)
);