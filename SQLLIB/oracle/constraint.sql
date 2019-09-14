select * from dba_constraints;
select * from dba_constraints where upper(owner) in ('CDDBA1');
select 'alter table '||owner||'.'||table_name||' disable constraint '||constraint_name||';'
  from dba_constraints where upper(owner) in ('CDDBA1');
select 'alter table '||owner||'.'||table_name||' disable constraint '||constraint_name||';'
  from dba_constraints where r_constraint_name is not null order by owner,table_name,constraint_name;
