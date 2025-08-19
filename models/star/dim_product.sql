{{ config(schema='star', materialized='table') }}

select
  {{ hk256(['part_id']) }} as product_sk,    -- surrogate = part HK
  part_id                  as product_bk,
  part_name,
  manufacturer,
  brand,
  part_type,
  size,
  container,
  retail_price
from {{ ref('stg_tpch__part') }}
