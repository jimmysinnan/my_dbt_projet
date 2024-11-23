{{ config(
    materialized = 'table'
) }}

SELECT
    store_id,
    product_id,
    quantity
from {{source("local_bike",'stocks')}}