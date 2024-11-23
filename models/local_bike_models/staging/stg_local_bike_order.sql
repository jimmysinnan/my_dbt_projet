{{ config(
    materialized = 'table'
) }}

SELECT
    order_id,
    customer_id
    order_status,
    order_date,
    required_date,
    cast(shipped_date as date) as shipped_date
    store_id,
    staff_id
from {{source("local_bike",'order')}}