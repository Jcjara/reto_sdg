{% snapshot sat_partsupp_attributes %}
{{
  config(
    unique_key = 'link_hk',
    strategy   = 'check',
    check_cols = ['avail_qty','supply_cost','comment'],
    invalidate_hard_deletes = True
  )
}}

{{ dv_platform.dv_sat_select(
    src_ref_name = 'stg_tpch__partsupp',
    hk_cols      = ['part_id','supplier_id'],
    attrs        = ['avail_qty','supply_cost','comment'],
    hk_name      = 'link_hk'
) }}

{% endsnapshot %}
