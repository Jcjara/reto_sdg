{{ config(
    unique_key = 'link_hk'
) }}

{{ dv_platform.dv_link(
    src_ref_name = 'stg_tpch__lineitem',
    keys = [
      {"cols": ["order_id"],    "hk": "order_hk"},
      {"cols": ["part_id"],     "hk": "part_hk"},
      {"cols": ["supplier_id"], "hk": "supplier_hk"},
      {"cols": ["line_number"]}
    ],
    link_hk_name = 'link_hk'
) }}
