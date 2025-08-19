{{ config(
    schema='raw_vault',
    materialized='incremental',
    unique_key='link_hk'
) }}

with s as (
  select distinct
    order_id,
    part_id,
    supplier_id,
    line_number
  from {{ ref('stg_tpch__lineitem') }}
)

select
  -- Include line_number so each line is unique
  {{ hk256(['order_id','part_id','supplier_id','line_number']) }} as link_hk,

  {{ hk256(['order_id']) }}    as order_hk,
  {{ hk256(['part_id']) }}     as part_hk,
  {{ hk256(['supplier_id']) }} as supplier_hk,

  line_number                  as line_no_bk,
  current_timestamp()          as load_dt,
  'TPCH_SF1'                   as record_src
from s
