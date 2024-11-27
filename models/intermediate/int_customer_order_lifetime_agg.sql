WITH int_customer_order_lifetime_agg AS (

    SELECT stg_thelook__users.id AS user_id,
           COUNT(DISTINCT stg_thelook__orders.order_id) AS orders,
           COUNT(DISTINCT stg_thelook__order_items.id) AS items,
           SUM(stg_thelook__order_items.sale_price) AS revenue,
           MIN(stg_thelook__orders.created_at) AS first_order_date,
           MAX(stg_thelook__orders.created_at) AS most_recent_order_date,
           ARRAY_AGG(stg_thelook__order_items.product_id IGNORE NULLS) AS products
      FROM {{ ref('stg_thelook__users') }}
 LEFT JOIN {{ ref('stg_thelook__orders') }}
        ON stg_thelook__users.id = stg_thelook__orders.user_id
 LEFT JOIN {{ ref('stg_thelook__order_items') }}
        ON stg_thelook__orders.order_id = stg_thelook__order_items.order_id
 GROUP BY stg_thelook__users.id
 ORDER BY stg_thelook__users.id

)

SELECT * FROM int_customer_order_lifetime_agg
