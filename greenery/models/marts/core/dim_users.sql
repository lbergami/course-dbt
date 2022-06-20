select u.user_guid, 
       u.first_name, 
       u.last_name,
       a.zipcode,
       a.state,
       a.country 
from {{ ref('stg_greenery_users') }} as u 
left join {{ ref('stg_greenery_addresses') }} as a
on   u.address_guid = a.address_guid   

