{{ config(
    materialized = 'table'
) }}

SELECT
    order_id,
    customer_id,
    CASE 
        WHEN order_status = 1 THEN 'Pending'
        WHEN order_status = 2 THEN 'Approved'
        WHEN order_status = 3 THEN 'Canceled'
        WHEN order_status = 4 THEN 'Shipped'
        ELSE 'Unknown'
    END AS order_status,
    order_date AS order_created_at,
    required_date AS order_required_at,
    PARSE_DATE('%Y-%m-%d', NULLIF(shipped_date, 'NULL')) AS order_shipped_at,
    store_id,
    staff_id
FROM {{ source("local_bike", "order") }}