WITH source AS (
    SELECT {{ dbt_utils.star(from=source('thelook','products')) }}
      FROM {{ source('thelook','products') }}
)
SELECT * FROM source