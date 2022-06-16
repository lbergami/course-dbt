with order_items as (

    select order_id as order_guid, 
           product_id as product_guid, 
           quantity as product_quantity
    from {{ source('src_greenery', 'order_items')}}

)

select * from order_items