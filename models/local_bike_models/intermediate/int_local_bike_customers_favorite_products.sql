{{ config(
    materialized = 'view'
) }}

SELECT
    oi.customer_id,
    oi.product_id AS favorite_product_id,
    p.brand_id
FROM 
    {{ ref('int_local_bike_order_items') }} AS oi
LEFT JOIN 
    {{ ref('stg_local_bike_products') }} AS p
    ON p.product_id = oi.product_id
GROUP BY
    oi.customer_id,
    oi.product_id,
    p.brand_id
QUALIFY 
    ROW_NUMBER() OVER (
        PARTITION BY oi.customer_id
        ORDER BY SUM(oi.item_quantity) DESC
    ) = 1
