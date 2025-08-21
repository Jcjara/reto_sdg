{{ config(
    schema='raw_vault',
    materialized='incremental',
    unique_key='link_hk',
    on_schema_change='sync_all_columns'
) }}

WITH base AS (
    SELECT
        o.order_id    AS order_bk,
        o.customer_id AS customer_bk
    FROM {{ ref('stg_tpch__orders') }} o
),
keys AS (
    SELECT
        order_bk,
        customer_bk,
        {{ hk256(['order_bk']) }}    AS order_hk,
        {{ hk256(['customer_bk']) }} AS customer_hk,
        {{ hk256(['order_bk','customer_bk']) }} AS link_hk,
        CURRENT_TIMESTAMP() AS load_dt,
        'stg_tpch__orders'  AS record_src
    FROM base
)

SELECT
    link_hk,
    order_hk,
    customer_hk,
    load_dt,
    record_src
FROM keys
{% if is_incremental() %}
WHERE link_hk NOT IN (SELECT link_hk FROM {{ this }})
{% endif %}
