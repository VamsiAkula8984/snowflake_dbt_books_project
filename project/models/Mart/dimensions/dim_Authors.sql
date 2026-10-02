{{ config(materialized = 'table') }}

with Authors_Sales
AS 
(
    SELECT 
        authors.author_id,
        authors.author_name,
        authors.publisher_group,
        ROUND(authors.Avg_Rating,2) Avg_Rating,
        SUM(sales.volume_sold) AS Total_Books_Sold,
        SUM(sales.sales_value) AS "Total Revenue"

    FROM 
        {{ ref('Int_Authors_Ratings') }} as authors
        LEFT JOIN {{ ref('Int_Books') }} as books
            ON authors.author_name = books.book_author
        LEFT JOIN {{ ref('Int_Sales') }} as sales
            ON books.ISBN = sales.ISBN
    GROUP BY 
        authors.author_id,
        authors.author_name,
        authors.publisher_group,
        authors.Avg_Rating
)

SELECT * FROM Authors_Sales