{{ config(schema='star', materialized='table') }}

SELECT
    {{ hk256(['p.part_id']) }} AS product_sk,  -- HK-as-SK
    p.part_id                  AS product_bk,
    p.part_name,
    p.manufacturer,
    p.brand,
    p.part_type,
    p.size,
    p.container,
    p.retail_price
FROM {{ ref('stg_tpch__part') }} p
