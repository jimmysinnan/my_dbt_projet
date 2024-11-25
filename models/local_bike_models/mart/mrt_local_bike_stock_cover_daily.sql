{{ config(
    materialized = 'table'
) }}


SELECT
    store_id,
    product_id,
    stock_quantity,
    ROUND(coalesce(avg_daily_quantity_sold,0),2) as avg_daily_quantity_sold,
    ROUND(coalesce(stock_coverage_days,0),2) as stock_coverage_days
FROM
    {{ref('int_local_bike_stock_cover_daily')}}
ORDER BY
    stock_coverage_days ASC