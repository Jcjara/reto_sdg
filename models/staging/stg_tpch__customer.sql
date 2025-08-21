{{ config(schema='staging', materialized='view') }}

SELECT
    c.c_custkey      AS customer_id,
    c.c_name         AS customer_name,
    c.c_nationkey    AS nation_id,
    c.c_acctbal      AS account_balance,
    c.c_mktsegment   AS market_segment,
    c.c_comment      AS comment
FROM {{ source('tpch', 'customer') }} AS c
