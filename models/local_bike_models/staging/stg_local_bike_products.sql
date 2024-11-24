{{ config(
    materialized = 'table'
) }}

SELECT
    product_id,
    -- Nettoyage du nom du produit
    CASE
        WHEN STRPOS(product_name, "'") > 0 AND STRPOS(product_name, "-") > 0 THEN
            SUBSTR(product_name, 1, LEAST(STRPOS(product_name, "'"), STRPOS(product_name, "-")) - 1)
        WHEN STRPOS(product_name, "'") > 0 THEN
            SUBSTR(product_name, 1, STRPOS(product_name, "'") - 1)
        WHEN STRPOS(product_name, "-") > 0 THEN
            SUBSTR(product_name, 1, STRPOS(product_name, "-") - 1)
        ELSE
            product_name
    END AS product_name,
    brand_id,
    category_id,
    model_year,
    list_price
FROM {{ source("local_bike", "products") }}
