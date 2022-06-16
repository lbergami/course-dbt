# Greenery dbt Project

## Week 1 Assignment 

Answer these questions using the data available using SQL queries. You should query the dbt generated (staging) tables you have just created. For these short answer questions/queries create a separate readme file in your repo with your answers.

1) **Q:** How many users do we have? **A:** 130

```SQL
select count(distinct user_guid) as n_users 
from dbt.dbt_lorenzo_b.stg_greenery_users;
```

2) **Q:** On average, how many orders do we receive per hour? **A:** 7.52

```SQL
with lkp_order_numbers as (

select date_trunc('hour', order_at_utc), 
       count(order_guid) as n_orders
from dbt.dbt_lorenzo_b.stg_greenery_orders
group by 1
)
select round(avg(n_orders), 2) as n_orders_per_hour
from lkp_order_numbers;
```

3) **Q:** On average, how long does an order take from being placed to being delivered?  **A:** 93.40 (hours)

```SQL
with lkp_delivered_orders as (

select order_guid,
       order_at_utc, 
       order_delivered_at_utc, 
       order_delivered_at_utc - order_at_utc as diff_day, 
       (extract(epoch from (order_delivered_at_utc - order_at_utc))) / 3600 as diff_hour
       
from dbt.dbt_lorenzo_b.stg_greenery_orders
where order_status = 'delivered'
)
select round(cast(avg(diff_hour) as numeric), 2) as average_waiting_time_hour
from lkp_delivered_orders;
```

4) **Q:** How many users have only made one purchase? Two purchases? Three+ purchases?

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.
**A:** One order: 25; two orders: 28; Three orders: 71;

 ```SQL
with lkp_user_orders as (
select user_guid,
       case
       when count(order_guid) = 1 then '1'
       when count(order_guid) = 2 then '2'
       when count(order_guid) > 2 then '3+'
       end as n_orders_per_customer
from dbt.dbt_lorenzo_b.stg_greenery_orders
group by user_guid
)
select n_orders_per_customer, 
       count(*) as count
from lkp_user_orders
group by n_orders_per_customer
order by n_orders_per_customer;
 ```

5) **Q:** On average, how many unique sessions do we have per hour? **A:** 16.33

```SQL
with lkp_unique_sessions as (

select 
  date_trunc('hour', event_at_utc), 
  count(distinct session_guid) as count_unique_session_id
from dbt.dbt_lorenzo_b.stg_greenery_events
group by 1

)

select round(avg(count_unique_session_id), 2) as avg_unique_sessions 
from lkp_unique_sessions
 ```


