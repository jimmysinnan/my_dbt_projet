      WITH test_data AS (
          SELECT
              COALESCE(total_order_amount, 0) AS total_order_amount,
              COALESCE(total_items, 0) AS total_items,
              COALESCE(total_distinct_items, 0) AS total_distinct_items
          FROM {{ ref('int_local_bike_order') }}
      )
      SELECT
          COUNT(*) AS null_coalesce_errors
      FROM test_data
      WHERE total_order_amount IS NULL
         OR total_items IS NULL
         OR total_distinct_items IS NULL