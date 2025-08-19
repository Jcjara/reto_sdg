{{ config(schema='star', materialized='table') }}

with cur as (
  select
    customer_hk,
    name,
    address,
    phone,
    account_balance,
    market_segment,
    nation_id,
    record_src
  from {{ ref('sat_customer_attributes_view') }}
  where is_current = true
),
hub as (
  select customer_hk, customer_bk
  from {{ ref('hub_customer') }}
)

select
  h.customer_hk as customer_sk,   -- star surrogate = HK
  h.customer_bk,
  c.name,
  c.address,
  c.phone,
  c.account_balance,
  c.market_segment,
  c.nation_id,
  c.record_src
from hub h
join cur c
  on c.customer_hk = h.customer_hk
