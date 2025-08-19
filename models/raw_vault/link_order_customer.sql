{{ config(
    schema='raw_vault',
    materialized='incremental',
    unique_key='link_hk'
) }}

with s as (
  select distinct
    order_id,
    customer_id
  from {{ ref('stg_tpch__orders') }}
)

select
  -- Link HK based on BKs in a fixed order
  {{ hk256(['order_id','customer_id']) }} as link_hk,

  -- Participant HKs for joins
  {{ hk256(['order_id']) }}    as order_hk,
  {{ hk256(['customer_id']) }} as customer_hk,

  current_timestamp() as load_dt,
  'TPCH_SF1'          as record_src
from s
