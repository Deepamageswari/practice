create table product_day5
(prod_bkey varchar2(5),
prod_name varchar2(20),
price number(10),
family varchar2(20));
insert all
into product_day5 values('p1','laptop',30000,'electronics')
into product_day5 values('p2','headphone',3000,'electronics')
into product_day5 values('p3','earphone',100,'electronics')
into product_day5 values('p4','chocolates',100,'food')
into product_day5 values('p5','biscuits',50,'food')
into product_day5 values('p6','chips',80,'food')
select * from dual;
create table customer_day5
(cust_bkey varchar2(5),
cust_name varchar2(20),
dob date,
phone number(10),
address varchar2(20),
city varchar2(20),
zip number(10),
state varchar2(20));
insert all
into customer_day5 values('c1','jagan','12-jan-2000',9000010000,'128,anna nagar','chennai',600028,'TamilNadu')
into customer_day5 values('c2','mohan','15-feb-2000',9000020000,'139,anna nagar','chennai',600028,'TamilNadu')
into customer_day5 values('c3','harith','22-mar-2002',9000030000,'148,t nagar','chennai',600028,'TamilNadu')
into customer_day5 values('c4','kiran','12-may-2010',9000040000,'128,anna nagar','chennai',600028,'TamilNadu')
into customer_day5 values('c5','mohan','15-jan-2000',9000050000,'shivaji nagar','bangalore',560028,'Karnataka')
into customer_day5 values('c6','hemanth','10-sep-1990',9000060000,'shanti nagar','bangalore',560068,'karnataka')
into customer_day5 values('c7','salim','12-jun-2000',9000070000,'jayanagar','bangalore',560041,'karnataka')
select * from dual;
create table sales_day5
(sales_id varchar2(5),
cust_bkey varchar2(5),
prod_bkey varchar2(5),
store_bkey varchar2(5),
qty number(10),
sales_amount number(10),sales_date date);
insert all
into sales_day5 values('s1','c1','p1','st1',2,60000,'01-jan-2012')
into sales_day5 values('s2','c2','p3','st1',1,100,'01-mar-2012')
into sales_day5 values('s3','c1','p4','st1',10,1000,'01-jan-2012')
into sales_day5 values('s4','c3','p5','st2',5,250,'01-may-2002')
into sales_day5 values('s5','c4','p2','st1',2,6000,'23-jan-2003')
into sales_day5 values('s6','c4','p4','st2',4,400,'01-jan-2012')
into sales_day5 values('s7','c5','p1','st2',3,90000,'01-jan-2012')
into sales_day5 values('s8','c6','p6','st1',2,160,'01-jun-2012')
select * from dual;
create table stores_day5
(store_bkey varchar2(5),
store_name varchar2(20),
address varchar2(20),
phone number(10),
city varchar2(20),
zip number(10),
state varchar2(20)
);
insert all
into stores_day5 values('st1','mshalakshmi traders','anna nagar',8000010000,'chennai',600028,'TamilNadu')
into stores_day5 values('st2','brindha traders','bala nagar',8000020000,'chennai',600028,'TamilNadu')
into stores_day5 values('st3','akshay traders','jaya nagar',8000030000,'bangalore',560028,'karnataka')
into stores_day5 values('st4','anil traders','mgr nagar',8000040000,'chennai',600028,'TamilNadu')
into stores_day5 values('st5','sunil traders','jaya nagar',8000050000,'bangalore',560028,'karnataka')
into stores_day5 values('st6','mukesh traders','shivaji nagar',8000060000,'bangalore',560028,'TamilNadu')
into stores_day5 values('st7','punith traders','shanti nagar',8000070000,'bangalore',560038,'karnataka')
into stores_day5 values('st8','geetha traders','t nagar',8000080000,'chennai',600028,'TamilNadu')
into stores_day5 values('st9','uma traders','anna nagar',8000090000,'chennai',600028,'TamilNadu')
select * from dual;
select * from product_day5;
select * from customer_day5;
select * from sales_day5;
select * from stores_day5;
--1.	Get the customer names who made sales on or before 1st may 2002.
select c.cust_name,s.sales_date from customer_day5 c
inner join sales_day5 s on s.cust_bkey=c.cust_bkey
where s.sales_date<='01-may-2002';
--2. 2.	Get the customer names who made sales yesterday and today.
insert into sales_day5 values('s10','c4','p1','st2',1,3000,'20-may-2022');
select cust_name,sales_date from customer_day5 c
inner join sales_day5 s on s.cust_bkey=c.cust_bkey
where s.sales_date >=('19-MAY-22');
--in ('19-MAY-22','20-MAY-22');
insert into sales_day5 values('s10','c4','p1','st2',1,3000,'20-may-2022');
select cust_name,sales_date from customer_day5 c
inner join sales_day5 s on s.cust_bkey=c.cust_bkey
where s.sales_date >=(sysdate-1);
select sysdate-1 from dual;
--3.	Get the customer names who made max total sale (qty*price) on 1st jan 2014.
select c.cust_bkey from sales_day5 s
--inner join product_day5 p on p.prod_bkey=s.prod_bkey
inner join customer_day5 c on c.cust_bkey=s.cust_bkey
group by c.cust_bkey;
--delete from stores_day5 where rowid not in (select max(rowid) from stores_day5 group by store_bkey);
--24-05-2022
UPDATE sales_day5 set sales_day5.sa_amount =(select p.price from product_day5 p where sales_day5.prod_bkey = p.prod_bkey);

--alter table sales_day5 drop column s_amount;
select * from sales_day5;
select prod_bkey, sum(qty*sa_amount) from sales_day5 group by prod_bkey;
select cust_name from customer_day5 where cust_bkey =(select cust_bkey from sales_day5 
where(qty*sa_amount)=(select max(qty*sa_amount) from sales_day5 where sales_date='01-jan-12'));

select * from customer_day5;
commit;


