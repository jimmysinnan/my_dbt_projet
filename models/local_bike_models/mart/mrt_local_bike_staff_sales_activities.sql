{{ config(
    materialized = 'table'
) }}

SELECT
    oi.order_created_at AS report_date,
    FORMAT_TIMESTAMP('%Y-%m', DATE_TRUNC(oi.order_created_at, MONTH)) AS report_month,
    s.store_name,
    s.state,
    st.manager_id,
    oi.staff_id,
    oi.category_name,
    oi.order_status,
    ROUND(SUM(oi.total_order_item_amount), 2) as total_revenue,
    ROUND(max(oi.total_order_item_amount),2) as highest_order_amount,
    COUNT(distinct oi.order_id) as number_total_orders,
    count(distinct oi.customer_id) as number_total_customer
FROM {{ ref('int_local_bike_order_items')}} as oi 
INNER join {{ref('stg_local_bike_stores')}} as s
on 
    s.store_id = oi.store_id
INNER JOIN {{ref('stg_local_bike_staffs')}} as st 
on 
    st.staff_id = oi.staff_id
group by
    report_date,
    s.store_name,
    s.state,
    st.manager_id,
    oi.staff_id,
    oi.order_status,
    oi.category_name
order by report_date desc 