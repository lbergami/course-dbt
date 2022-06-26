select 
    count(distinct session_guid) as n_sessions,
    sum(checkout) as n_purchase_event, 
    round(sum(checkout) / count(distinct session_guid), 2) as overall_conversion_rate
from {{ ref('int_session_events_basic_agg') }}