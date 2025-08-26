{% snapshot sat_part_attributes %}
{{
  config(
    unique_key = 'part_hk',
    strategy   = 'check',
    check_cols = ['part_name','mfgr','brand','part_type','size','container','retail_price','comment'],
    invalidate_hard_deletes = True
  )
}}

{{ dv_platform.dv_sat_select(
    src_ref_name = 'stg_tpch__part',
    hk_cols      = ['part_id'],
    attrs        = ['part_name','mfgr','brand','part_type','size','container','retail_price','comment'],
    hk_name      = 'part_hk'
) }}

{% endsnapshot %}
