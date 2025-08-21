{{ config(schema='star', materialized='table') }}

WITH bv AS (
    SELECT
        customer_hk,
        part_hk,
        supplier_hk,
        order_hk,
        link_hk,
        order_date,
        ship_date,
        receipt_date,
        ship_mode,
        return_flag,
        line_status,
        brand,
        manufacturer,
        part_type,
        market_segment,
        quantity,
        gross_sales,
        discount_amount,
        tax_amount,
        net_sales
    FROM {{ ref('bv_lineitem_enriched') }}
),
cust_geo AS (
    SELECT
        bcg.customer_hk,
        bcg.nation_id
    FROM {{ ref('bv_customer_geography') }} bcg
)

SELECT
    -- Surrogate keys (HK-as-SK)
    b.customer_hk                                  AS customer_sk,
    b.part_hk                                      AS product_sk,
    b.supplier_hk                                  AS supplier_sk,
    {{ hk256(['cg.nation_id']) }}                  AS geography_sk,

    -- Degenerate keys / naturals useful for drill-through
    b.order_hk,
    b.link_hk                                      AS line_sk,

    -- Dates / flags / modes
    b.order_date,
    b.ship_date,
    b.receipt_date,
    b.ship_mode,
    b.return_flag,
    b.line_status,

    -- Measures
    b.quantity,
    b.gross_sales,
    b.discount_amount,
    b.tax_amount,
    b.net_sales
FROM bv b
LEFT JOIN cust_geo cg
  ON cg.customer_hk = b.customer_hk
