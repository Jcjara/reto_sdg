{{ config(unique_key='customer_hk') }}

{{ dv_platform.dv_hub(
    src_ref_name='stg_tpch__customer',
    bk_cols=['customer_id'],
    hk_name='customer_hk'
) }}
