with promos as (

    select promo_id as promo_guid,
           discount as promo_discount,
           status as promo_status
    from {{ source('src_greenery', 'promos')}}

)

select * from promos