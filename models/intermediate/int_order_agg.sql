WITH int_order_agg AS (

  SELECT stg_thelook__order_items.order_id,
         stg_thelook__order_items.user_id,
         stg_thelook__order_items.status,
         COUNT(DISTINCT stg_thelook__order_items.id) AS items,
         SUM(stg_thelook__order_items.sale_price) AS bookings,
         ARRAY_AGG(stg_thelook__order_items.product_id) AS product_ids,
         ARRAY_AGG(stg_thelook__order_items.id) AS item_ids,
         ARRAY_AGG(stg_thelook__order_items.inventory_item_id) AS inventory_item_ids
    FROM {{ ref('stg_thelook__order_items') }}
GROUP BY stg_thelook__order_items.order_id,
         stg_thelook__order_items.user_id,
         stg_thelook__order_items.status
)

SELECT * FROM int_order_agg