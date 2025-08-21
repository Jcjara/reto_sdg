{{ config(
    schema='raw_vault',
    materialized='incremental',
    unique_key='supplier_hk',
    on_schema_change='sync_all_columns'
) }}

WITH base AS (
    SELECT
        s.supplier_id AS supplier_bk
    FROM {{ ref('stg_tpch__supplier') }} s
),
hkeys AS (
    SELECT
        supplier_bk,
        {{ hk256(['supplier_bk']) }} AS supplier_hk,
        CURRENT_TIMESTAMP()          AS load_dt,
        'stg_tpch__supplier'         AS record_src
    FROM base
)

SELECT
    supplier_bk,
    supplier_hk,
    load_dt,
    record_src
FROM hkeys
{% if is_incremental() %}
WHERE supplier_hk NOT IN (SELECT supplier_hk FROM {{ this }})
{% endif %}
