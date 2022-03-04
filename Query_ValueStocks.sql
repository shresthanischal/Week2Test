with a as(
select company, fiscal_year,
left(cast(fiscal_year as varchar(10)),4) as start_year,
right(cast(fiscal_year as varchar(10)),4) as end_year,
left(cast(lead(fiscal_year) over (partition by company) as varchar(10)),4) as nxt
from dividend
)

select concat('{',array_to_string(array_agg(concat('"',company,'"')), ','),'}') as Value_Stocks 
from (
select company, count(*) as tally
from a 
where cast(start_year as int)+1=cast(nxt as int)
and end_year = nxt
group by company) as x
where tally>=2




