{{ config(
    materialized = 'table'
) }}

select
    CASE
    -- Catégorie Gold : dépenses élevées et nombre de commandes élevé
    WHEN c.total_amount_spent >= 10000 AND c.total_orders >= 50 THEN 'Gold'
    
    -- Catégorie Argent : dépenses modérées ou nombre moyen de commandes
    WHEN (c.total_amount_spent BETWEEN 5000 AND 9999 AND c.total_orders BETWEEN 20 AND 49)
         OR (c.total_amount_spent >= 10000 AND c.total_orders < 50) THEN 'Argent'
    
    -- Catégorie Bronze : faible dépense ou faible nombre de commandes
    WHEN c.total_amount_spent < 5000 OR c.total_orders < 20 THEN 'Bronze'
    
    -- Cas par défaut (optionnel)
    ELSE 'Non Classé'
    END AS customer_category, 
    c.customer_id,
    c.city,
    c.state,
    c.brand_name,
    c.product_name,
    avgt.avg_days_between_orders as avg_time_between_purchase,
    ROUND(SUM(c.total_amount_spent),2) as total_amount_spent,
    ROUND(SUM(c.highest_purchase),2) as highest_purchase,
    coalesce(sum(c.total_distinct_items),0) as total_distinct_items,
    coalesce(sum(c.total_orders),0) as total_orders,
    o.order_status
from{{ref('int_local_bike_customers')}} as c
LEFT JOIN {{ref('int_local_bike_order')}} as o
on 
  o.customer_id = c.customer_id
LEFT JOIN {{ref('int_loca_bike_avg_time_between_order')}} as avgt
on 
  avgt.customer_id = c.customer_id
GROUP by 
customer_category,
c.customer_id,
c.city,
c.state,
c.brand_name,
c.product_name,
avg_time_between_purchase,
o.order_status
