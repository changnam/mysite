select * from information_schema.table_constraints where upper(table_schema) = upper('shoppingnt') and upper(table_name) like upper('%pd_tgood%') 
 order by table_schema,table_name,constraint_type;
 
 select concat(fks.constraint_schema, '.', fks.table_name) as foreign_table,
       '->' as rel,
       concat(fks.unique_constraint_schema, '.', fks.referenced_table_name)
              as primary_table,
       kcu.ordinal_position as no,
       kcu.column_name as fk_column_name,
       '=' as 'join',
       kcu.referenced_column_name as pk_column_name,
       fks.constraint_name as fk_constraint_name
from information_schema.referential_constraints fks
join information_schema.key_column_usage kcu
     on fks.constraint_schema = kcu.table_schema
     and fks.table_name = kcu.table_name
     and fks.constraint_name = kcu.constraint_name
where kcu.table_schema not in('information_schema','sys',
                              'mysql', 'performance_schema')
   and fks.constraint_schema = 'shoppingnt'
   -- and upper(fks.constraint_name) = upper('FK_PD_TBRAND_TO_PD_TGOODS')
   and ( upper(fks.table_name) = upper('pd_tgoods') or upper(fks.referenced_table_name) = upper('pd_tgoods'))
order by fks.constraint_schema,
         fks.table_name,
         kcu.ordinal_position;