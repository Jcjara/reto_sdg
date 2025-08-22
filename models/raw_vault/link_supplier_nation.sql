{{ config(
    unique_key='link_hk',
    on_schema_change='sync_all_columns'
) }}

WITH base AS (
    SELECT
        s.supplier_id AS supplier_bk,
        s.nation_id   AS nation_bk
    FROM {{ ref('stg_tpch__supplier') }} s
),
keys AS (
    SELECT
        supplier_bk,
        nation_bk,
        {{ hk256(['supplier_bk']) }}             AS supplier_hk,
        {{ hk256(['nation_bk']) }}               AS nation_hk,
        {{ hk256(['supplier_bk','nation_bk']) }} AS link_hk,
        CURRENT_TIMESTAMP()                      AS load_dt,
        {{ record_src_const() }}                 AS record_src
    FROM base
)

SELECT
    link_hk,
    supplier_hk,
    nation_hk,
    load_dt,
    record_src
FROM keys
{% if is_incremental() %}
WHERE link_hk NOT IN (SELECT link_hk FROM {{ this }})
{% endif %}
