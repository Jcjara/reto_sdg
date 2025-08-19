{{ config(schema='raw_vault', materialized='view') }}
select
  link_hk,
  quantity, extended_price, discount, tax,
  return_flag, line_status, ship_date, commit_date, receipt_date,
  ship_instruct, ship_mode, comment, record_src,
  dbt_valid_from as start_dt,
  dbt_valid_to   as end_dt,
  case when dbt_valid_to is null then true else false end as is_current
from {{ ref('sat_link_ops_lineattr') }}
