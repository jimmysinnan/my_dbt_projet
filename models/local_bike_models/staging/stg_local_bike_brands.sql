{{ config(
    materialized = 'table'
) }}

SELECT
    brand_id,
    brand_name
from {{source('local_bike','brands')}}