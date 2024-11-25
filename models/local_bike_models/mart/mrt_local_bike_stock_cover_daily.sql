{{ config(
    materialized = 'table'
) }}


SELECT
    store_id,
    product_id,
    stock_quantity,
    ROUND(avg_daily_quantity_sold,2) as avg_daily_quantity_sold,
    ROUND(stock_coverage_days,2) as stock_coverage_days
FROM
    {{ref('int_local_bike_stock_cover_daily')}}
ORDER BY
    stock_coverage_days ASC