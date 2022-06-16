with addresses as (

    select address_id as address_guid, 
           address,
           zipcode,
           state,
           country 
    from {{ source('src_greenery', 'addresses')}}

)

select * from addresses