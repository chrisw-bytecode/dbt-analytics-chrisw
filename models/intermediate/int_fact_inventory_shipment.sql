WITH int_fact_inventory_shipment AS (

        SELECT stg_thelook__order_items.order_id,
               stg_thelook__order_items.id AS order_item_id,
               stg_thelook__inventory_items.id AS inventory_item_id,
               stg_thelook__inventory_items.product_id,
               stg_thelook__inventory_items.product_distribution_center_id,
               stg_thelook__orders.created_at,
               stg_thelook__orders.shipped_at,
               DATE_DIFF(stg_thelook__orders.shipped_at,stg_thelook__orders.created_at,HOUR) AS order_to_ship_hrs,
               stg_thelook__orders.delivered_at,
               DATE_DIFF(stg_thelook__orders.delivered_at,stg_thelook__orders.shipped_at,HOUR) AS ship_to_deliver_hrs,
               stg_thelook__orders.returned_at,
               DATE_DIFF(stg_thelook__orders.returned_at,stg_thelook__orders.delivered_at,HOUR) AS deliver_to_return_hrs
          FROM {{ ref('stg_thelook__inventory_items') }}
     LEFT JOIN {{ ref('stg_thelook__order_items') }}
            ON stg_thelook__inventory_items.id = stg_thelook__order_items.inventory_item_id
     LEFT JOIN {{ ref('stg_thelook__orders') }}
            ON stg_thelook__order_items.order_id = stg_thelook__orders.order_id
         WHERE stg_thelook__orders.shipped_at IS NOT NULL
      ORDER BY stg_thelook__orders.order_id,
               stg_thelook__order_items.id,
               stg_thelook__inventory_items.product_distribution_center_id
)

SELECT * FROM int_fact_inventory_shipment