select * from dba_data_files;

select * from dba_tablespaces;

alter tablespace sysaux offline normal;
ALTER TABLESPACE sysaux
    RENAME DATAFILE 'C:\APP\ERIC\ORADATA\JERRY\SYSAUX01.DBF'
                 TO 'D:\ORADATA\JERRY\SYSAUX01.DBF';
alter tablespace sysaux online;

-- down ���¿��� ������ �̵��� ��� ���� ��� (���� missing ���� open�� �ȵǰ�, mount ������)
ALTER DATABASE RENAME FILE 'D:\ORADATA\SYSAUX01.DBF' TO 'E:\ORADATA\SYSAUX01.DBF';

-- SYSTEM TABLESPACE �̵����
ALTER DATABASE BACKUP CONTROLFILE TO TRACE;
SHUTDOWN IMMEDIATE;
COPY SYSTEM DATA FILE TO OTHER LOCATION;
EDIT CONTROL FILE CREATE SCRIPT;

STARTUP NOMOUNT
CREATE CONTROLFILE REUSE DATABASE "JERRY" NORESETLOGS  NOARCHIVELOG
    MAXLOGFILES 16
    MAXLOGMEMBERS 3
    MAXDATAFILES 100
    MAXINSTANCES 8
    MAXLOGHISTORY 292
LOGFILE
  GROUP 1 'C:\APP\ERIC\ORADATA\JERRY\REDO01.LOG'  SIZE 50M BLOCKSIZE 512,
  GROUP 2 'C:\APP\ERIC\ORADATA\JERRY\REDO02.LOG'  SIZE 50M BLOCKSIZE 512,
  GROUP 3 'C:\APP\ERIC\ORADATA\JERRY\REDO03.LOG'  SIZE 50M BLOCKSIZE 512
-- STANDBY LOGFILE
DATAFILE
  'E:\ORADATA\JERRY\SYSTEM01.DBF',
  'E:\ORADATA\JERRY\SYSAUX01.DBF',
  'E:\ORADATA\JERRY\UNDOTBS01.DBF',
  'E:\ORADATA\JERRY\USERS01.DBF',
  'E:\ORADATA\JERRY\EXAMPLE01.DBF'
CHARACTER SET KO16MSWIN949
;
-- Commands to re-create incarnation table
-- Below log names MUST be changed to existing filenames on
-- disk. Any one log file from each branch can be used to
-- re-create incarnation records.
-- ALTER DATABASE REGISTER LOGFILE 'C:\APP\ERIC\FLASH_RECOVERY_AREA\JERRY\ARCHIVELOG\2018_12_17\O1_MF_1_1_%U_.ARC';
-- ALTER DATABASE REGISTER LOGFILE 'C:\APP\ERIC\FLASH_RECOVERY_AREA\JERRY\ARCHIVELOG\2018_12_17\O1_MF_1_1_%U_.ARC';
-- Recovery is required if any of the datafiles are restored backups,
-- or if the last shutdown was not normal or immediate.
RECOVER DATABASE
-- Database can now be opened normally.
ALTER DATABASE OPEN;
-- Commands to add tempfiles to temporary tablespaces.
-- Online tempfiles have complete space information.
-- Other tempfiles may require adjustment.
ALTER TABLESPACE TEMP ADD TEMPFILE 'E:\ORADATA\JERRY\TEMP01.DBF'
     SIZE 30408704  REUSE AUTOEXTEND ON NEXT 655360  MAXSIZE 32767M;


