{{ config(schema='raw_vault', materialized='view') }}
select
  customer_hk,
  name, address, phone, account_balance, market_segment, nation_id, record_src,
  dbt_valid_from as start_dt,
  dbt_valid_to   as end_dt,
  case when dbt_valid_to is null then true else false end as is_current
from {{ ref('sat_customer_attributes') }}
