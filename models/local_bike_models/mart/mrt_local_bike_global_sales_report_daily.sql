{{ config(
    materialized = 'table'
) }}

SELECT
    DATE_TRUNC(o.order_created_at, DAY) AS report_date,
    o.store_id,
    o.state,
    ROUND(SUM(o.total_order_amount),2) as total_revenue,
    COUNT(o.order_id) as number_total_orders,
    ROUND(AVG(o.total_order_amount),2) as panier_moyen,
    ROUND(max(total_order_amount),2) as highest_order_amount,
    count(o.customer_id) as number_total_customer
FROM {{ ref('int_local_bike_order')}} as o 
group by
    report_date,
    o.store_id,
    o.state
order by report_date asc 