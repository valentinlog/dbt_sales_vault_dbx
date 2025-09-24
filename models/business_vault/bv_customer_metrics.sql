{{ config(materialized='table') }}

with customer_hub as (
    select
        hub_customer_hk,
        customer_id
    from {{ ref('hub_customer') }}
),

orders as (
    select
        lco.hub_customer_hk,
        so.order_date,
        so.total_price
    from {{ ref('link_customer_order') }} lco
    join {{ ref('sat_order') }} so
        on lco.hub_order_hk = so.hub_order_hk
),

aggregated as (
    select
        ch.customer_id,
        count(distinct o.order_date) as total_orders,
        sum(o.total_price) as total_revenue,
        avg(o.total_price) as avg_order_value,
        max(o.order_date) as last_order_date
    from customer_hub ch
    left join orders o
        on ch.hub_customer_hk = o.hub_customer_hk
    group by ch.customer_id
)

select
    customer_id,
    total_orders,
    total_revenue,
    avg_order_value,
    last_order_date,
    current_timestamp() as load_dts
from aggregated
