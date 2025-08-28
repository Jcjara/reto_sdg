SELECT
  {{ auto_staging_select(
       'SNOWFLAKE_SAMPLE_DATA',     
       'TPCH_SF1',                
       'LINEITEM'                 
  ) }}
FROM {{ source('tpch','lineitem') }}
