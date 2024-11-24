{{ config(
    materialized = 'view'
) }}

WITH critical_stocks AS (
    SELECT
        s.store_id,
        s.product_id,
        s.quantity AS stock_quantity,
        CASE
            WHEN s.quantity <= 5 THEN 'Critical'
            WHEN s.quantity BETWEEN 6 AND 10 THEN 'Vigilant'
            ELSE 'Sufficient'
        END AS stock_status
    FROM {{ ref('stg_local_bike_stocks') }} AS s
),

aggregated_stocks AS (
    SELECT
        p.brand_id,
        p.category_id,
        p.product_id,
        p.model_year,
        COUNT(DISTINCT p.product_id) AS nb_product,
        SUM(cs.stock_quantity) AS total_stock_quantity,
        SUM(cs.stock_quantity * p.list_price) AS total_stock_value
    FROM {{ ref("stg_local_bike_products") }} AS p
    LEFT JOIN critical_stocks AS cs
    ON p.product_id = cs.product_id
    GROUP BY
        p.brand_id,
        p.category_id,
        p.product_id,
        p.model_year
)

SELECT
    cs.store_id,
    ags.brand_id,
    b.brand_name,
    ags.category_id,
    cat.category_name,
    ags.nb_product,
    ags.total_stock_quantity,
    cs.stock_status,
    ags.total_stock_value,
    cs.product_id
FROM critical_stocks AS cs
LEFT JOIN aggregated_stocks AS ags 
ON cs.product_id = ags.product_id
LEFT JOIN {{ ref('stg_local_bike_brands') }} AS b
ON b.brand_id = ags.brand_id
LEFT JOIN {{ ref('stg_local_bike_categories') }} AS cat
ON cat.category_id = ags.category_id
