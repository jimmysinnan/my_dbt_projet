{{ config(
    materialized = 'table'
) }}

SELECT
    oi.order_created_at AS report_date,
    FORMAT_TIMESTAMP('%Y-%m', DATE_TRUNC(oi.order_created_at, MONTH)) AS report_month,
    s.store_name,
    s.state,
    oi.category_name,
    oi.product_name,
    oi.model_year,
    oi.order_status,
    ROUND(SUM(oi.total_order_item_amount), 2) as total_revenue,
    COUNT(distinct oi.order_id) as number_total_orders,
    count(distinct oi.customer_id) as number_total_customer
FROM {{ ref('int_local_bike_order_items')}} as oi 
INNER join {{ref('stg_local_bike_stores')}} as s
on 
    s.store_id = oi.store_id
group by
    report_date,
    s.store_name,
    s.state,
    oi.order_status,
    oi.category_name,
    oi.product_name,
    oi.model_year
order by report_date desc 