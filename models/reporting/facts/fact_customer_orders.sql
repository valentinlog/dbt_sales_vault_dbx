{{ config(materialized='table') }}

with customer_hub as (
    select
        hub_customer_hk,
        customer_id
    from {{ ref('hub_customer') }}
),

order_hub as (
    select
        hub_order_hk,
        order_id
    from {{ ref('hub_order') }}
),

orders as (
    select
        lco.hub_customer_hk,
        lco.hub_order_hk,
        so.order_date,
        so.total_price,
        so.order_status,
        so.order_priority,
        so.clerk,
        so.ship_priority
    from {{ ref('link_customer_order') }} lco
    join {{ ref('sat_order') }} so
        on lco.hub_order_hk = so.hub_order_hk
),

fact as (
    select
        ch.customer_id,
        oh.order_id,
        cast(o.order_date as date) as order_date,
        year(o.order_date) * 10000 + month(o.order_date) * 100 + day(o.order_date) as date_key, -- surrogate date key
        o.total_price,
        o.order_status,
        o.order_priority,
        o.clerk,
        o.ship_priority
    from orders o
    join customer_hub ch
        on o.hub_customer_hk = ch.hub_customer_hk
    join order_hub oh
        on o.hub_order_hk = oh.hub_order_hk
)

select *
from fact
