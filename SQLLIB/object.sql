select * from dba_objects where owner = upper('c##shop1');
select * from dba_users order by username;

drop user c##shop1 cascade;