WITH source AS (
    SELECT {{ dbt_utils.star(from=source('thelook','orders')) }}
      FROM {{ source('thelook','orders') }}
)
SELECT * FROM source