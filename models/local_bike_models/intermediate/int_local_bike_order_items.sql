{{ config(
    materialized = 'view'
) }}

SELECT
    oi.order_id,
    oi.item_id AS order_item_id,
    oi.product_id as product_id,
    oi.quantity AS item_quantity,
    (oi.quantity * oi.list_price * (1 - oi.discount)) AS total_order_item_amount,
    o.customer_id,
    o.order_status,
    o.order_created_at AS order_created_at,
    o.order_shipped_at AS order_shipped_at,
    oi.discount as discount
FROM
    {{ref('stg_local_bike_order_items')}} AS oi
INNER JOIN
    {{ref('stg_local_bike_order')}} AS o
ON
    oi.order_id = o.order_id