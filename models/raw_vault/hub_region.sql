{{ config(unique_key='region_hk') }}

{{ dv_platform.dv_hub(
    src_ref_name='stg_tpch__region',
    bk_cols=['region_id'],
    hk_name='region_hk'
) }}
