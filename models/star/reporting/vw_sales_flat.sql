{{ config(schema='star', materialized='view') }}

WITH f AS (
    SELECT
        customer_sk,
        product_sk,
        supplier_sk,
        geography_sk,
        order_hk,
        line_sk,
        order_date,
        ship_date,
        receipt_date,
        ship_mode,
        return_flag,
        line_status,
        quantity,
        gross_sales,
        discount_amount,
        tax_amount,
        net_sales
    FROM {{ ref('fact_sales') }}
),
dc AS (
    SELECT
        customer_sk,
        customer_name,
        market_segment,
        account_balance,
        nation_name   AS customer_nation_name,
        region_name   AS customer_region_name
    FROM {{ ref('dim_customer') }}
),
dp AS (
    SELECT
        product_sk,
        product_bk,
        part_name     AS product_name,
        brand,
        manufacturer,
        part_type,
        size,
        container,
        retail_price
    FROM {{ ref('dim_product') }}
),
ds AS (
    SELECT
        supplier_sk,
        supplier_bk,
        supplier_name,
        nation_id     AS supplier_nation_id
    FROM {{ ref('dim_supplier') }}
),
dg AS (
    SELECT
        geography_sk,
        nation_bk     AS geography_nation_bk,
        nation_name   AS geography_nation_name,
        region_id     AS geography_region_id,
        region_name   AS geography_region_name
    FROM {{ ref('dim_geography') }}
)

SELECT
    -- keys
    f.customer_sk,
    f.product_sk,
    f.supplier_sk,
    f.geography_sk,
    f.order_hk,
    f.line_sk,

    -- dates / status
    f.order_date,
    f.ship_date,
    f.receipt_date,
    f.ship_mode,
    f.return_flag,
    f.line_status,

    -- customer attrs
    dc.customer_name,
    dc.market_segment,
    dc.account_balance,
    dc.customer_nation_name,
    dc.customer_region_name,

    -- product attrs
    dp.product_bk,
    dp.product_name,
    dp.brand,
    dp.manufacturer,
    dp.part_type,
    dp.size,
    dp.container,
    dp.retail_price,

    -- supplier attrs
    ds.supplier_bk,
    ds.supplier_name,

    -- geography attrs (from dim_geography)
    dg.geography_nation_bk,
    dg.geography_nation_name,
    dg.geography_region_id,
    dg.geography_region_name,

    -- measures
    f.quantity,
    f.gross_sales,
    f.discount_amount,
    f.tax_amount,
    f.net_sales
FROM f
LEFT JOIN dc ON dc.customer_sk  = f.customer_sk
LEFT JOIN dp ON dp.product_sk   = f.product_sk
LEFT JOIN ds ON ds.supplier_sk  = f.supplier_sk
LEFT JOIN dg ON dg.geography_sk = f.geography_sk
