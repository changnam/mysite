select * from NLS_DATABASE_PARAMETERS where parameter like upper('%%') order by parameter;
select * from v$parameter where upper(name) like upper('%plug%') order by name;
select * from v$parameter where upper(name) like upper('%%') order by name;