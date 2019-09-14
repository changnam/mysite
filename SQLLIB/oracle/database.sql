select * from dba_objects;
select * from dba_objects where object_name like upper('%database%') order by owner,object_name;
select name,cdb from v$database order by name;
