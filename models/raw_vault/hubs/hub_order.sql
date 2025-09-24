{{ config(materialized='incremental') }}

{{ automate_dv.hub(
    src_pk='hub_order_hk',
    src_nk='order_id',
    src_ldts='load_dts',
    src_source='record_source',
    source_model='stage_orders'
) }}