{{ config(materialized='incremental') }}

{%- set source_model = "stage_customer" -%}
{%- set src_pk = "link_customer_country_hk" -%}
{%- set src_fk = ["hub_customer_hk", "hub_country_hk"] -%}
{%- set src_ldts = "load_dts" -%}
{%- set src_source = "record_source" -%}

{{ automate_dv.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                    src_source=src_source, source_model=source_model) }}