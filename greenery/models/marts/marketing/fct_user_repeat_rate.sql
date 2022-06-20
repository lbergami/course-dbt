with order_cohort as (
select  
  user_guid, 
  count(distinct order_guid) as user_orders
from {{ ref('stg_greenery_orders') }}
group by 1
), 
users_bucker as (
select user_guid, 
  (user_orders = 1)::int as has_one_purchses,
  (user_orders >= 2)::int as has_two_purchses
from order_cohort
)
select 
  sum(has_two_purchses)::float / count(distinct user_guid) as repeat_rate 
from users_bucker