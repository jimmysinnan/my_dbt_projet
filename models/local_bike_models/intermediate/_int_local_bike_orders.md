{% docs int_local_bike_orders %}

This model provides an aggregated view of orders, combining data from multiple sources such as order items, customer details. It enriches the order data with the following metrics:
- **Total Order Amount**: The sum of all order items for each order.
- **Total Items**: The total quantity of items in the order.
- **Total Distinct Items**: The count of distinct product types in the order.
- **customer Information**: Enriches the order with customer-specific data, such as city and state.

It provides a comprehensive view of each order, allowing for easy analysis of order performance, customer demographics, and feedback.

{% enddocs %}
