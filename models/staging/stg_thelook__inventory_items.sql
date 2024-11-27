WITH source AS (
    SELECT {{ dbt_utils.star(from=source('thelook','inventory_items')) }}
      FROM {{ source('thelook','inventory_items') }}
)
SELECT * FROM source