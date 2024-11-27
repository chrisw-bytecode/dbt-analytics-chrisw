WITH int_inventory_agg AS (

    SELECT product_id,
           product_category,
           product_department,
           product_sku
           product_name,
           product_brand,
           product_retail_price,
           cost,
           COUNT(CASE WHEN sold_at IS NULL THEN id END) AS units_in_inventory,
           COUNT(CASE WHEN sold_at IS NOT NULL THEN id END) AS units_sold,
      FROM {{ ref('stg_thelook__inventory_items') }}
      GROUP BY ALL
      ORDER BY 1
)

SELECT * FROM int_inventory_agg