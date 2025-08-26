SELECT
    -- grain: one row per fact line
    f.sales_sk,
    f.order_hk,
    f.customer_hk,
    f.part_hk,
    f.supplier_hk,

    -- dates from fact
    f.order_date,
    f.ship_date,
    f.receipt_date,
    f.commit_date,
    f.ship_mode,

    -- measures (raw)
    f.quantity,
    f.extended_price,
    f.discount,
    f.tax,

    -- standardized metrics (computed here)
    (f.extended_price)                                                            AS gross_sales,
    (f.extended_price * (1 - COALESCE(f.discount, 0)))                            AS net_sales_before_tax,
    (f.extended_price * (1 - COALESCE(f.discount, 0)) * (1 + COALESCE(f.tax, 0))) AS net_sales,

    -- conformed dims
    c.customer_name,
    c.market_segment,
    c.account_balance,
    p.part_name,
    p.brand,
    p.part_type,
    s.supplier_name,
    n.nation_name,
    r.region_name
FROM {{ ref('fact_sales') }} f
LEFT JOIN {{ ref('dim_customer') }} c
  ON f.customer_hk = c.customer_sk
LEFT JOIN {{ ref('dim_part') }} p
  ON f.part_hk = p.part_sk
LEFT JOIN {{ ref('dim_supplier') }} s
  ON f.supplier_hk = s.supplier_sk
LEFT JOIN {{ ref('dim_nation') }} n
  ON c.nation_name = n.nation_name
LEFT JOIN {{ ref('dim_region') }} r
  ON n.region_name = r.region_name
