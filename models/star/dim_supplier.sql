{{ config(schema='star', materialized='table') }}

SELECT
    {{ hk256(['s.supplier_id']) }} AS supplier_sk,  -- HK-as-SK
    s.supplier_id                  AS supplier_bk,
    s.name                         AS supplier_name,
    s.address,
    s.nation_id,
    s.phone,
    s.account_balance
FROM {{ ref('stg_tpch__supplier') }} s
