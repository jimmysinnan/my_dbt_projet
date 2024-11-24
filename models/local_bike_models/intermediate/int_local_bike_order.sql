{{ config(
    materialized = 'view'
) }}

with order_item_grouped_by_order as (

SELECT
    order_id,
    customer_id,
    order_status,
    order_created_at,
    order_shipped_at,
    SUM(total_order_item_amount) as total_order_amount,
    SUM(item_quantity) as total_items,
    count(DISTINCT(product_id)) as total_distinct_items,
    store_id,
    staff_id
FROM {{ref('int_local_bike_order_items') }}
group by order_id,
    customer_id,
    order_status,
    order_created_at,
    order_shipped_at,
    store_id,
    staff_id
    
)

select oi.order_id,
    oi.customer_id,
    oi.order_status,
    c.city,
    c.state,
    c.zip_code,
    oi.order_created_at,
    oi.order_shipped_at,
    oi.store_id,
    oi.staff_id,
    coalesce(oi.total_order_amount,0) as total_order_amount,
    coalesce(oi.total_items,0) as total_items,
    coalesce(oi.total_distinct_items,0) as total_distinct_items
from order_item_grouped_by_order as oi
left join {{ ref('stg_local_bike_customers' )}} as c on c.customer_id = oi.customer_id