select * from dba_data_files;

select * from dba_tablespaces;

alter tablespace sysaux offline normal;
ALTER TABLESPACE sysaux
    RENAME DATAFILE 'C:\APP\ERIC\ORADATA\JERRY\SYSAUX01.DBF'
                 TO 'D:\ORADATA\JERRY\SYSAUX01.DBF';
alter tablespace sysaux online;

-- down ���¿��� ������ �̵��� ��� ���� ��� (���� missing ���� open�� �ȵǰ�, mount ������)
ALTER DATABASE RENAME FILE 'D:\ORADATA\SYSAUX01.DBF' TO 'E:\ORADATA\SYSAUX01.DBF';


