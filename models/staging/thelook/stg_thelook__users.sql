WITH source AS (
    SELECT {{ dbt_utils.star(from=source('thelook','users')) }}
      FROM {{ source('thelook','users') }}
)
SELECT * FROM source