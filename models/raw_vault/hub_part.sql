{{ config(unique_key='part_hk') }}

{{ dv_platform.dv_hub(
    src_ref_name='stg_tpch__part',
    bk_cols=['part_id'],
    hk_name='part_hk'
) }}
