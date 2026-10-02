{{ config(
    materialized='table',
    tags = ['staging'] 
) }}

SELECT 
    ASP AS asp,
    Author AS author,
    Binding AS binding,
    GB_Author AS gb_author,
    GB_Desc AS gb_desc,
    GB_Genre AS gb_genre,
    GB_Pages AS gb_pages,
    GB_Title AS gb_title,
    GR_Author AS gr_author,
    GR_Pages AS gr_pages,
    GR_Rating AS gr_rating,
    GR_Title AS gr_title,
    ISBN AS isbn,
    Imprint AS imprint,
    Position AS position,
    Product_Class AS product_class,
    Publ_Date AS publ_date,
    Publisher_Group AS publisher_group,
    RRP AS rrp,
    Sales_Year AS sales_year,
    Title AS title,
    Value AS value,
    Volume AS volume
FROM {{ source('raw_data', 'books_raw') }}