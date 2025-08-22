SELECT
  customer_hk,
  customer_name,
  nation_id,
  account_balance,
  market_segment,
  comment,
  dbt_valid_from AS start_dt,
  dbt_valid_to   AS end_dt,
  dbt_valid_to IS NULL AS is_current,
  record_src
FROM {{ ref('sat_customer_attributes') }}
