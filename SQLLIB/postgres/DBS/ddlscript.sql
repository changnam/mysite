DROP TABLE FILECONTENTS ;
CREATE TABLE filecontents (id NUMBER,file_path varchar2(512),file_name varchar2(64),file_ext varchar2(32),line_num NUMBER,line_text clob,work_timestamp timestamp, PRIMARY KEY (id));
CREATE sequence files_seq START WITH 1;

DROP TABLE fileencodings;
CREATE TABLE fileencodings (file_path varchar2(512),file_name varchar2(64),line_num NUMBER);

SELECT * FROM filecontents;
SELECT * FROM filecontents ORDER BY file_path,line_num;

SELECT * FROM filecontents WHERE REGEXP_LIKE(LINE_TEXT,'CheckDate')  ORDER BY file_path,line_num;
SELECT * FROM filecontents WHERE REGEXP_LIKE(LINE_TEXT,'[[:space:]]+View[[:space:]]+')  ORDER BY file_path,line_num;
SELECT * FROM filecontents WHERE REGEXP_LIKE(LINE_TEXT,'[[:space:]]+View[[:space:]]+','i')  ORDER BY file_path,line_num; -- ignore case
SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_PATH ,'acct3071form','i')  ORDER BY file_path,line_num;
SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_PATH ,'ACCT3052_22Print\.pas','i')  ORDER BY file_path,line_num;
SELECT file_path,count(*) FROM filecontents WHERE REGEXP_LIKE(FILE_PATH ,'acct3071form','i')  GROUP BY file_path ORDER BY file_path;


SELECT * FROM FILECONTENTS f WHERE REGEXP_LIKE(f.FILE_PATH,'*','i') AND REGEXP_LIKE(LINE_TEXT,'lncr3035','i') ORDER BY file_path,LINE_NUM ; 

DELETE FROM FILECONTENTS f WHERE REGEXP_LIKE(file_path,'acct3071form','i');
DELETE FROM FILECONTENTS f WHERE REGEXP_LIKE(file_path,'백업','i');
DELETE FROM FILECONTENTS f WHERE REGEXP_LIKE(file_path,'bak','i');

TRUNCATE TABLE filecontents;
COMMIT;

SELECT file_path,count(*) FROM filecontents WHERE REGEXP_LIKE(FILE_EXT  ,'pas','i')  GROUP BY file_path ORDER BY file_path; -- 4553개
SELECT file_path,count(*) FROM filecontents WHERE REGEXP_LIKE(FILE_EXT  ,'dfm','i')  GROUP BY file_path ORDER BY file_path; -- 4488개 , 폼없는 pas 존재 가능 (ex, YecaWin.pas, delphi.pas)

SELECT file_path,substr(file_path,0,instr(file_path,'.')-1) FROM FILECONTENTS f WHERE upper(file_name) LIKE upper('%acct3052%');
SELECT substr(file_path,0,instr(file_path,'.')-1), count(*) FROM FILECONTENTS f GROUP BY substr(file_path,0,instr(file_path,'.')-1) HAVING count(*) < 2 ORDER BY 1; -- 
SELECT substr(file_path,0,instr(file_path,'.')-1), file_ext, count(*) FROM FILECONTENTS f WHERE REGEXP_LIKE(FILE_PATH,'yecawin','i') GROUP BY substr(file_path,0,instr(file_path,'.')-1),FILE_EXT  ORDER BY 1;  
CREATE TABLE filecontents_group AS 
SELECT substr(file_path,0,instr(file_path,'.')-1) file_path, file_ext, count(*) line_cnt FROM FILECONTENTS f GROUP BY substr(file_path,0,instr(file_path,'.')-1),FILE_EXT ; 

SELECT file_path,count(*) FROM filecontents_group GROUP BY file_path HAVING count(*) < 2 ORDER BY 1;

UPDATE FILECONTENTS SET FILE_EXT = substr(file_name,instr(file_name,'.',-1)+1) ;
SELECT file_name,substr(file_name,instr(file_name,'.',-1)+1) FROM FILECONTENTS f WHERE upper(file_name) LIKE upper('%acct3052%');
SELECT * FROM fileencodings;

create tablespace ts_inf datafile 'C:\oraclexe\app\oracle\oradata\XE\tsinf.dbf' size 1024M  EXTENT MANAGEMENT LOCAL AUTOALLOCATE;
SELECT * FROM dba_data_files;
ALTER DATABASE DATAFILE 5 autoextend ON NEXT 1024M ;

ALTER DATABASE DATAFILE 'C:\ORACLEXE\APP\ORACLE\ORADATA\XE\UNDOTBS1.DBF' resize 2048M;

select * from dba_data_files;
drop user bo_owner cascade;
create user bo_owner identified by bo_owner;
grant dba to bo_owner;
ALTER USER cddba1 DEFAULT TABLESPACE ts_inf;

CREATE TABLE d7_prop (name varchar2(64), val varchar2(512));
CREATE TABLE d7_method (name varchar2(64),val varchar2(512),scr varchar2(512));
CREATE TABLE d7_ibos (name varchar2(64),ctype varchar2(64),cfunc varchar2(512));
CREATE TABLE d7_control (name varchar2(64),ctype varchar2(64),scr varchar2(512),cdesc varchar2(512),xframe varchar2(512));
CREATE TABLE d7_event (name varchar2(64),ctype varchar2(64),cevent varchar2(512));
