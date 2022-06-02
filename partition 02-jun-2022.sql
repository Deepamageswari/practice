select * from customer;
select * from country;
select count(cust_id) from customer group by country_id;
select cust_id,country_id,min(cust_id) over(partition by country_id) as c from customer;
select cust_id,country_id,min(cust_id) over(order by cust_id) as c from customer;
select r.country_id,r.cust_name,count(r.cust_id) from customer r inner join country c on c.country_id=r.country_id
group by (r.country_id,r.cust_name); 