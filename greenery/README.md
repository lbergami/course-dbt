# Greenery dbt Project

## Week 1 Assignment 

Answer these questions using the data available using SQL queries. You should query the dbt generated (staging) tables you have just created. For these short answer questions/queries create a separate readme file in your repo with your answers.

1) Q: How many users do we have? A: 130

```SQL
select count(distinct user_id) from dbt.dbt_lorenzo_b.stg_greenery_users;
```

2) Q: On average, how many orders do we receive per hour? A: 7.52

```SQL
with lkp_order_numbers as (

select date(created_at) as order_date,
       extract(hour from created_at) as order_hour_day, 
       count(order_id) as n_orders
from dbt.dbt_lorenzo_b.stg_greenery_orders
group by date(created_at), extract(hour from created_at)
)

select round(avg(n_orders), 2)
from lkp_order_numbers;
```

3) On average, how long does an order take from being placed to being delivered?

4) How many users have only made one purchase? Two purchases? Three+ purchases?

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

5) On average, how many unique sessions do we have per hour?





Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
