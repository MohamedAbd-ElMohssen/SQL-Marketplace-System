insert into customer (fullname, email, phone)
values
('Ahmed Ali', 'ahmed@gmail.com', '01011111111'),
('Sara Mohamed', 'sara@gmail.com', '01022222222'),
('Omar Hassan', 'omar@gmail.com', '01033333333'),
('Mona Adel', 'mona@gmail.com', '01044444444'),
('Youssef Kamal', 'youssef@gmail.com', '01055555555'),
('Hassan Mahmoud', 'hassan@gmail.com', '01066666666'),
('Nour Adel', 'nour@gmail.com', '01077777777'),
('Mahmoud Salah', 'mahmoud@gmail.com', '01088888888'),
('Dina Fathy', 'dina@gmail.com', '01099999999'),
('Karim Nabil', 'karim@gmail.com', '01100000000');

insert into seller (seller_name, email, rating)
values
('Tech Store', 'tech@store.com', 4.5),
('Fashion Hub', 'fashion@hub.com', 4.2),
('Book World', 'books@world.com', 4.8),
('Mobile Zone', 'mobile@zone.com', 4.3),
('Home Supplies', 'home@supplies.com', 4.0);

insert into category (category_name)
values
('Electronics'),
('Clothing'),
('Books'),
('Home Appliances'),
('Accessories');

insert into product (product_name, price, stock_quantity, seller_id, category_id)
values
('Laptop', 25000.00, 10, 1, 1),
('Headphones', 1500.00, 25, 1, 1),
('T-Shirt', 300.00, 50, 2, 2),
('Jeans', 800.00, 30, 2, 2),
('SQL Book', 500.00, 20, 3, 3),
('Smartphone', 12000.00, 15, 4, 1),
('Washing Machine', 18000.00, 5, 5, 4),
('Blender', 2500.00, 10, 5, 4),
('Phone Case', 150.00, 100, 4, 5),
('Keyboard', 700.00, 40, 1, 5),
('Mouse', 400.00, 60, 1, 5);

insert into orders (customer_id, order_status, total_amount)
values
(1, 'paid', 26500.00),
(2, 'paid', 1100.00),
(3, 'pending', 800.00),
(1, 'cancelled', 300.00),
(4, 'paid', 12000.00),
(5, 'paid', 2500.00),
(6, 'pending', 18000.00),
(7, 'paid', 150.00),
(8, 'paid', 700.00),
(9, 'cancelled', 400.00),
(10, 'paid', 1550.00);

insert into orders_item (order_id, product_id, unit_price, quantity)
values
(1, 1, 25000.00, 1),
(1, 2, 1500.00, 1),
(2, 5, 500.00, 2),
(3, 4, 800.00, 1),
(4, 3, 300.00, 1),
(5, 6, 12000.00, 1),
(6, 8, 2500.00, 1),
(7, 7, 18000.00, 1),
(8, 9, 150.00, 1),
(9, 10, 700.00, 1),
(10, 11, 400.00, 1),
(11, 2, 1500.00, 1),
(11, 9, 150.00, 1);

insert into payment (order_id, payment_method, payment_status, amount)
values
(1, 'Credit Card', 'paid', 26500.00),
(2, 'Cash', 'paid', 1100.00),
(3, 'Credit Card', 'pending', 800.00),
(5, 'Credit Card', 'paid', 12000.00),
(6, 'Cash', 'paid', 2500.00),
(8, 'Credit Card', 'paid', 150.00),
(9, 'Credit Card', 'paid', 700.00),
(11, 'Cash', 'paid', 1550.00);

insert into review (customer_id, product_id, rating, review_text)
values
(1, 1, 5, 'Excellent laptop'),
(2, 5, 4, 'Very useful book'),
(3, 4, 3, 'Good quality jeans'),
(1, 2, 4, 'Nice sound quality'),
(4, 6, 5, 'Amazing smartphone'),
(5, 8, 4, 'Very useful appliance'),
(6, 7, 5, 'Excellent washing machine'),
(7, 9, 4, 'Good quality case'),
(8, 10, 4, 'Comfortable keyboard'),
(9, 11, 3, 'Average mouse');
