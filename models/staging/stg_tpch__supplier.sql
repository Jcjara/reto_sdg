{{ config(
    schema='staging',
    materialized='view'
) }}

with source as (

    select
        s_suppkey      :: varchar        as supplier_id,
        s_name                          as supplier_name,
        s_address                       as address,
        s_nationkey    :: varchar        as nation_id,
        s_phone                         as phone,
        s_acctbal      :: number(18,2)   as account_balance,
        s_comment                       as comment
    from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.SUPPLIER

)

select * from source
