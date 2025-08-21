{{ config(
    schema='raw_vault',
    materialized='incremental',
    unique_key='region_hk',
    on_schema_change='sync_all_columns'
) }}

WITH base AS (
    SELECT
        r.region_id AS region_bk
    FROM {{ ref('stg_tpch__region') }} r
),
hkeys AS (
    SELECT
        region_bk,
        {{ hk256(['region_bk']) }} AS region_hk,
        CURRENT_TIMESTAMP()        AS load_dt,
        'stg_tpch__region'         AS record_src
    FROM base
)

SELECT
    region_bk,
    region_hk,
    load_dt,
    record_src
FROM hkeys
{% if is_incremental() %}
WHERE region_hk NOT IN (SELECT region_hk FROM {{ this }})
{% endif %}
