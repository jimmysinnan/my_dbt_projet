WITH orders_summary AS (
    SELECT
        customer_id,
        SUM(total_order_amount) AS total_amount_spent,
        MAX(SUM(total_order_amount)) OVER (PARTITION BY customer_id) AS highest_purchase,
        SUM(total_items) AS total_items,
        SUM(total_distinct_items) AS total_distinct_items,
        COUNT(DISTINCT order_id) AS total_orders
    FROM {{ ref('int_local_bike_order') }}
    GROUP BY customer_id
)

SELECT
    os.customer_id,
    cust.city,
    cust.state,
    os.total_amount_spent,
    os.highest_purchase,
    os.total_items,
    os.total_distinct_items,
    os.total_orders,
    p.favorite_product_id,
    p.product_name,
    b.brand_name
FROM orders_summary AS os
INNER JOIN {{ ref('stg_local_bike_customers') }} cust
    ON cust.customer_id = os.customer_id
LEFT JOIN {{ ref('int_local_bike_customers_favorite_products') }} p
    ON os.customer_id = p.customer_id
LEFT JOIN {{ ref('stg_local_bike_brands') }} AS b
    ON b.brand_id = p.brand_id

