

with session_length as (
select 
    session_guid, 
    min(event_at_utc) as first_event, 
    max(event_at_utc) as last_event
from {{ ref('stg_greenery_events') }}     
group by 1
)

select 
    init_session_events_basic_agg.session_guid,
    init_session_events_basic_agg.user_guid, 
    stg_greenery_users.first_name,
    stg_greenery_users.last_name,
    stg_greenery_users.email,
    init_session_events_basic_agg.package_shipped,
    init_session_events_basic_agg.page_view,
    init_session_events_basic_agg.checkout,
    init_session_events_basic_agg.add_to_cart, 
    session_length.first_event as first_session_event, 
    session_length.last_event as last_session_event,
    date_part('hour', session_length.last_event::timestamp - session_length.first_event::timestamp) as hours_diff
from {{ ref('init_session_events_basic_agg') }}
left join {{ ref('stg_greenery_users') }}
    on init_session_events_basic_agg.user_guid = stg_greenery_users.user_guid
left join session_length
    on init_session_events_basic_agg.session_guid = session_length.session_guid



