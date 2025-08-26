{{ config(unique_key='link_hk') }}

{{ dv_platform.dv_link(
    src_ref_name='stg_tpch__orders',
    keys=[
      {"cols": ["order_id"], "hk": "order_hk"},
      {"cols": ["customer_id"], "hk": "customer_hk"}
    ],
    link_hk_name='link_hk'
) }}
