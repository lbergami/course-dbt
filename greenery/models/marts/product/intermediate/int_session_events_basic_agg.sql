select session_guid, 
       event_at_utc,
       user_guid, 
       {{ get_aggregate_events() }} 
from {{ ref('stg_greenery_events') }}     
group by 1,2,3