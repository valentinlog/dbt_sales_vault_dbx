{{ config(materialized='incremental') }}

{{ automate_dv.hub(
    src_pk='hub_country_hk',
    src_nk='country_id',
    src_ldts='load_dts',
    src_source='record_source',
    source_model='stage_customers'
) }}
