{{ config(materialized='table') }}

with latest_customer as (
    select *
    from {{ ref('pit_customer') }}
),

hub as (
    select
        hub_customer_hk,
        customer_id
    from {{ ref('hub_customer') }}
),

customer_enriched as (
    select
        h.customer_id,
        sc.name as customer_name,
        sc.address,
        sc.phone,
        sc.account_balance,
        sc.marketing_segment,
        co.name as country_name
    from latest_customer lc
    join hub h 
        on lc.hub_customer_hk = h.hub_customer_hk
    left join {{ ref('sat_customer') }} sc
        on lc.hub_customer_hk = sc.hub_customer_hk
    left join {{ ref('link_customer_country') }} lcc
        on h.hub_customer_hk = lcc.hub_customer_hk
    left join {{ ref('sat_country') }} co
        on lcc.hub_country_hk = co.hub_country_hk
)

select *
from customer_enriched
