with addresses as (

    select address_id, 
           address,
           zipcode,
           state,
           country 
    from {{ source('src_greenery', 'addresses')}}

)

select * from addresses