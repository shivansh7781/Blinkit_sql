Select * From customers;
Select * from Orders;
Select * from Order_details;

#Retrieve All Orders Along with Customer Information

SELECT 
    c.customerid, 
    c.name AS customer_name, 
    c.city, 
    o.orderid, 
    o.orderdatetime, 
    o.deliverydatetime, 
    o.totalamount, 
    o.deliverystatus
FROM 
    customers c
JOIN 
    orders o
ON 
    c.customerid = o.customerid;


#Calculate Total Order Value for Each Customer

SELECT 
    c.customerid, 
    c.name AS customer_name, 
    SUM(o.totalamount) AS total_spent
FROM 
    customers c
JOIN 
    orders o
ON 
    c.customerid = o.customerid
GROUP BY 
    c.customerid, c.name
ORDER BY 
    total_spent DESC;


#List All Products in Each Order

SELECT 
    o.orderid, 
    od.productname, 
    od.quantity, 
    od.priceperunit, 
    (od.quantity * od.priceperunit) AS total_price
FROM 
    orders o
JOIN 
    order_details od
ON 
    o.orderid = od.orderid
ORDER BY 
    o.orderid;


#Find the Top 5 Customers by Total Spending

SELECT 
    c.customerid, 
    c.name AS customer_name, 
    SUM(o.totalamount) AS total_spent
FROM 
    customers c
JOIN 
    orders o
ON 
    c.customerid = o.customerid
GROUP BY 
    c.customerid, c.name
ORDER BY 
    total_spent DESC
LIMIT 5;


# Check Orders with Late Delivery

SELECT 
    o.orderid, 
    c.name AS customer_name, 
    o.orderdatetime, 
    o.deliverydatetime, 
    EXTRACT(EPOCH FROM (o.deliverydatetime - o.orderdatetime))/3600 AS delivery_time_in_hours
FROM 
    orders o
JOIN 
    customers c
ON 
    o.customerid = c.customerid
WHERE 
    o.deliverydatetime > o.orderdatetime
ORDER BY 
    delivery_time_in_hours DESC;


#Get Order Details for a Specific Customer

SELECT 
    c.name AS customer_name, 
    o.orderid, 
    o.orderdatetime, 
    od.productname, 
    od.quantity, 
    od.priceperunit, 
    (od.quantity * od.priceperunit) AS total_price
FROM 
    customers c
JOIN 
    orders o
ON 
    c.customerid = o.customerid
JOIN 
    order_details od
ON 
    o.orderid = od.orderid
WHERE 
    c.name = 'Pooja Pandey';

#Monthly Sales Report

   SELECT 
    TO_CHAR(o.orderdatetime, '2024-11') AS sales_month,  
    SUM(o.totalamount) AS total_sales
FROM 
    orders o
GROUP BY 
    TO_CHAR(o.orderdatetime, '2024-11')  
ORDER BY 
    sales_month;

#Total Number of Products Sold by Category

SELECT 
    od.productname, 
    SUM(od.quantity) AS total_units_sold
FROM 
    order_details od
GROUP BY 
    od.productname
ORDER BY 
    total_units_sold DESC;


# Order Status Count
SELECT 
    o.deliverystatus, 
    COUNT(o.orderid) AS status_count
FROM 
    orders o
GROUP BY 
    o.deliverystatus
ORDER BY 
    status_count DESC;


#Customer Order History
SELECT 
    c.name AS customer_name, 
    o.orderid, 
    o.orderdatetime, 
    o.deliverydatetime, 
    o.totalamount, 
    o.deliverystatus, 
    od.productname, 
    od.quantity, 
    od.priceperunit
FROM 
    customers c
JOIN 
    orders o
ON 
    c.customerid = o.customerid
JOIN 
    order_details od
ON 
    o.orderid = od.orderid
WHERE 
    c.customerid = 77;


