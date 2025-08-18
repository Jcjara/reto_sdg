{{ config(
    schema='raw_vault',
    materialized='incremental',
    unique_key='part_hk'
) }}

with s as (
  select distinct
    part_id
  from {{ ref('stg_tpch__part') }}
)

select
  {{ hk256(['part_id']) }} as part_hk,
  part_id                  as part_bk,
  current_timestamp()      as load_dt,
  'TPCH_SF1'               as record_src
from s
