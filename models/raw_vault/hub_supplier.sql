{{ config(unique_key='supplier_hk') }}

{{ dv_platform.dv_hub(
    src_ref_name='stg_tpch__supplier',
    bk_cols=['supplier_id'],
    hk_name='supplier_hk'
) }}
