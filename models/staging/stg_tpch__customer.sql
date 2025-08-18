{{ config(
    schema='staging',
    materialized='view'
) }}

with source as (

    select
        c_custkey     as customer_id,
        c_name        as customer_name,
        c_address     as address,
        c_nationkey   as nation_id,
        c_phone       as phone,
        c_acctbal     as account_balance,
        c_mktsegment  as market_segment,
        c_comment     as comment
    from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER

)

select * from source