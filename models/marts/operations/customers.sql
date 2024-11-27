WITH customers AS (

    SELECT {{ dbt_utils.star(from=ref('stg_thelook__users')) }},
           {{ dbt_utils.star(from=ref('int_customer_order_lifetime_agg'), except=["user_id","revenue"], prefix='lifetime_')}},
           {{ round_2('int_customer_order_lifetime_agg.revenue') }} AS lifetime_revenue,
           CASE WHEN int_customer_order_lifetime_agg.revenue > 500 THEN TRUE END AS is_high_value
      FROM {{ ref('stg_thelook__users') }}
      JOIN {{ ref('int_customer_order_lifetime_agg') }}
        ON stg_thelook__users.id = int_customer_order_lifetime_agg.user_id
     WHERE int_customer_order_lifetime_agg.orders > 0
  ORDER BY stg_thelook__users.id

)

SELECT * FROM customers