{{ config(
    materialized='table'
) }}

WITH publisher_revenue AS (
    SELECT
        authors.publisher_group AS publisher_name,
        COALESCE(SUM(sales.sales_value), 0) AS total_revenue,
        COALESCE(SUM(sales.volume_sold), 0) AS total_books_sold
    FROM {{ ref('Int_Authors_Ratings') }} AS authors
    LEFT JOIN {{ ref('Int_Books') }} AS books
        ON authors.author_name = books.book_author
    LEFT JOIN {{ ref('Int_Sales') }} AS sales
        ON books.ISBN = sales.ISBN
    GROUP BY 
        authors.publisher_group
)

SELECT *
FROM publisher_revenue