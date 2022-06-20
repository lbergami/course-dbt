select state, 
       product_name,
       round(sum(user_prod_expenditure)) as revenues,
       round(sum(product_quantity)) as units_of_output
from {{ ref('fct_order_items_products') }}
group by 1, 2
order by state, revenues desc
