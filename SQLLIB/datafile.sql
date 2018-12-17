select * from dba_data_files;

select * from dba_tablespaces;

alter tablespace sysaux offline normal;
ALTER TABLESPACE sysaux
    RENAME DATAFILE 'C:\APP\ERIC\ORADATA\JERRY\SYSAUX01.DBF'
                 TO 'D:\ORADATA\JERRY\SYSAUX01.DBF';
alter tablespace sysaux online;

-- down 상태에서 파일이 이동된 경우 변경 방법 (파일 missing 으로 open이 안되고, mount 상태임)
ALTER DATABASE RENAME FILE 'D:\ORADATA\SYSAUX01.DBF' TO 'E:\ORADATA\SYSAUX01.DBF';


