with events as (

    select event_id, 
           session_id,
           user_id, 
           event_type, 
           page_url,
           created_at, 
           order_id, 
           product_id 
    from {{ source('src_greenery', 'events')}}

)

select * from events