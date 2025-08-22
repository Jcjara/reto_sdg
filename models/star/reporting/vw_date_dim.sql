{{ config(
    materialized='view',
    schema='star',
    alias='vw_date_dim'
) }}

WITH base_dates AS (
    SELECT DISTINCT 
        f.order_date   AS date_day 
    FROM {{ ref('fact_sales') }} f 
    WHERE f.order_date IS NOT NULL

    UNION

    SELECT DISTINCT 
        f.ship_date    AS date_day 
    FROM {{ ref('fact_sales') }} f 
    WHERE f.ship_date IS NOT NULL

    UNION

    SELECT DISTINCT 
        f.receipt_date AS date_day 
    FROM {{ ref('fact_sales') }} f 
    WHERE f.receipt_date IS NOT NULL
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['date_day']) }} AS date_sk,
    date_day,
    DATE_PART('day',     date_day) AS day_of_month,
    DATE_PART('month',   date_day) AS month,
    DATE_PART('quarter', date_day) AS quarter,
    DATE_PART('year',    date_day) AS year,
    DAYNAME(date_day)              AS day_name,
    MONTHNAME(date_day)            AS month_name
FROM base_dates
