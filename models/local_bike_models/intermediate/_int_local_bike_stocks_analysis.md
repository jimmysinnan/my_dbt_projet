{% docs int_local_bike_stocks_analysis %}

This model return a combined view containing information about products in stock. It enriches the stocks data with the following metrics:
- **stock_status** : A classification of stock levels: Critical, Vigilant or Sufficient
- **nb_product** Total number of products. To find out the number of distinct products per brand 
- **total_stock_quantity** Total quantity in stock
- **num_critical_stocks** et **num_vigilant_stocks** et **num_sufficient_stocks** Counting products by stock status
- **total_stock_value** stock value 

It provides a comprehensive view of stocks, allowing for easy analysis of stocks performance by brands, category, and product for each store 

{% enddocs %}
