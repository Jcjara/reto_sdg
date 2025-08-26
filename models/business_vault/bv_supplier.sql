WITH s AS (
    SELECT
        supplier_hk,
        supplier_name,
        address,
        nation_id,
        phone,
        account_balance,
        comment,
        dbt_valid_from,
        dbt_valid_to
    FROM {{ ref('sat_supplier_attributes') }}
    WHERE dbt_valid_to IS NULL
)

SELECT
    h.supplier_hk,
    h.supplier_id,
    s.supplier_name,
    s.address,
    s.nation_id,
    s.phone,
    s.account_balance,
    s.comment,
    s.dbt_valid_from AS start_dt,
    s.dbt_valid_to   AS end_dt
FROM {{ ref('hub_supplier') }} h
LEFT JOIN s
  ON s.supplier_hk = h.supplier_hk
