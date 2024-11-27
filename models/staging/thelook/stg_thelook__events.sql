WITH source AS (
    SELECT {{ dbt_utils.star(from=source('thelook','distribution_centers')) }}
      FROM {{ source('thelook','distribution_centers') }}
)
SELECT * FROM source