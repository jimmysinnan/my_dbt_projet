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
), details_customers as (

select
    customer_id,
    city,
    state,
from {{ref('stg_local_bike_customers')}}

) 

SELECT
    os.customer_id,
    c.city,
    c.state,
    os.total_amount_spent,
    os.highest_purchase,
    os.total_items,
    os.total_distinct_items,
    os.total_orders,
    fp.favorite_product_id,
    p.product_name,
    b.brand_name
FROM orders_summary AS os
INNER JOIN details_customers as c
    on c.customer_id = os.customer_id
LEFT JOIN {{ ref('int_local_bike_customers_favorite_products') }} fp
    ON os.customer_id = fp.customer_id
LEFT JOIN {{ ref('stg_local_bike_brands') }} AS b
    ON b.brand_id = fp.brand_id
LEFT JOIN {{ ref('stg_local_bike_products')}} as p 
    on p.brand_id=b.brand_id

