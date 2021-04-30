select * from dba_constraints;
select * from dba_constraints where upper(owner) in ('BO_OWNER');
select * from dba_constraints where upper(owner) in ('BO_OWNER') AND  constraint_type NOT in ('C','P');
select 'alter table '||owner||'.'||table_name||' disable constraint '||constraint_name||';'
  from dba_constraints where upper(owner) in ('BO_OWNER');
select 'alter table '||owner||'.'||table_name||' disable constraint '||constraint_name||';'
  from dba_constraints where r_constraint_name is not null order by owner,table_name,constraint_name;
 
 SELECT  * FROM dba_objects WHERE object_name LIKE upper('dba%constrain%');

SELECT DISTINCT constraint_type FROM dba_constraints;
SELECT * FROM dba_constraints WHERE owner IN ('BO_OWNER') AND constraint_type = 'R' ORDER BY owner,TABLE_name;
