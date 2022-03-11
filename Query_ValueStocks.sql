with a as (
select company,
lag(fiscal_year) over (partition by company) as prev,
fiscal_year,
lead(fiscal_year) over (partition by company) as nxt
from dividend)

select concat('{',array_to_string(array_agg(concat('"',company,'"')), ','),'}') as Value_Stocks
from a
where fiscal_year-prev = nxt-fiscal_year



