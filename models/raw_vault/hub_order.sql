{{ config(
    schema='raw_vault',
    materialized='incremental',
    unique_key='order_hk'
) }}

with s as (
  select distinct
    order_id
  from {{ ref('stg_tpch__orders') }}
)

select
  {{ hk256(['order_id']) }} as order_hk,
  order_id                  as order_bk,
  current_timestamp()       as load_dt,
  'TPCH_SF1'                as record_src
from s
