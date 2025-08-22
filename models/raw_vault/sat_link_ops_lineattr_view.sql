SELECT
  link_hk,
  quantity,
  extended_price,
  discount,
  tax,
  return_flag,
  line_status,
  ship_date,
  commit_date,
  receipt_date,
  ship_instruct,
  ship_mode,
  comment,
  dbt_valid_from AS start_dt,
  dbt_valid_to   AS end_dt,
  dbt_valid_to IS NULL AS is_current,
  record_src
FROM {{ ref('sat_link_ops_lineattr') }}
