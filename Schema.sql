create database Marketplace_System;
use Marketplace_System;

create table customer(
customer_id int primary key identity(1,1),
fullname varchar(60) not null,
email varchar(100) unique,
phone varchar(30),
created_at datetime default getdate()
);

create table seller(
seller_id int primary key identity(1,1),
seller_Name varchar(60) not null,
email varchar(100) unique,
rating float check(rating between 1 and 5),
created_at datetime default getdate()
);

create table category(
category_id int primary key identity(1,1),
category_Name varchar(30) not null
);

create table product(
product_id int primary key identity(1,1),
product_Name varchar(30) not null,
price decimal(10,2) check(price > 0),
stock_Quantity int check(stock_Quantity > 0),
seller_id int,
category_id int,
foreign key (seller_id) references seller(seller_id),
foreign key (category_id) references category(category_id)
);

create table orders(
order_id int primary key identity(1,1),
customer_id int,
order_date datetime default getdate(),
order_status varchar(30) check(order_status in ('paid','cancelled','pending')),
total_amount decimal(10,2) check (total_amount > 0),
foreign key (customer_id) references customer(customer_id)
);

create table orders_item(
order_id int not null,
product_id int not null,
Unit_Price decimal(10,2) check(Unit_Price > 0),
Quantity int check(Quantity > 0),
primary key (order_id,product_id),
foreign key (order_id) references orders(order_id),
foreign key (product_id) references product(product_id)
);

create table payment(
payment_id int primary key identity(1,1),
Order_ID int not null,
Payment_Method varchar(50),
Payment_Status varchar(30) check(Payment_Status in ('paid','cancelled','pending')),
Payment_Date datetime default getdate(),
Amount decimal(10,2) check(Amount > 0),
foreign key (order_id) references orders(order_id)
);

create table review(
Review_ID int primary key identity(1,1),
customer_id int not null,
product_id int not null,
Rating float check(rating between 1 and 5),
Review_Text varchar(100) not null,
Review_Date datetime default getdate(),
foreign key (customer_id) references customer(customer_id),
foreign key (product_id) references product(product_id)
);
