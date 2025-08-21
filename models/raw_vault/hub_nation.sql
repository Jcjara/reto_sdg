{{ config(
    schema='raw_vault',
    materialized='incremental',
    unique_key='nation_hk',
    on_schema_change='sync_all_columns'
) }}

WITH base AS (
    SELECT
        n.nation_id AS nation_bk
    FROM {{ ref('stg_tpch__nation') }} n
),
hkeys AS (
    SELECT
        nation_bk,
        {{ hk256(['nation_bk']) }} AS nation_hk,
        CURRENT_TIMESTAMP()        AS load_dt,
        'stg_tpch__nation'         AS record_src
    FROM base
)

SELECT
    nation_bk,
    nation_hk,
    load_dt,
    record_src
FROM hkeys
{% if is_incremental() %}
WHERE nation_hk NOT IN (SELECT nation_hk FROM {{ this }})
{% endif %}
