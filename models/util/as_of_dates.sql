{{ config(
    materialized='table'
) }}

-- generate a calendar table of dates
with calendar as (

    select
        sequence(
            to_date('1980-01-01'),          -- 📌 start date (adjust for your business)
            current_date,
            interval 1 day
        ) as date_array

),

exploded as (
    select explode(date_array) as as_of_date
    from calendar
)

select
    as_of_date,
    current_timestamp() as load_ts,
    'as_of_dates' as record_source
from exploded
