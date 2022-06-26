with lkp_events as ( 
select session_guid, 
       event_at_utc,
       user_guid, 
       product_guid, 
       {{ get_aggregate_events() }} 
from {{ ref('stg_greenery_events') }}     
group by 1,2,3,4
), 
    lkp_products as (
select product_guid,  
       product_name
from {{ ref('stg_greenery_products') }}   
)
select le.session_guid, 
       le.event_at_utc,
       le.user_guid, 
       le.product_guid,
       lp.product_name,  
       le.package_shipped, 
       le.page_view,
       le.checkout,
       le.add_to_cart
from lkp_events as le       
left join lkp_products as lp
on le.product_guid = lp.product_guid 
