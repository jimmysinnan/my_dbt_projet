{{ config(
    materialized = 'view'
) }}

WITH customer_orders AS (
    SELECT
        customer_id,
        order_id,
        order_created_at
    FROM {{ ref('int_local_bike_order') }}
),

order_differences AS (
    SELECT
        order_id,
        customer_id,
        order_created_at,
        LAG(order_created_at) OVER (PARTITION BY customer_id ORDER BY order_created_at ASC) AS previous_order_date
    FROM customer_orders
),

customer_activity AS (
    SELECT
        customer_id,
        COUNT(order_id) AS total_orders,
        AVG(DATE_DIFF(order_created_at, previous_order_date, DAY)) AS avg_days_between_orders
    FROM order_differences
    WHERE previous_order_date IS NOT NULL -- Exclure la première commande car elle n'a pas de commande précédente
    GROUP BY customer_id
)

SELECT
    customer_id,
    total_orders,
    avg_days_between_orders
FROM customer_activity
WHERE total_orders >= 2 -- Filtrer les clients ayant au moins 2 commandes
ORDER BY avg_days_between_orders
