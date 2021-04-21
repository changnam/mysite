create tablespace ts_inf_idx datafile 'd:\app\oradata\tsinfidx.dbf' size 1024M  EXTENT MANAGEMENT LOCAL AUTOALLOCATE;
select * from dba_data_files;
drop user bo_owner cascade;
create user bo_owner identified by bo_owner;
grant dba to bo_owner;