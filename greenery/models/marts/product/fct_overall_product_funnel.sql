-- Create initial table indicator of each event by session 
    with lkp_event_indicator as (
select 
    session_guid,
    case when sum(page_view) > 0 then 1 else 0 end as flag_page_view, 
    case when sum(add_to_cart) > 0 then 1 else 0 end as flag_add_to_cart, 
    case when sum(checkout) > 0 then 1 else 0 end as flag_checkout
from dbt_lorenzo_b.int_session_events_basic_agg
group by 1
order by session_guid
),
-- Create initial table indicator of each event by session  
    lkp_collapsed as ( 
select 
  sum(flag_page_view) as n_page_view, 
  sum(flag_add_to_cart) as n_add_to_cart, 
  sum(flag_checkout) as n_checkout
from lkp_event_indicator
) 
select 
    n_page_view, 
    n_add_to_cart, 
    round(n_add_to_cart::numeric / n_page_view::numeric, 2) as share_page_view_to_add_to_cart,
    n_checkout,
    round(n_checkout::numeric / n_add_to_cart::numeric, 2) as share_add_to_cart_to_checkout
from lkp_collapsed



