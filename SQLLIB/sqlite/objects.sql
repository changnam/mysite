select * from sqlite_master where upper(tbl_name) like upper('%product%');
select * from sqlite_master where type in ('index') order by tbl_name,name;
select * from sqlite_master where type = 'table' order by tbl_name;
select * from sqlite_sequence;