select table_schema as database_name,
    table_name
from information_schema.tables
where table_type = 'BASE TABLE'
        -- and table_schema = 'shoppingnt' -- enter your database name here
          and upper(table_name) like upper('%func%') 
order by database_name, table_name;

select * from performance_schema.user_defined_functions where upper(udf_name) like upper('%%');

SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE upper(routine_schema) like upper('%sae%')
  -- and ROUTINE_TYPE='FUNCTION'
  order by routine_schema,routine_type,routine_name;