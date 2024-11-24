{{ config(
    materialized = 'view'
) }}

WITH daily_sales AS (
    SELECT
        oi.product_id,
        o.store_id,
        COUNT(DISTINCT o.order_id) AS num_orders,
        SUM(oi.item_quantity) AS total_quantity_sold,
        DATE(o.order_created_at) AS sales_date
    FROM
        {{ref('int_local_bike_order_items')}} AS oi
    left JOIN
        {{ref('int_local_bike_order')}} AS o
    ON
        oi.order_id = o.order_id
    WHERE
        o.order_status = 'Shipped'  -- Filter on 'Shipped' orders only
    GROUP BY
        oi.product_id, o.store_id, sales_date
),
average_daily_sales AS (
    SELECT
        product_id,
        store_id,
        AVG(total_quantity_sold) AS avg_daily_quantity_sold
    FROM
        daily_sales
    GROUP BY
        product_id, store_id
),
stock_coverage AS (
    SELECT
        s.store_id,
        s.product_id,
        s.quantity AS stock_quantity,
        ads.avg_daily_quantity_sold,
        CASE
            WHEN ads.avg_daily_quantity_sold > 0 THEN ROUND(s.quantity / ads.avg_daily_quantity_sold, 2)
            ELSE NULL
        END AS stock_coverage_days
    FROM
        {{ref("stg_local_bike_stocks")}} AS s
    LEFT JOIN
        average_daily_sales AS ads
    ON
        s.product_id = ads.product_id AND s.store_id = ads.store_id
)
SELECT
    store_id,
    product_id,
    stock_quantity,
    ROUND(coalesce(avg_daily_quantity_sold,0),2) as avg_daily_quantity_sold,
    ROUND(coalesce(stock_coverage_days,0),2) as stock_coverage_days
FROM
    stock_coverage
ORDER BY
    stock_coverage_days ASC
