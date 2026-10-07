--1.what is the total amount each customer spent at the restaurant?
with cte as(
select customer_id,price from menu m 
join sales s on m.product_id=s.product_id)
select customer_id,sum(price) from cte
group by customer_id;
--2.how many days has each customer visited the restaurant?
with cte as(
select distinct customer_id,order_date from sales)
select customer_id,count(order_date) how_many_days from cte
group by customer_id;
--3.what was the first item from the menu purchased by each customer?
with cte2 as(
with cte as(
select customer_id,product_name,order_date from sales s
join menu m on s.product_id=m.product_id)
select customer_id,rank() over(partition by customer_id order by order_date),product_name from cte)
select customer_id,product_name from cte2
where rank = 1
--4.what is the most purchased item on the menu and how many times was it purchased by all customers?
with cte as(
select customer_id,product_name from sales s
join menu m on s.product_id=m.product_id)
select product_name,count(product_name) from cte
group by product_name
order by count desc
limit 1
--5.which item was the most popular for each customer?
with cte3 as(
with cte2 as(
with cte as(
select customer_id,product_name from sales s
join menu m on s.product_id=m.product_id)
select customer_id,product_name,count(product_name) from cte
group by customer_id,product_name)
select customer_id,product_name,rank() over(partition by customer_id order by count desc) from cte2)
select customer_id,product_name from cte3
where rank=1
--6.which item was purchased first by the customer after they became a member?
with cte2 as(
with cte as(
select m.customer_id,join_date,order_date,s.product_id,product_name,price from members m
join sales s on m.customer_id=s.customer_id
join menu me on s.product_id=me.product_id)
select *,rank() over(partition by customer_id order by order_date ) from cte
where order_date>=join_date)
select * from cte2 
where rank = 1
--7.which item was purchased just before the customer became a member?
with cte2 as(
with cte as(
select m.customer_id,join_date,order_date,s.product_id,product_name,price from members m
join sales s on m.customer_id=s.customer_id
join menu me on s.product_id=me.product_id)
select *,rank() over(partition by customer_id order by order_date desc ) from cte
where order_date<join_date)
select * from cte2 
where rank = 1
--8.what is the total items and amount spent for each member before they became a member?
select m.customer_id,count(product_name),sum(price) from members m
join sales s on m.customer_id=s.customer_id
join menu me on s.product_id=me.product_id
where order_date<join_date
group by m.customer_id
--9.if each $1 spent equates to 10 points and sushi has a 2x points multiplier-how many points would each 
--customer have?
with cte as(
select customer_id,product_name,price,case
when product_name = 'sushi' then price* 20
else price * 10
end points
from sales s
join menu m on s.product_id=m.product_id)
select customer_id,sum(points) from cte
group by customer_id
order by sum desc
--10.in the first week after a customer joins the program(including their join date) they earn 2x points on
--all items not just sushi-how many points do customers have at the end of january?
with cte as(
select m.customer_id,join_date,order_date,s.product_id,product_name,price,case
when order_date between join_date and join_date+6 then price*20
else case
when product_name ='sushi' then price *20
else price*10
end
end points
from members m
join sales s on m.customer_id=s.customer_id
join menu me on s.product_id=me.product_id
where order_date < '2021-02-01')
select customer_id,sum(points) from cte
group by customer_id
--bonus questions 1.join all the things
select s.customer_id,order_date,product_name,price,case
when order_date>=join_date then 'Y'
else 'N'
end member
from sales s
join menu me on s.product_id=me.product_id
left join members m on s.customer_id=m.customer_id
--bonus questions 2.rank all the things
with cte as(
select s.customer_id,order_date,product_name,price,case
when order_date>=join_date then 'Y'
else 'N'
end member
from sales s
join menu me on s.product_id=me.product_id
left join members m on s.customer_id=m.customer_id)
select *,case 
when member='Y' then rank() over(partition by customer_id,member order by order_date) 
else null
end ranking
from cte

















