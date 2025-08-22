{{ config(
    unique_key='customer_hk',
    on_schema_change='sync_all_columns'
) }}

WITH base AS (
    SELECT
        c.customer_id AS customer_bk
    FROM {{ ref('stg_tpch__customer') }} c
),
hkeys AS (
    SELECT
        customer_bk,
        {{ hk256(['customer_bk']) }} AS customer_hk,
        CURRENT_TIMESTAMP()          AS load_dt,
        {{ record_src_const() }}     AS record_src
    FROM base
)

SELECT
    customer_bk,
    customer_hk,
    load_dt,
    record_src
FROM hkeys
{% if is_incremental() %}
WHERE customer_hk NOT IN (SELECT customer_hk FROM {{ this }})
{% endif %}
