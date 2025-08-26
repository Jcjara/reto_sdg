{{ config(unique_key='link_hk') }}

{{ dv_platform.dv_link(
    src_ref_name='stg_tpch__partsupp',
    keys=[
      {"cols": ["part_id"],     "hk": "part_hk"},
      {"cols": ["supplier_id"], "hk": "supplier_hk"}
    ],
    link_hk_name='link_hk'
) }}
