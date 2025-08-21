{{ config(
    schema='raw_vault',
    materialized='incremental',
    unique_key='link_hk',
    on_schema_change='sync_all_columns'
) }}

WITH base AS (
    SELECT
        c.customer_id AS customer_bk,
        c.nation_id   AS nation_bk
    FROM {{ ref('stg_tpch__customer') }} c
),
keys AS (
    SELECT
        customer_bk,
        nation_bk,
        {{ hk256(['customer_bk']) }} AS customer_hk,
        {{ hk256(['nation_bk']) }}   AS nation_hk,
        {{ hk256(['customer_bk','nation_bk']) }} AS link_hk,
        CURRENT_TIMESTAMP() AS load_dt,
        'stg_tpch__customer' AS record_src
    FROM base
)

SELECT
    link_hk,
    customer_hk,
    nation_hk,
    load_dt,
    record_src
FROM keys
{% if is_incremental() %}
WHERE link_hk NOT IN (SELECT link_hk FROM {{ this }})
{% endif %}
