select
    order_id,
    sum(total_order_item_amount) as total_order_item_amount
from {{ ref('int_local_bike_order_items') }}
group by order_id
having total_amount < 0