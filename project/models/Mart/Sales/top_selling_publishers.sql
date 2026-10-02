{{ config(
    materialized='table'
) }}

with publishers_sales AS (

    SELECT 
         publisher_group,
         Avg_Rating,
         "Total Revenue",
         Total_Books_Sold,
         ROW_NUMBER() OVER(PARTITION BY publisher_group ORDER BY "Total Revenue" DESC ) AS rank

    FROM {{ ref('dim_Authors') }}

)

Select  * from publishers_sales
WHERE rank = 1

