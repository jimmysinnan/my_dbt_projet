{{ config(
    materialized = 'table'
) }}

select
    c.customer_id,
    c.city,
    c.state,
    c.brand_name,
    c.product_name,
    avgt.avg_days_between_orders as avg_time_between_purchase,
    ROUND(SUM(c.total_amount_spent),2) as total_amount_spent,
    ROUND(SUM(c.highest_purchase),2) as highest_purchase,
    coalesce(sum(c.total_distinct_items),0) as total_distinct_items,
    coalesce(sum(c.total_orders),0) as total_orders,
    o.order_status
from{{ref('int_local_bike_customers')}} as c
LEFT JOIN {{ref('int_local_bike_order')}} as o
on 
  o.customer_id = c.customer_id
LEFT JOIN {{ref('int_loca_bike_avg_time_between_order')}} as avgt
on 
  avgt.customer_id = c.customer_id
GROUP by 
c.customer_id,
c.city,
c.state,
c.brand_name,
c.product_name,
avg_time_between_purchase,
o.order_status