
{{ config(materialized = 'table') }}


with author_sales AS(

    Select 
        *
    from {{ ref('dim_Authors') }}
),

ranked_authors AS (

    SELECT 
        *,
        ROW_NUMBER() OVER(PARTITION BY author_name ORDER BY "Total Revenue" DESC) AS rank
    FROM author_sales
)



Select 
    -- TOP 5
    * 
from 
    ranked_authors
WHERE rank = 1
ORDER BY 
    "Total Revenue" DESC
