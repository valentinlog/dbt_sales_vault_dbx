{%- set yaml_metadata -%}
source_model: 'orders'
derived_columns:
  record_source: '!seed_order_items'
  load_dts: current_timestamp()
hashed_columns:
   hub_order_item_hk: 'id'
   hub_order_hk: 'id'  
   hub_product_hk: 'product_id'
   link_product_order_item_hk: 
    - 'id'
    - 'product_id'
   hash_diff:
    - 'quantity'
    - 'unit_price'
{%- endset -%}
{% set metadata_dict = fromyaml(yaml_metadata) %}
{% set source_model = metadata_dict['source_model'] %}
{% set derived_columns = metadata_dict['derived_columns'] %}
{% set hashed_columns = metadata_dict['hashed_columns'] %}
{{ automate_dv.stage(
    include_source_columns=true,
    source_model=source_model,
    derived_columns=derived_columns,
    hashed_columns=hashed_columns,
    ranked_columns=none
) }}