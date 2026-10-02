{{ config(
    materialized='table'
) }}

WITH distinct_authors AS (
    SELECT 
        DISTINCT
        REPLACE(TRIM(UPPER(Author_name)), '  ', '') AS author_name
    FROM {{ ref('Int_Authors_Ratings') }}
    WHERE author_name IS NOT NULL
),
 author_revenue AS (
    SELECT
        da.author_name AS author_name,
        
        COALESCE(SUM(sales.volume_sold), 0) AS total_books_sold,
        COALESCE(SUM(sales.sales_value), 0) AS total_revenue,
    FROM 
        distinct_authors as da
    LEFT JOIN {{ ref('Int_Books') }} AS books
        ON da.author_name = books.book_author
    LEFT JOIN {{ ref('Int_Sales') }} AS sales
        ON books.ISBN = sales.ISBN
    GROUP BY 
         da.author_name
       
)

SELECT *
FROM author_revenue
WHERE author_name IS NOT NULL