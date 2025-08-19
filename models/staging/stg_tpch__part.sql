{{ config(
    schema='staging',
    materialized='view'
) }}

with source as (

    select
        p_partkey       :: varchar        as part_id,
        p_name                          as part_name,
        p_mfgr                          as manufacturer,
        p_brand                         as brand,
        p_type                          as part_type,
        p_size          :: number        as size,
        p_container                    as container,
        p_retailprice   :: number(18,2)  as retail_price,
        p_comment                      as comment
    from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.PART

)

select * from source
