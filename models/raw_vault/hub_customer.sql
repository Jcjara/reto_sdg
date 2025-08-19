{{ config(
    schema='raw_vault',
    materialized='incremental',
    unique_key='customer_hk'
) }}

with s as (
  select distinct
    customer_id
  from {{ ref('stg_tpch__customer') }}
)

select
  {{ hk256(['customer_id']) }} as customer_hk,
  customer_id                  as customer_bk,
  current_timestamp()          as load_dt,
  'TPCH_SF1'                   as record_src
from s
