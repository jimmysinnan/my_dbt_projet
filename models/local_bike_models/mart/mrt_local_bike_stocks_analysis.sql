{{ config(
    materialized = 'table'
) }}

select
    sa.store_id,
    sa.brand_id,
    sa.brand_name,
    sa.category_id,
    sa.category_name,
    sa.total_stock_quantity,
    sa.stock_status,
    ROUND(coalesce(sa.total_stock_value,0),2) as total_stock_value,
    sa.product_id
from {{ref('int_local_bike_stocks_analysis')}} as sa