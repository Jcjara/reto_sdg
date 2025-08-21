{{ config(schema='star', materialized='table') }}

WITH cur_cust AS (
    -- Current descriptive attributes from the satellite
    SELECT
        sc.customer_hk,
        sc.customer_name,
        sc.account_balance,
        sc.market_segment
    FROM {{ ref('sat_customer_attributes_view') }} sc
    WHERE sc.is_current
),
geo AS (
    -- Geography mapping (nation/region) at customer grain
    SELECT
        bcg.customer_hk,
        bcg.nation_id,
        bcg.nation_name,
        bcg.region_id,
        bcg.region_name
    FROM {{ ref('bv_customer_geography') }} bcg
)
SELECT
    cc.customer_hk                          AS customer_sk,      -- HK-as-SK
    cc.customer_name,
    cc.account_balance,
    cc.market_segment,
    g.nation_id,
    g.nation_name,
    g.region_id,
    g.region_name,
    {{ hk256(['g.nation_id']) }}            AS geography_sk      -- foreign key to dim_geography
FROM cur_cust cc
LEFT JOIN geo g
  ON g.customer_hk = cc.customer_hk
