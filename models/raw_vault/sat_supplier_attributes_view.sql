{{ config(schema='raw_vault', materialized='view') }}

SELECT
    supplier_hk,
    name,
    address,
    nation_id,
    phone,
    account_balance,
    dbt_valid_from AS start_dt,
    dbt_valid_to   AS end_dt,
    dbt_valid_to IS NULL AS is_current,
    record_src
FROM {{ ref('sat_supplier_attributes') }}
