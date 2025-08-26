WITH s AS (
    SELECT
        customer_hk,
        customer_name,
        nation_id,
        account_balance,
        market_segment,
        comment,
        dbt_valid_from,
        dbt_valid_to
    FROM {{ ref('sat_customer_attributes') }}
    WHERE dbt_valid_to IS NULL
)

SELECT
    h.customer_hk,
    h.customer_id,
    s.customer_name,
    s.nation_id,
    s.account_balance,
    s.market_segment,
    s.comment,
    s.dbt_valid_from AS start_dt,
    s.dbt_valid_to   AS end_dt
FROM {{ ref('hub_customer') }} h
LEFT JOIN s
  ON s.customer_hk = h.customer_hk
