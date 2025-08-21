{{ config(
    schema='raw_vault',
    materialized='incremental',
    unique_key='link_hk',
    on_schema_change='sync_all_columns'
) }}

WITH base AS (
    SELECT
        l.order_id     AS order_bk,
        l.part_id      AS part_bk,
        l.supplier_id  AS supplier_bk,
        l.line_number  AS line_bk
    FROM {{ ref('stg_tpch__lineitem') }} l
),
keys AS (
    SELECT
        order_bk,
        part_bk,
        supplier_bk,
        line_bk,
        {{ hk256(['order_bk']) }}     AS order_hk,
        {{ hk256(['part_bk']) }}      AS part_hk,
        {{ hk256(['supplier_bk']) }}  AS supplier_hk,
        -- Include line_bk as a dependent child key in the link hash for line-level uniqueness
        {{ hk256(['order_bk','part_bk','supplier_bk','line_bk']) }} AS link_hk,
        CURRENT_TIMESTAMP() AS load_dt,
        'stg_tpch__lineitem' AS record_src
    FROM base
)

SELECT
    link_hk,
    order_hk,
    part_hk,
    supplier_hk,
    load_dt,
    record_src
FROM keys
{% if is_incremental() %}
WHERE link_hk NOT IN (SELECT link_hk FROM {{ this }})
{% endif %}
