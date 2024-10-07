{{
    config(
        materialized="table"
    )
}}
with source as (

    select * from {{ ref('raw_purchases') }}

),

renamed as (

    select
        id,
        user_id,
        product_id,

        CASE 
            when purchased_at IS Null or purchased_at = 'None' then Null
            else CAST(purchased_at AS timestamp)
        END as purchased_at,

        CASE 
            when returned_at IS Null or returned_at = 'None' then Null
            else CAST(returned_at AS timestamp)
        END as cancelled_at,

        CAST (created_at  AS timestamp) as created_at,
         CAST (updated_at  AS timestamp) as updated_at,
        CAST(added_to_cart_at as timestamp) as booked_at,
        _airbyte_extracted_at

    from source

)

select * from renamed
