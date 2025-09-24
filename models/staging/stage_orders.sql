{%- set yaml_metadata -%}
source_model: 'orders'
derived_columns:
  record_source: '!seed_orders'
  load_dts: current_timestamp()
hashed_columns:
  hub_order_hk: 'order_id'
  hub_customer_hk: 'customer_id'
  link_customer_order_hk: 
    - 'order_id'
    - 'customer_id'
  hash_diff:
    - 'order_status'
    - 'total_price'
    - 'order_date'
    - 'order_priority'
    - 'clerk'
    - 'ship_priority'
    - 'comment'
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