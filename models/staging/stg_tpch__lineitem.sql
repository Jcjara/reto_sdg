{{ config(
    schema='staging',
    materialized='view'
) }}

with source as (

    select
        l_orderkey       :: varchar  as order_id,
        l_partkey        :: varchar  as part_id,
        l_suppkey        :: varchar  as supplier_id,
        l_linenumber     :: varchar  as line_number,

        /* synthetic id at line grain for tests/joins */
        (l_orderkey::varchar || '-' || l_linenumber::varchar) as lineitem_id,

        l_quantity       :: number(12,2)  as quantity,
        l_extendedprice  :: number(18,2)  as extended_price,
        l_discount       :: number(5,2)   as discount,
        l_tax            :: number(5,2)   as tax,

        l_returnflag                  as return_flag,
        l_linestatus                  as line_status,
        l_shipdate      :: date       as ship_date,
        l_commitdate    :: date       as commit_date,
        l_receiptdate   :: date       as receipt_date,
        l_shipinstruct               as ship_instruct,
        l_shipmode                   as ship_mode,
        l_comment                    as comment
    from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.LINEITEM

)

select * from source
