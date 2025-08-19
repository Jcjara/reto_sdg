{{ config(
    schema='staging',
    materialized='view'
) }}

with source as (

    select
        o_orderkey      :: varchar  as order_id,
        o_custkey       :: varchar  as customer_id,
        o_orderstatus               as order_status,
        o_totalprice    :: number   as total_price,
        o_orderdate     :: date     as order_date,
        o_orderpriority             as order_priority,
        o_clerk                    as clerk,
        o_shippriority :: number    as ship_priority,
        o_comment                  as comment
    from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS

)

select * from source
