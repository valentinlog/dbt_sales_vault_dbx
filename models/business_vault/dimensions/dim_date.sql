{{ config(materialized='table') }}

with base as (
    select distinct
        cast(order_date as date) as date_day
    from {{ ref('sat_order') }}
    where order_date is not null
),

dates as (
    select
        date_day,
        year(date_day) as year,
        month(date_day) as month,
        day(date_day) as day,
        quarter(date_day) as quarter,
        dayofweek(date_day) as day_of_week,   -- 1 = Sunday … 7 = Saturday
        date_format(date_day, 'MMMM') as month_name,
        date_format(date_day, 'EEEE') as day_name
    from base
)

select *
from dates
