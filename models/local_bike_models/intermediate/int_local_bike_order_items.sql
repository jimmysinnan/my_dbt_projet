{{ config(
    materialized = 'view'
) }}

with reference_categories as (

SELECT
    category_id,
    category_name
From {{ ref('stg_local_bike_categories')}}

), reference_products as (

SELECT
    category_id,
    product_id,
    product_name,
    model_year
from {{ref('stg_local_bike_products')}}

)

SELECT
    oi.order_id,
    oi.item_id AS order_item_id,
    oi.product_id as product_id,
    rp.product_name,
    model_year,
    rc.category_id,
    rc.category_name,
    oi.quantity AS item_quantity,
    (oi.quantity * oi.list_price * (1 - oi.discount)) AS total_order_item_amount,
    o.customer_id,
    o.order_status,
    o.order_created_at AS order_created_at,
    o.order_shipped_at AS order_shipped_at,
    oi.discount as discount,
    o.store_id,
    o.staff_id
FROM
    {{ref('stg_local_bike_order_items')}} AS oi
INNER JOIN
    {{ref('stg_local_bike_order')}} AS o
ON
    oi.order_id = o.order_id
INNER JOIN
    reference_products as rp 
ON 
    rp.product_id = oi.product_id
INNER JOIN
    reference_categories as rc 
on 
    rc.category_id=rp.category_id
