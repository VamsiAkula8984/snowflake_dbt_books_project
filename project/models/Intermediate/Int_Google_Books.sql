{{ config(
    materialized='view',
    unique_key='ISBN'
) }}


SELECT DISTINCT
    ISBN,
    GB_Title AS gb_title,
    GB_Author AS gb_author,
    GB_Desc AS gb_desc,
    GB_Pages AS gb_pages,
    GB_Genre AS gb_genre
FROM {{ ref('all_years_data') }}
WHERE ISBN IS NOT NULL
ORDER BY ISBN

