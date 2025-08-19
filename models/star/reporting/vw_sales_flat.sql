{{ config(schema='star', materialized='view') }}

with f as (
  select *
  from {{ ref('fact_sales') }}
),
dc as (
  select customer_sk, customer_bk, name as customer_name, market_segment
  from {{ ref('dim_customer') }}
),
dp as (
  select product_sk, product_bk, part_name as product_name, brand, manufacturer, retail_price
  from {{ ref('dim_product') }}
)

select
  -- keys
  f.link_hk            as line_sk,
  f.order_hk,
  f.customer_sk,
  f.product_sk,

  -- dates
  f.order_date,
  f.ship_date,
  f.receipt_date,

  -- dims
  dc.customer_bk,
  dc.customer_name,
  dc.market_segment,
  dp.product_bk,
  dp.product_name,
  dp.brand,
  dp.manufacturer,
  dp.retail_price,

  -- measures
  f.quantity,
  f.gross_sales,
  f.discount_amount,
  f.tax_amount,
  f.net_sales,
  f.ship_mode
from f
left join dc on dc.customer_sk = f.customer_sk
left join dp on dp.product_sk  = f.product_sk
