WITH source AS (
    SELECT {{ dbt_utils.star(from=source('thelook','order_items')) }}
      FROM {{ source('thelook','order_items') }}
)
SELECT * FROM source

