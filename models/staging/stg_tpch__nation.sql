{{ config(schema='staging', materialized='view') }}

SELECT
    n.n_nationkey    AS nation_id,
    n.n_name         AS nation_name,
    n.n_regionkey    AS region_id,
    n.n_comment      AS comment
FROM {{ source('tpch', 'nation') }} AS n
