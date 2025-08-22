{{ config(
    unique_key='order_hk',
    on_schema_change='sync_all_columns'
) }}

WITH base AS (
    SELECT
        o.order_id AS order_bk
    FROM {{ ref('stg_tpch__orders') }} o
),
hkeys AS (
    SELECT
        order_bk,
        {{ hk256(['order_bk']) }}  AS order_hk,
        CURRENT_TIMESTAMP()        AS load_dt,
        {{ record_src_const() }}   AS record_src
    FROM base
)

SELECT
    order_bk,
    order_hk,
    load_dt,
    record_src
FROM hkeys
{% if is_incremental() %}
WHERE order_hk NOT IN (SELECT order_hk FROM {{ this }})
{% endif %}
