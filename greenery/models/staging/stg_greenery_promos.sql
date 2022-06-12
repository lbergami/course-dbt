with promos as (

    select promo_id,
           discount,
           status
    from {{ source('src_greenery', 'promos')}}

)

select * from promos