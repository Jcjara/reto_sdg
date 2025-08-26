{{ config(unique_key='nation_hk') }}

{{ dv_platform.dv_hub(
    src_ref_name='stg_tpch__nation',
    bk_cols=['nation_id'],
    hk_name='nation_hk'
) }}
