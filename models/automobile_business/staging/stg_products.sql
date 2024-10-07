{{
    config(
        materialized="table"
    )
}}

with source as (

    select * from {{ ref('raw_products') }}

),

renamed as (
    select 
        id,
        myear,
        price,
        model,
        make,
        CAST(created_at as timestamp) as created_at,
        CAST(updated_at as timestamp) as updated_at,
        _airbyte_extracted_at
        
    from source

)

select * from renamed