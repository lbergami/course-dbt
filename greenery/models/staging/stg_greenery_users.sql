with users as (

    select user_id as user_guid, 
           first_name, 
           last_name,
           email, 
           phone_number,
           created_at as user_created_at_utc,
           updated_at as user_updated_at_utc,
           address_id as address_guid
    from {{ source('src_greenery', 'users')}}

)

select * from users
