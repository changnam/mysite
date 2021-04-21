select table_name,column_name from information_schema.columns
where table_schema = 'shoppingnt' and upper(table_name)  = upper('pd_tgoods')
order by table_name,ordinal_position;

select * from 
(select table_schema,table_name
from information_schema.tables
where table_schema = 'shoppingnt'
  and table_type = 'BASE TABLE' ) as ta 
	right outer join 
(select table_schema,table_name
from information_schema.tables
where table_schema = 'saeki'
  and table_type = 'BASE TABLE') as tb
  on ta.table_name = tb.table_name
where ta.table_name is not null
order by ta.table_schema, ta.table_name;

select distinct table_type from information_schema.tables where table_type = 'BASE TABLE' ;