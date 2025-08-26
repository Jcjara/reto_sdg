{% snapshot sat_region_attributes %}
{{
  config(
    unique_key = 'region_hk',
    strategy   = 'check',
    check_cols = ['region_name','comment'],
    invalidate_hard_deletes = True
  )
}}

{{ dv_platform.dv_sat_select(
    src_ref_name = 'stg_tpch__region',
    hk_cols      = ['region_id'],
    attrs        = ['region_name','comment'],
    hk_name      = 'region_hk'
) }}

{% endsnapshot %}
