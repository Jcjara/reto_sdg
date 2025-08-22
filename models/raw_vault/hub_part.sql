{{ config(
    unique_key='part_hk',
    on_schema_change='sync_all_columns'
) }}

WITH base AS (
    SELECT
        p.part_id AS part_bk
    FROM {{ ref('stg_tpch__part') }} p
),
hkeys AS (
    SELECT
        part_bk,
        {{ hk256(['part_bk']) }}   AS part_hk,
        CURRENT_TIMESTAMP()        AS load_dt,
        {{ record_src_const() }}   AS record_src
    FROM base
)

SELECT
    part_bk,
    part_hk,
    load_dt,
    record_src
FROM hkeys
{% if is_incremental() %}
WHERE part_hk NOT IN (SELECT part_hk FROM {{ this }})
{% endif %}
