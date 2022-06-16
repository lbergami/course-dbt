with products as (

    select product_id as product_guid,  
           name as product_name, 
           price as product_price,
           inventory as product_inventory
    from {{ source('src_greenery', 'products')}}

)

select * from products