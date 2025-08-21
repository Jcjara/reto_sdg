{{ config(
    schema='raw_vault',
    materialized='incremental',
    unique_key='link_hk',
    on_schema_change='sync_all_columns'
) }}

WITH base AS (
    SELECT
        ps.part_id     AS part_bk,
        ps.supplier_id AS supplier_bk
    FROM {{ ref('stg_tpch__partsupp') }} ps
),
keys AS (
    SELECT
        part_bk,
        supplier_bk,
        {{ hk256(['part_bk']) }}     AS part_hk,
        {{ hk256(['supplier_bk']) }} AS supplier_hk,
        {{ hk256(['part_bk','supplier_bk']) }} AS link_hk,
        CURRENT_TIMESTAMP() AS load_dt,
        'stg_tpch__partsupp' AS record_src
    FROM base
)

SELECT
    link_hk,
    part_hk,
    supplier_hk,
    load_dt,
    record_src
FROM keys
{% if is_incremental() %}
WHERE link_hk NOT IN (SELECT link_hk FROM {{ this }})
{% endif %}
