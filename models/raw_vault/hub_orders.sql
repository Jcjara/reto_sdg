{{ config(unique_key='order_hk') }}

{{ dv_platform.dv_hub(
    src_ref_name='stg_tpch__orders',
    bk_cols=['order_id'],
    hk_name='order_hk'
) }}
