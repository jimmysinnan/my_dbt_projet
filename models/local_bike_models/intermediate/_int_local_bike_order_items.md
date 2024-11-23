{% docs int_local_bike_order_items %}

This model return a combined view containing information about each item ordered and the details associated with the order. It enriches the order data with the following metrics:
- **order_id** et **order_item_id** : Each order (order_id) can have several individual items (order_item_id)..
- **total_order_item_amount** This is the total price after discounts.

It provides a comprehensive view of each order, allowing for easy analysis of order performance, customer demographics, and feedback.

{% enddocs %}