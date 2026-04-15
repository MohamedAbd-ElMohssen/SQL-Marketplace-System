select count(*) from customer;
select count(*) from seller;
select count(*) from category;
select count(*) from product;
select count(*) from orders;
select count(*) from orders_item;
select count(*) from payment;
select count(*) from review;

---------LEVEL 1 — Data Exploration----------
---Task 1---
select *
from customer
order by created_at asc;
---Task 2---
select p.*,c.category_Name
from product p
inner join category c
on c.category_id=p.category_id;
---Task 3---
select o.*,c.fullname
from orders o
inner join customer c
on c.customer_id=o.customer_id;
---------LEVEL 2 — Filtering & Business Logic----------
---Task 4---
select *
from orders
where order_status='paid';
---Task 5---
select c.customer_id,c.fullname,o.order_id,o.order_status
from customer c
left join orders o
on c.customer_id=o.customer_id
where order_id is null;
---Task 6---
select o.order_id
from orders o
left join payment p
on o.order_id=p.Order_ID
where p.payment_id is null;
---------LEVEL 3 — Aggregation & Metrics----------
---Task 7---
select c.customer_id,COUNT(o.order_id) As total_orders
from customer c
left join orders o
on c.customer_id=o.customer_id
group by c.customer_id;
---Task 8---
select c.customer_id,sum(p.Amount) As total_spent
from customer c
inner join orders o on c.customer_id=o.customer_id
inner join payment p on o.order_id=p.Order_ID
where p.Payment_Status='paid'
group by c.customer_id
order by total_spent desc;
---Task 9---
select c.category_id,AVG(p.price) As avg_price
from category c
inner join product p
on c.category_id=p.category_id
group by c.category_id
order by avg_price desc;
---------LEVEL 4 — Order & Product Analysis----------
---Task 10---
select top 5 o.product_id,sum(o.Quantity) As total_quantity_sold
from orders_item o
inner join payment p
on o.order_id=p.Order_ID
where p.Payment_Status='paid'
group by o.product_id
order by total_quantity_sold desc;
---Task 11---
with seller_products As(
select s.seller_id,s.seller_Name,p.product_id,p.product_Name
from seller s
inner join product p
on s.seller_id=p.seller_id
),
paid_orders As (
select o.order_id
from orders o
inner join payment p
on o.order_id=p.Order_ID
where p.Payment_Status='paid'
),
total_amount As (
select oi.order_id,oi.product_id,(Unit_Price * Quantity) As total_money
from paid_orders po
inner join orders_item oi
on oi.order_id=po.order_id
)
select sp.seller_id,sp.seller_Name,sum(ta.total_money) As total_revenue
from seller_products sp
inner join total_amount ta
on sp.product_id=ta.product_id
group by sp.seller_id,sp.seller_Name
order by total_revenue desc;
---Task 12---
select o.order_id,count(oi.product_id) As number_of_products
from orders o
inner join orders_item oi
on o.order_id=oi.order_id
group by o.order_id
having count(oi.product_id) > 1;
---------LEVEL 5 — Subqueries & EXISTS----------
---Task 13---
select t.customer_id, t.total_spent
from (select o.customer_id,sum(p.Amount) as total_spent
from orders o
inner join payment p
on o.order_id=p.Order_ID
where p.Payment_Status='paid'
group by o.customer_id) t
where t.total_spent > (select avg(customer_total)
from (select o.customer_id,
               sum(p.amount) as customer_total
        from orders o
        inner join payment p
            on o.order_id = p.order_id
        where p.payment_status = 'paid'
        group by o.customer_id) x
		)
order by t.total_spent desc;
---Task 14---
select product_id,product_Name
from product p
where not exists(
select 1
from review r
where p.product_id=r.product_id
);
---------LEVEL 6 — Window Functions----------
---Task 15---
with paid_orders As(
select o.customer_id,sum(p.Amount) As total_spent
from orders o
inner join payment p
on o.order_id=p.Order_ID
where p.Payment_Status='paid'
group by customer_id)
select customer_id,total_spent,
DENSE_RANK() over(order by total_spent desc) As rank
from paid_orders;
---Task 16---
with paid_orders As(
select o.order_date,sum(p.Amount) As daily_revenue
from orders o
inner join payment p
on o.order_id=p.Order_ID
where p.Payment_Status='paid'
group by order_date)
select order_date,daily_revenue,
SUM(daily_revenue) OVER(ORDER BY order_date) As running_total
from paid_orders;
---------LEVEL 7 — Data Quality & Validation----------
---Task 17---
with paid_orders As(
select o.customer_id,YEAR(order_date) As year_time,MONTH(order_date) As month_time,sum(p.Amount) As total_spent
from orders o
inner join payment p
on o.order_id=p.Order_ID
where p.Payment_Status='paid'
group by customer_id, year(o.order_date),month(o.order_date))
select year_time,month_time,customer_id,total_spent,
rank() over(partition by year_time, month_time order by total_spent desc) As ranking
from paid_orders
order by year_time, month_time, ranking;
---Task 18---
with paid_orders As(
select o.order_id
from orders o
inner join payment p
on o.order_id=p.Order_ID
where p.Payment_Status='paid'),
product_quantity As(
select oi.product_id,sum(oi.Quantity) As total_quantity
from paid_orders po
inner join orders_item oi
on oi.order_id=po.order_id
group by oi.product_id
)
select c.category_Name,p.product_Name,total_quantity,
rank() over(partition by c.category_name order by total_quantity desc) As ranking
from product_quantity pq
inner join product p on p.product_id=pq.product_id
inner join category c on c.category_id=p.category_id;
---------LEVEL 8 — Data Quality----------
---Task 19---
select o.order_id,sum(oi.Unit_Price * oi.Quantity) As  expected_total,o.total_amount As stored_total
from orders o
inner join orders_item oi
on o.order_id=oi.order_id
group by o.order_id
having o.total_amount != sum(oi.Unit_Price * oi.Quantity);
---Task 20---
select p.payment_id,p.Amount,o.total_amount
from payment p
inner join orders o
on o.order_id=p.Order_ID
where p.Amount > o.total_amount;
---------LEVEL 9 — Real Data Engineer Thinking----------
---Task 21---
with paid_orders As(
select o.customer_id,o.order_id
from orders o
inner join payment p
on o.order_id=p.Order_ID
where p.Payment_Status='paid'
)
select po.customer_id
from paid_orders po
left join review r
on po.customer_id=r.customer_id
where r.Review_ID is null;
--
with paid_orders As(
select o.customer_id,o.order_id
from orders o
inner join payment p
on o.order_id=p.Order_ID
where p.Payment_Status='paid'
)
select po.customer_id
from paid_orders po
where not exists (
select 1
from review r
where po.customer_id=r.customer_id
)
---Task 22---
with product_sales as (
    select
        oi.product_id, sum(oi.quantity) as total_quantity_sold
    from orders o
    inner join payment p on o.order_id = p.order_id
    inner join orders_item oi on oi.order_id = o.order_id
    where p.payment_status = 'paid'
    group by oi.product_id
),
product_avg_rating as (
    select r.product_id,avg(r.rating) as avg_rating
    from review r
    group by r.product_id
)
select ps.product_id,par.avg_rating,ps.total_quantity_sold
from product_sales ps
inner join product_avg_rating par
    on ps.product_id = par.product_id
where par.avg_rating < (
    select avg(rating) from review
)
order by ps.total_quantity_sold desc;
