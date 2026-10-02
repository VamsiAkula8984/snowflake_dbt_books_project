
{{ config(
    materialized='view',
    unique_key='ISBN'
) }}

SELECT 
    DISTINCT 
    ISBN,
    Title as book_title,
    Author AS book_author,
    Binding as binding,
    Publ_date AS publish_date,
    Product_class as product_class
FROM {{ ref('all_years_data') }}
WHERE 
    book_author IS NOT NULL
ORDER BY 
    ISBN