{{ config(
    schema='raw_vault',
    materialized='incremental',
    unique_key='supplier_hk'
) }}

with s as (
  select distinct
    supplier_id
  from {{ ref('stg_tpch__supplier') }}
)

select
  {{ hk256(['supplier_id']) }} as supplier_hk,
  supplier_id                  as supplier_bk,
  current_timestamp()          as load_dt,
  'TPCH_SF1'                   as record_src
from s
