with order_items as (

    select order_id, 
           product_id, 
           quantity
    from {{ source('src_greenery', 'order_items')}}

)

select * from order_items