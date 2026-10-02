
{{ config(
    materialized='view',
    unique_key='author_id',
    tags= ['intermediate', 'authors']
) }}

WITH deduplicated_authors 
AS 
(
    Select 
        author AS Author_Name,
        Publisher_group AS publisher_group,
        AVG(gr_rating) AS Avg_Rating,
        ROW_NUMBER() OVER(ORDER BY Author) AS author_id
    FROM
        (
            SELECT 
                DISTINCT 
                author,
                publisher_group,
                gr_rating
            FROM {{ ref('all_years_data') }}
            WHERE author IS NOT NULL
        ) 
            AS Unique_Authors
    GROUP BY 
        author,
        Publisher_group
)

Select 
    author_id,
    Author_Name,
    publisher_group,
    ROUND(Avg_Rating,2) AS Avg_Rating
from deduplicated_authors
ORDER BY author_id
