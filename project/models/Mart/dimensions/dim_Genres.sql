{{ config(
    materialized='table'
) }}

WITH genres_data AS (
Select 
    google.gb_genre,
    COUNT(books.ISBN) AS books_in_genre,
    SUM(sales.volume_sold) AS total_books_sold

FROM 
    {{ ref('Int_Google_Books') }} AS google
    LEFT JOIN {{ ref('Int_Books') }} AS books
        ON google.ISBN = books.ISBN
    LEFT JOIN {{ ref('Int_Sales') }} AS sales
        ON books.ISBN = sales.ISBN
    GROUP BY 
        google.gb_genre
)

Select *
FROM 
    genres_data