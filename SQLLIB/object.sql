select * from dba_objects where owner = upper('c##shop1');
select * from dba_objects where object_name like upper('%database%parameter%') order by owner,object_name;
select * from dba_objects where object_name like upper('%%parameter%') order by owner,object_name;
select * from dba_users order by username;

select * from NLS_DATABASE_PARAMETERS where parameter like upper('%%') order by parameter;
select * from v$parameter where upper(name) like upper('%plug%') order by name;

drop user c##shop1 cascade;