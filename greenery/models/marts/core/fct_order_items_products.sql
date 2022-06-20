
select oi.order_guid, 
       oi.product_guid, 
       p.product_name, 
       p.product_price,
       oi.product_quantity, 
       p.product_price * oi.product_quantity as user_prod_expenditure,
       p.product_inventory, 
       geo.state
from {{ ref('stg_greenery_order_items') }} as oi 
left join {{ ref('stg_greenery_products') }} as p
on oi.product_guid = p.product_guid
left join {{ ref('dim_order_user_geo') }} as geo
on oi.order_guid = geo.order_guid
order by oi.order_guid

