{% snapshot sat_region_attributes %}
{{
    config(
        target_schema='raw_vault',
        unique_key='region_hk',
        strategy='check',
        check_cols=['region_name'],
        invalidate_hard_deletes=True
    )
}}

SELECT
    {{ hk256(['r.region_id']) }} AS region_hk,
    r.region_name,
    'stg_tpch__region' AS record_src
FROM {{ ref('stg_tpch__region') }} r

{% endsnapshot %}
