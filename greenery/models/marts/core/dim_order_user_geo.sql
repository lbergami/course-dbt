select du.user_guid,
       du.zipcode,
       du.state, 
       du.country,
       o.order_guid
from {{ ref('dim_users') }} as du 
left join {{ ref('stg_greenery_orders') }} as o
on du.user_guid = o.user_guid
