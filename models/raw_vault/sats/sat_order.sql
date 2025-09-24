{{ config(materialized='incremental') }}

{%- set source_model = "stage_orders" -%}
{%- set src_pk = "hub_order_hk" -%}
{%- set src_hashdiff = "hash_diff" -%}
{%- set src_payload = ["order_status","total_price","order_date","order_priority","clerk","ship_priority","comment"] -%}
{%- set src_eff = "load_dts" -%}
{%- set src_ldts = "load_dts" -%}
{%- set src_source = "record_source" -%}

{{ automate_dv.sat(src_pk=src_pk, src_hashdiff=src_hashdiff,
                   src_payload=src_payload, src_eff=src_eff,
                   src_ldts=src_ldts, src_source=src_source,
                   source_model=source_model) }}