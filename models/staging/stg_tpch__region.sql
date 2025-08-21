{{ config(schema='staging', materialized='view') }}

SELECT
    r.r_regionkey    AS region_id,
    r.r_name         AS region_name,
    r.r_comment      AS comment
FROM {{ source('tpch', 'region') }} AS r
