{{ config(
    unique_key='link_hk',
    on_schema_change='sync_all_columns'
) }}

WITH base AS (
    SELECT
        n.nation_id AS nation_bk,
        n.region_id AS region_bk
    FROM {{ ref('stg_tpch__nation') }} n
),
keys AS (
    SELECT
        nation_bk,
        region_bk,
        {{ hk256(['nation_bk']) }}             AS nation_hk,
        {{ hk256(['region_bk']) }}             AS region_hk,
        {{ hk256(['nation_bk','region_bk']) }} AS link_hk,
        CURRENT_TIMESTAMP()                    AS load_dt,
        {{ record_src_const() }}               AS record_src
    FROM base
)

SELECT
    link_hk,
    nation_hk,
    region_hk,
    load_dt,
    record_src
FROM keys
{% if is_incremental() %}
WHERE link_hk NOT IN (SELECT link_hk FROM {{ this }})
{% endif %}
