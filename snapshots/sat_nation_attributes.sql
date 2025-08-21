-- snapshots/sat_nation_attributes.sql

{% snapshot sat_nation_attributes %}
{{
    config(
        target_schema='RAW_VAULT',
        unique_key='NATION_HK',
        strategy='check',
        check_cols=['NATION_NAME', 'REGION_ID'],
        invalidate_hard_deletes=True
    )
}}

SELECT
    {{ hk256(['N.NATION_ID']) }}   AS NATION_HK,
    N.NATION_NAME,
    N.REGION_ID,
    'STG_TPCH__NATION'             AS RECORD_SRC
FROM {{ ref('stg_tpch__nation') }} N

{% endsnapshot %}
