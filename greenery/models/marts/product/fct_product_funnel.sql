
-- CTE with number of sessions with 'page view' by product id / product name 
with lkp_n_page_views as (
select 
    product_guid, 
    product_name,
    sum(page_view) as n_page_views
from {{ ref('int_product_session_events_basic_agg') }}
where product_guid is not null 
group by 1, 2
),
-- CTE with number of sessions with 'add to cart' by product id / product name 
    lkp_n_add_to_cart as (
select 
    product_guid, 
    product_name,
    sum(add_to_cart) as n_add_to_cart
from {{ ref('int_product_session_events_basic_agg') }}
where product_guid is not null 
group by 1, 2
),
-- CTE with number of sessions with 'add to cart' ending in 'checkout' by product id / product name
    lkp_n_checkouts as (
select 
    product_guid, 
    product_name,
    sum(add_to_cart) as n_checkouts
from {{ ref('int_product_session_events_basic_agg') }}
where product_guid is not null and 
      session_guid in (select distinct session_guid
                       from {{ ref('int_product_session_events_basic_agg') }}
                       where checkout = 1)
group by 1, 2
)
select 
    lnpg.product_guid,
    lnpg.product_name,
-- Page views  
    lnpg.n_page_views,
-- Add to cart 
    lnatc.n_add_to_cart, 
    round(lnatc.n_add_to_cart / lnpg.n_page_views, 2) as page_view_to_add_to_cart,
-- Checkouts     
    lnc.n_checkouts, 
    round(lnc.n_checkouts / lnatc.n_add_to_cart, 2) as add_to_cart_to_checkout

from lkp_n_page_views as lnpg
-- Join lkp_n_add_to_cart
left join  lkp_n_add_to_cart as lnatc
on lnpg.product_guid  = lnatc.product_guid
-- Join lkp_n_checkouts
left join  lkp_n_checkouts as lnc
on lnpg.product_guid = lnc.product_guid
order by add_to_cart_to_checkout desc
