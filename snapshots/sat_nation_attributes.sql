{% snapshot sat_nation_attributes %}
{{
  config(
    unique_key = 'nation_hk',
    strategy   = 'check',
    check_cols = ['nation_name','region_id','comment'],
    invalidate_hard_deletes = True
  )
}}

{{ dv_platform.dv_sat_select(
    src_ref_name = 'stg_tpch__nation',
    hk_cols      = ['nation_id'],
    attrs        = ['nation_name','region_id','comment'],
    hk_name      = 'nation_hk'
) }}

{% endsnapshot %}
