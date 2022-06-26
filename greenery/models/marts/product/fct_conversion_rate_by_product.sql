-- number of session by product
with lkp_n_sessions as (
select 
    product_guid,
    product_name,
    count(distinct session_guid) as n_sessions
from {{ ref('int_product_session_events_basic_agg') }}
where product_guid is not null
group by 1, 2
), 
    lkp_n_purchase as (
select 
    product_guid, 
    product_name,
    sum(add_to_cart) as n_purchase_event
from {{ ref('int_product_session_events_basic_agg') }}
where product_guid is not null and 
      session_guid in (select distinct session_guid
                       from {{ ref('int_product_session_events_basic_agg') }}
                       where checkout = 1)
group by 1, 2
)
select 
    lns.product_guid,
    lns.product_name,
    lns.n_sessions, 
    lnp.n_purchase_event, 
    round(lnp.n_purchase_event / lns.n_sessions, 2) as conversion_ratio
from lkp_n_sessions as lns
left join  lkp_n_purchase as lnp
on lns.product_guid = lnp.product_guid
order by conversion_ratio desc
