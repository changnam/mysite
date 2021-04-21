select * from dba_objects where upper(object_name) like upper('%database%') and object_type not in ('SYNONYM','JAVA CLASS','INDEX') order by owner,object_name;
select * from dba_objects where upper(object_name) like upper('%parameter%') and object_type in ('TABLE','VIEW') order by owner,object_name;

select * from nls_database_parameters order by parameter;
