with orders as (

    select order_id as order_guid, 
           promo_id as promo_guid, 
           user_id as user_guid, 
           address_id as address_guid,
           created_at as order_at_utc,
           order_cost,
           shipping_cost,
           order_total,
           tracking_id as tracking_guid,
           shipping_service,
           estimated_delivery_at as order_estimated_at_utc,
           delivered_at as order_delivered_at_utc,
           status as order_status
    from {{ source('src_greenery', 'orders')}}

)

select * from orders