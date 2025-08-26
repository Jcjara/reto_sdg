SELECT
    c.customer_hk       AS customer_sk,    -- using HK as SK
    c.customer_id,
    c.customer_name,
    c.market_segment,
    n.nation_name,
    r.region_name,
    c.account_balance
FROM {{ ref('bv_customer') }} c
LEFT JOIN {{ ref('bv_nation') }} n
  ON n.nation_id = c.nation_id
LEFT JOIN {{ ref('bv_region') }} r
  ON r.region_id = n.region_id
