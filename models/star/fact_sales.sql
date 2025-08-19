{{ config(schema='star', materialized='table') }}

with bv as (
  select *
  from {{ ref('bv_lineitem_enriched') }}
)

select
  -- FKs to dims (use HKs as SKs)
  customer_hk as customer_sk,
  part_hk     as product_sk,

  -- degenerate/order fields
  order_hk,
  link_hk,                 -- line grain surrogate
  order_date,
  ship_date,
  receipt_date,
  ship_mode,

  -- measures
  quantity,
  gross_sales,
  discount_amount,
  tax_amount,
  net_sales
from bv
