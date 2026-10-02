{{ config(
    materialized='view',
    unique_key='sales_id'
) }}


SELECT DISTINCT
    ISBN as ISBN,
    Sales_Year AS sales_year,
    Position AS position,
    Volume AS volume_sold,
    Value AS sales_value,
    RRP AS recommended_retail_price,
    ASP AS average_selling_price,
    ROW_NUMBER() OVER (ORDER BY ISBN, sales_year, position) AS sales_id
FROM {{ ref('all_years_data') }}
WHERE 
    ISBN IS NOT NULL
ORDER BY 
    ISBN, sales_year
