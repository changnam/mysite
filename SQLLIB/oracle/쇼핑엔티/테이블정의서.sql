CREATE TABLE "CDDBA1"."MYSQL_TABLES" 
   (	workdate varchar2(8) not null,
   "TABLE_CATALOG" VARCHAR2(64) NOT NULL ENABLE, 
	"TABLE_SCHEMA" VARCHAR2(64) NOT NULL ENABLE, 
	"TABLE_NAME" VARCHAR2(64) NOT NULL ENABLE, 
	"TABLE_TYPE" VARCHAR2(64) NOT NULL ENABLE, 
	"ENGINE" VARCHAR2(64), 
	"VERSION" NUMBER(10,0), 
	"ROW_FORMAT" VARCHAR2(64) NOT NULL ENABLE, 
	"TABLE_ROWS" NUMBER(20,0), 
	"AVG_ROW_LENGTH" NUMBER(20,0), 
	"DATA_LENGTH" NUMBER(20,0), 
	"MAX_DATA_LENGTH" NUMBER(20,0), 
	"INDEX_LENGTH" NUMBER(20,0), 
	"DATA_FREE" NUMBER(20,0), 
	"AUTO_INCREMENT" NUMBER(20,0), 
	"CREATE_TIME" TIMESTAMP (6) DEFAULT current_timestamp NOT NULL ENABLE, 
	"UPDATE_TIME" DATE, 
	"CHECK_TIME" DATE, 
	"TABLE_COLLATION" VARCHAR2(64), 
	"CHECKSUM" NUMBER(20,0), 
	"CREATE_OPTIONS" VARCHAR2(64), 
	"TABLE_COMMENT" CLOB,
	worktime date default sysdate,
	primary key (workdate,table_schema,table_name)
   ) ;
 
CREATE TABLE dba_tables_0422 AS SELECT * FROM dba_tables WHERE owner = 'BO_OWNER';
CREATE TABLE dba_tab_columns_0422 AS SELECT * FROM dba_tab_columns WHERE owner=  'BO_OWNER';


CREATE TABLE sa (saname varchar2(64), sadesc varchar2(64));
INSERT INTO sa VALUES ('CM','����');
INSERT INTO sa VALUES ('PD','��ǰ');
INSERT INTO sa VALUES ('VD','��ü');
INSERT INTO sa VALUES ('MK','���θ��');
INSERT INTO sa VALUES ('DP','����');
INSERT INTO sa VALUES ('SCM','SCM');
INSERT INTO sa VALUES ('SA','����');
INSERT INTO sa VALUES ('SY','�ý���');
COMMIT;
UPDATE sa SET saname = 'SC' WHERE saname = 'SCM';
DROP TABLE table_work;
CREATE TABLE table_work (
  workdate varchar2(8) , 
  sa varchar2(64), 
  owner varchar2(64) ,
  table_name varchar2(64) , 
  entity_name varchar2(64) , 
  table_desc varchar2(4000) ,
  worktime DATE DEFAULT sysdate,
PRIMARY KEY (workdate,owner,table_name));

DROP TABLE table_def;
CREATE TABLE table_def (
  flag varchar2(1) , 
  sa varchar2(64), 
  owner varchar2(64) ,
  table_name varchar2(64) , 
  entity_name varchar2(64) , 
  table_desc varchar2(4000) ,
  updtime DATE DEFAULT sysdate,
PRIMARY KEY (owner,table_name));

CREATE TABLE table_def (
  flag varchar2(1) , 
  sa varchar2(64), 
  owner varchar2(64) ,
  table_name varchar2(64) , 
  entity_name varchar2(64) , 
  table_desc varchar2(4000) ,
  updtime DATE DEFAULT sysdate,
PRIMARY KEY (owner,table_name));

 COMMENT ON COLUMN table_def.flag IS 'Y: ���';
 COMMENT ON COLUMN table_def.sa IS '��������';
COMMENT ON COLUMN table_def.owner IS '����';
COMMENT ON COLUMN table_def.table_name IS '���̺��';
COMMENT ON COLUMN table_def.entity_name IS '��ƼƼ��';
COMMENT ON COLUMN table_def.TABLE_desc IS '���̺���';

CREATE TABLE table_def_history (
  flag varchar2(1) , 
  sa varchar2(64), 
  owner varchar2(64) ,
  table_name varchar2(64) , 
  entity_name varchar2(64) , 
  table_desc varchar2(4000) ,
  updtime DATE DEFAULT sysdate,
  seq NUMBER,
PRIMARY KEY (owner,table_name,seq));

INSERT INTO table_work (workdate,sa,owner,table_name,entity_name,table_desc)
SELECT to_char(sysdate,'YYYYMMDD'),b.sadesc ��������,table_schema ����,table_name ���̺��, table_comment ��ƼƼ��,'' ���̺���  FROM mysql_tables a LEFT OUTER JOIN sa b ON substr(a.table_name,1,2) = b.saname 
WHERE a.table_name NOT LIKE 'IF%' AND a.TABLE_NAME  NOT LIKE 'BATCH%' AND table_name NOT LIKE 'QRTZ%' AND table_name NOT LIKE '%_BK' AND table_name NOT LIKE '%_BKUP'
ORDER BY a.table_name;

COMMIT;
SELECT * FROM table_work ORDER BY workdate,owner,table_name;

SELECT * FROM table_work a FULL OUTER JOIN table_def b ON a.owner = b.owner AND a.table_name = b.table_name 
WHERE a.table_name IS NULL OR b.table_name IS NULL 
ORDER BY a.workdate,a.owner,a.table_name;

SELECT sa,owner,table_name,entity_name,table_desc FROM table_def WHERE flag = 'Y' ORDER BY table_name;

--TRUNCATE TABLE MYSQL_TABLES ;
--ALTER TABLE mysql_tables MODIFY (worktime DATE DEFAULT sysdate  NOT NULL);
--DELETE FROM mysql_tables WHERE workdate = to_char(sysdate,'YYYYMMDD');
--ROLLBACK;
--COMMIT;

SELECT * FROM mysql_tables WHERE workdate = to_char(sysdate,'YYYYMMDD') ORDER BY table_name;
SELECT * FROM MYSQL_COLUMNS WHERE workdate = to_char(sysdate,'YYYYMMDD') ORDER BY table_name,ORDINAL_POSITION ;
--TRUNCATE TABLE mysql_columns;

SELECT  * FROM MIGTARGET WHERE table_name LIKE '%TCATEGORY%';
SELECT * FROM bocnt WHERE workdate = to_char(sysdate,'YYYYMMDD') ORDER BY cnt desc;
-- ���̱� ��� ���̺� �Ǽ� Ȯ��
SELECT * FROM MIGTARGET m2 LEFT OUTER JOIN BOCNT b2 ON m2.table_name = b2.TABLE_NAME WHERE (m2.flag IS NULL OR m2.flag <> 'N' ) AND b2.workdate = to_char(sysdate,'YYYYMMDD')
ORDER BY m2.table_name;

-- �÷���ġ���� Ȯ��, default �� Ȯ��,
select a.table_name,b.table_name,a.column_name,b.column_name,a.column_id id,b.ordinal_position pos,a.data_type,b.data_type,a.data_length,b.character_maximum_length mlen,a.data_default,b.column_default,a.nullable,b.is_nullable,a.data_precision,a.data_scale,a.default_length
,b.numeric_precision,b.numeric_scale,b.column_comment
from dba_tab_columns a full outer join (SELECT * FROM MYSQL_COLUMNS WHERE workdate = to_char(sysdate,'YYYYMMDD')) b on a.table_name = substr(b.table_name,instr(b.table_name,'_')+1,length(b.table_name)) and a.column_name = b.column_name
where a.table_name like upper('%TENTERPRISE%') or b.table_name like upper('%TENTERPRISE%')
-- a.owner = 'BO_OWNER' and (a.table_name not like ('BATCH%') and a.table_name not like 'BIN%' and a.table_name not like 'IF%' and a.table_name not like 'MSA%' and a.table_name not like 'MMS%'
--and a.table_name not like 'NEO%' and a.table_name not like 'SMS%' and a.table_name not like 'T3PL%') 
 order by a.table_name,a.column_id,b.table_name,b.ordinal_position;

 ---- �÷��� ��ġ���� ���� �� Ȯ��
 select a.table_name,b.table_name,a.column_name,b.column_name,a.data_type,a.column_id id,a.data_length,a.data_default,b.ordinal_position pos,b.data_type,b.column_default,b.character_maximum_length mlen,b.is_nullable,a.data_precision,a.data_scale,a.nullable,a.default_length
,b.numeric_precision,b.numeric_scale,b.column_comment
from dba_tab_columns a full outer join (SELECT * FROM MYSQL_COLUMNS WHERE workdate = to_char(sysdate,'YYYYMMDD')) b 
  on a.table_name = substr(b.table_name,instr(b.table_name,'_')+1,length(b.table_name)) and a.column_name = b.column_name
where (a.column_name is null or b.column_name is null) and a.table_name in (select table_name from migtarget WHERE FLAG IS NULL OR FLAG <> 'N')  
  AND A.COLUMN_NAME NOT IN ('INSERT_ID','INSERT_DATE','MODIFY_ID','MODIFY_DATE') 
-- where (a.table_name = upper('tdescribe') or b.table_name like upper('%tdescribe%')) and (a.column_name is null or b.column_name is null) 
order by a.table_name,a.column_id,b.table_name,b.ordinal_position;

select 'vdTenterpriseBkup.set'||replace(initcap(lower(column_name)),'_')||'(tenterprise.get'||replace(initcap(lower(column_name)),'_')||'());' from mysql_columns where table_name = 'VD_TENTERPRISE_BKUP' order by ordinal_position;
select 'vdTentpuserBkup.set'||replace(initcap(lower(column_name)),'_')||'(tentpuser.get'||replace(initcap(lower(column_name)),'_')||'());' from mysql_columns where table_name = 'VD_TENTPUSER_BKUP' order by ordinal_position;
select 'pdTgoodssignBkup.set'||replace(initcap(lower(column_name)),'_')||'(tgoodssign.get'||replace(initcap(lower(column_name)),'_')||'());' from mysql_columns where table_name = 'PD_TGOODSSIGN_BKUP' order by ordinal_position;
select 'pdTpagoodstargetBkup.set'||replace(initcap(lower(column_name)),'_')||'(tpagoodstarget.get'||replace(initcap(lower(column_name)),'_')||'());' from mysql_columns where table_name = 'PD_TPAGOODSTARGET_BKUP' order by ordinal_position;
select 'vdTshipcostmBkup.set'||replace(initcap(lower(column_name)),'_')||'(tshipcostm.get'||replace(initcap(lower(column_name)),'_')||'());' from mysql_columns where table_name = 'VD_TSHIPCOSTM_BKUP' order by ordinal_position;
select 'dpTfaqBkup.set'||replace(initcap(lower(column_name)),'_')||'(tfaq.get'||replace(initcap(lower(column_name)),'_')||'());' from mysql_columns where table_name = 'DP_TFAQ_BKUP' order by ordinal_position;
select 'pdToffercodeBkup.set'||replace(initcap(lower(column_name)),'_')||'(toffercode.get'||replace(initcap(lower(column_name)),'_')||'());' from mysql_columns where table_name = 'PD_TOFFERCODE_BKUP' order by ordinal_position;
select 'cmTconfigBkup.set'||replace(initcap(lower(column_name)),'_')||'(tconfig.get'||replace(initcap(lower(column_name)),'_')||'());' from mysql_columns where table_name = 'CM_TCONFIG_BKUP' order by ordinal_position;
select 'saTmdteamBkup.set'||replace(initcap(lower(column_name)),'_')||'(tmdteam.get'||replace(initcap(lower(column_name)),'_')||'());' from mysql_columns where table_name = 'SA_TMDTEAM_BKUP' order by ordinal_position;
select 'mkTpromotargetBkup.set'||replace(initcap(lower(column_name)),'_')||'(tpromotarget.get'||replace(initcap(lower(column_name)),'_')||'());' from mysql_columns where table_name = 'MK_TPROMOTARGET_BKUP' order by ordinal_position;

-- ���̺� ���Ǽ�
--INSERT INTO COLUMN_DEF (SA,OWNER,TABLE_NAME,COLUMN_NAME,COLUMN_COMMENT,COLUMN_DESC)
SELECT a.sa,a.owner,a.table_name,b.column_name,b.column_comment,'' FROM 
 (	    SELECT ia.* FROM TABLE_DEF ia INNER JOIN ( SELECT table_name, MAX(seq) seq FROM TABLE_DEF   GROUP BY table_name) ib 
            ON ia.table_name = ib.table_name AND ia.seq = ib.seq ) a 
  LEFT OUTER JOIN (SELECT * FROM MYSQL_COLUMNS WHERE WORKDATE = TO_CHAR(SYSDATE,'YYYYMMDD')) b 
      ON a.table_name = b.table_name
 ORDER BY a.table_name,b.ordinal_position;
--COMMIT;
CREATE TABLE column_def_0428 AS SELECT * FROM column_def;
INSERT INTO column_def (sa,owner,table_name,column_name,column_comment,seq,flag)
SELECT '�������̽�','shoppingnt',b.table_name,b.column_name,b.column_comment,1,'Y'
--SELECT a.sa,a.table_name,a.column_name,a.COLUMN_COMMENT,a.COLUMN_DESC,a.seq,a.FLAG,a.comments,b.table_name,b.column_name,b.column_comment,b.ordinal_position 
  FROM column_def a FULL OUTER JOIN (SELECT * FROM MYSQL_COLUMNS WHERE WORKDATE = TO_CHAR(SYSDATE,'YYYYMMDD')) b 
ON a.table_name  = b.table_name AND a.column_name = b.column_name
WHERE a.COLUMN_NAME IS NULL AND b.table_name LIKE 'IF%' AND b.TABLE_NAME NOT LIKE '%_BK' AND b.TABLE_NAME NOT LIKE '%_BKUP' AND b.TABLE_NAME NOT LIKE '%_R'
ORDER BY a.table_name,b.table_name,b.ordinal_position;

SELECT B.SA,A.TABLE_NAME,B.TABLE_NAME,B.ENTITY_NAME,B.TABLE_DESC,b.flag FROM 
( SELECT * FROM MIGTARGET WHERE flag IS NULL OR flag <> 'N') a 
  LEFT OUTER JOIN 
(	    SELECT ia.* FROM TABLE_DEF ia INNER JOIN ( SELECT table_name, MAX(seq) seq FROM TABLE_DEF   GROUP BY table_name) ib 
            ON ia.table_name = ib.table_name AND ia.seq = ib.seq WHERE ia.flag IS NULL OR ia.flag <> 'N') b
  ON a.TABLE_NAME = SUBSTR(b.TABLE_NAME,4,LENGTH(B.TABLE_NAME))
 --WHERE a.table_name LIKE upper('%good%')
 ORDER BY b.sa,a.table_name;

--- shoppingnt schema �� �ִ� ���̺� ���
SELECT TABLE_NAME,TABLE_COMMENT FROM MYSQL_TABLES 
 WHERE WORKDATE = TO_CHAR(SYSDATE,'YYYYMMDD') AND TABLE_NAME NOT LIKE '%_BK' AND TABLE_NAME NOT LIKE '%_BKUP' AND TABLE_NAME NOT LIKE 'QRTZ%'
   AND TABLE_NAME NOT LIKE 'BATCH%' AND UPPER(TABLE_NAME) NOT LIKE UPPER('SAMPLE%') AND TABLE_NAME NOT IN ('TAREA') AND TABLE_NAME NOT LIKE '%_R';
-------------------
-- shoppingnt schema �������� ���������� description join
-- ���� ���̺��� �����
------------------------------
TRUNCATE TABLE FINAL_TABLE ;
INSERT INTO final_table (sa,owner,table_name,table_comment,comments,entity_name)
SELECT b.sa,'shoppingnt',a.table_name,a.table_comment,comments,b.entity_name FROM 
  (SELECT TABLE_NAME,TABLE_COMMENT FROM MYSQL_TABLES 
    WHERE WORKDATE = TO_CHAR(SYSDATE,'YYYYMMDD') AND TABLE_NAME NOT LIKE '%_BK' AND TABLE_NAME NOT LIKE '%_BKUP' AND TABLE_NAME NOT LIKE 'QRTZ%'
      AND TABLE_NAME NOT LIKE 'BATCH%' AND UPPER(TABLE_NAME) NOT LIKE UPPER('SAMPLE%') AND TABLE_NAME NOT IN ('TAREA') AND TABLE_NAME NOT LIKE '%_R' ) a 
 LEFT OUTER JOIN 
  (SELECT * FROM table_def WHERE flag IS NOT NULL AND flag <> 'N') b 
 ON a.table_name = b.table_name
 --WHERE a.table_name = 'DP_TWEBCODE'
 ORDER BY b.sa,a.table_name;
------------- ���� �����
SELECT sa,owner,table_name,table_comment,entity_name,REPLACE(comments,'null','') comments FROM final_table ORDER BY sa,table_name;
----------------------------------------------
----------------------------------------------
---- shoppignt schema �������� �÷� ����
------------------------------------------------
TRUNCATE TABLE FINAL_COLUMN ;
INSERT INTO final_column  
SELECT a.table_name,a.column_name,a.column_comment,a.column_type,a.is_nullable,column_key,column_default,b.comments,b.column_comment column_comment_def,ORDINAL_POSITION FROM 
  (SELECT TABLE_NAME,COLUMN_NAME ,COLUMN_COMMENT,ORDINAL_POSITION,column_default,is_nullable,column_type,column_key FROM MYSQL_COLUMNS 
    WHERE WORKDATE = TO_CHAR(SYSDATE,'YYYYMMDD') AND TABLE_NAME NOT LIKE '%_BK' AND TABLE_NAME NOT LIKE '%_BKUP' AND TABLE_NAME NOT LIKE 'QRTZ%'
      AND TABLE_NAME NOT LIKE 'BATCH%' AND UPPER(TABLE_NAME) NOT LIKE UPPER('SAMPLE%') AND TABLE_NAME NOT IN ('TAREA') AND TABLE_NAME NOT LIKE '%_R' ) a 
 LEFT OUTER JOIN 
  (SELECT * FROM column_def WHERE flag IS NOT NULL AND flag <> 'N') b 
 ON a.table_name = b.table_name AND a.column_name = b.column_name
 --WHERE a.table_name = 'DP_TWEBCODE'
 ORDER BY a.table_name,a.ordinal_position;
---------------------------------------------------------
-------------------------
--- ���� ���̺����Ǽ� �����
----------------------
-- CREATE TABLE final_col1 AS 
SELECT a.sa,a.table_name,a.table_comment,b.column_name,b.column_comment,b.column_type,b.is_nullable
       ,CASE b.column_key WHEN 'PRI' THEN b.column_key
                         WHEN 'MUL' THEN ''
                         ELSE '' END AS column_key 
       ,CASE b.column_key WHEN 'PRI' THEN ''
                         WHEN 'MUL' THEN 'FK'
                         ELSE '' END AS fkey
       ,b.column_default 
  FROM final_table a LEFT OUTER JOIN final_column b ON a.table_name = b.table_name 
 WHERE a.TABLE_NAME NOT LIKE '%_BK' AND a.TABLE_NAME NOT LIKE '%_BKUP' AND a.TABLE_NAME NOT LIKE 'QRTZ%'
   AND a.TABLE_NAME NOT LIKE 'BATCH%' AND UPPER(a.TABLE_NAME) NOT LIKE UPPER('SAMPLE%') AND a.TABLE_NAME NOT IN ('TAREA') AND a.TABLE_NAME NOT LIKE '%_R'
   --AND a.table_name LIKE 'PD_TGOODSINFOM%'
 ORDER BY a.sa,a.table_name,b.ordinal_position;
--------------------------------------------------------
---- ERD ������ ���� DB ���� ��
---------------------------------------------------------
SELECT * FROM excel WHERE workdate = to_char(sysdate,'YYYYMMDD') ; -- erd ���� ����
SELECT * FROM FINAL_TABLE ;
SELECT * FROM FINAL_COLUMN ;
SELECT c2,c3 FROM excel WHERE workdate = to_char(sysdate,'YYYYMMDD') GROUP BY c2,c3; -- erd ���� ���� (���̺�����)
SELECT c2 table_name,c5 column_name,c11 column_comment,c7 coulmn_type,c8 is_nullable,c9 default_value,c10 pk
  FROM excel WHERE workdate = to_char(sysdate,'YYYYMMDD');
-- ���� �� (���̺��̸��� �÷��̸����� ���Ͽ� erd ���� �ְų�, DB���� �ִ� �÷��� ����.
SELECT * FROM (
    SELECT c2 table_name,c5 column_name,c11 column_comment,c7 coulmn_type,c8 is_nullable,c9 default_value,c10 pk,c4 ordinal_position
      FROM excel WHERE workdate = to_char(sysdate,'YYYYMMDD')) a 
  FULL OUTER JOIN 
    final_column b 
  ON a.table_name = b.table_name AND a.column_name = b.COLUMN_NAME 
 WHERE (a.table_name IS NULL OR b.table_name IS NULL)
   AND b.TABLE_NAME NOT LIKE '%_BK' AND b.TABLE_NAME NOT LIKE '%_BKUP' AND b.TABLE_NAME NOT LIKE 'QRTZ%'
   AND b.TABLE_NAME NOT LIKE 'BATCH%' AND UPPER(b.TABLE_NAME) NOT LIKE UPPER('SAMPLE%') AND b.TABLE_NAME NOT IN ('TAREA') AND b.TABLE_NAME NOT LIKE '%_R'
 ORDER BY a.table_name,a.ordinal_position,b.table_name,b.ORDINAL_POSITION ;
----------------------------------------------------------------------------------
--- ���� �� (���̺��̸��� �÷��̸� �� ERD�� DB ��� �ִ� �÷��� �ĺ��ϰ�, ���� �ٸ� ���ǿ��� Ȯ��, erd�� column_comment �� �Ӽ� ������ (�Ӽ���ƴ�), db�� column_comment�� ��ġ��ų��.
---------------------------------------------------------------------------------
SELECT * FROM 
    (SELECT c2 table_name,c5 column_name,c11 column_comment,c7 column_type,CASE c8 WHEN 'Not Null' THEN 'NO' WHEN 'null' THEN 'YES' ELSE '' END AS  is_nullable
          ,CASE c9 WHEN 'null' THEN '' ELSE REPLACE(c9,'''','') END AS default_value
          ,c10 pk,to_number(c4) ordinal_position
      FROM excel WHERE workdate = to_char(sysdate,'YYYYMMDD')) a 
  INNER JOIN 
    (SELECT table_name,column_name,column_comment,column_type,is_nullable
           ,COLUMN_DEFAULT 
           ,to_number(ORDINAL_POSITION) ordinal_position FROM final_column ) b 
  ON a.table_name = b.table_name AND a.column_name = b.COLUMN_NAME 
 WHERE trim(a.column_comment) <> trim(b.COLUMN_COMMENT)
    OR  upper(a.column_type) <> upper(b.column_type)
    OR upper(a.is_nullable) <> upper(b.is_nullable)
    OR upper(a.default_value) <> upper(b.column_default)
    OR a.ordinal_position <> b.ordinal_position
 ORDER BY a.table_name,a.ordinal_position ;
---------------------------------------------------------------

--- ���̺� ���� ���� Ȯ��
SELECT * FROM mysql_columns WHERE workdate = to_char(sysdate -1, 'YYYYMMDD'); -- ������¥����
SELECT * FROM MYSQL_COLUMNS WHERE workdate = to_char(sysdate,'YYYYMMDD'); -- ���� ����
-----------------------------------------------------------------------------------------
-- ���� �־����� ���� ���°�. (��, ���� �������� ������ ���� �����̸�, ������ Ư�� �÷� ������ ����Ǿ��ų� ������ ����)
SELECT * FROM (
SELECT TABLE_CATALOG ,TABLE_SCHEMA ,TABLE_NAME ,COLUMN_NAME ,ORDINAL_POSITION ,COLUMN_DEFAULT ,IS_NULLABLE ,DATA_TYPE ,CHARACTER_MAXIMUM_LENGTH ,CHARACTER_OCTET_LENGTH ,NUMERIC_PRECISION ,NUMERIC_SCALE ,DATETIME_PRECISION ,CHARACTER_SET_NAME ,COLLATION_NAME ,COLUMN_TYPE ,COLUMN_KEY ,EXTRA ,MPRIVILEGES ,COLUMN_COMMENT FROM mysql_columns WHERE workdate = to_char(sysdate -1, 'YYYYMMDD') 
MINUS 
SELECT TABLE_CATALOG ,TABLE_SCHEMA ,TABLE_NAME ,COLUMN_NAME ,ORDINAL_POSITION ,COLUMN_DEFAULT ,IS_NULLABLE ,DATA_TYPE ,CHARACTER_MAXIMUM_LENGTH ,CHARACTER_OCTET_LENGTH ,NUMERIC_PRECISION ,NUMERIC_SCALE ,DATETIME_PRECISION ,CHARACTER_SET_NAME ,COLLATION_NAME ,COLUMN_TYPE ,COLUMN_KEY ,EXTRA ,MPRIVILEGES ,COLUMN_COMMENT FROM mysql_columns WHERE workdate = to_char(sysdate , 'YYYYMMDD') 
) t 
ORDER BY t.table_name,t.ordinal_position;
----------------------------------------------------------------------
--- ������ ���� ���̺� �� (�÷��� ������ ��)
SELECT * FROM 
    (SELECT * FROM mysql_columns WHERE workdate = to_char(sysdate -1, 'YYYYMMDD')) yes
  FULL OUTER JOIN 
    (SELECT * FROM mysql_columns WHERE workdate = to_char(sysdate , 'YYYYMMDD')) tod
  ON yes.table_schema = tod.table_schema AND yes.table_name = tod.table_name AND yes.column_name = tod.column_name
 where tod.table_name IS null
 ORDER BY yes.table_name,yes.ordinal_position;

SELECT * FROM mysql_columns WHERE table_name ='PD_TOFFERCODE' AND COLUMN_NAME = 'OFFER_TYPE' ORDER BY workdate DESC;

-------------------------------------------
-------------- 
--- table_def �� �������̽� ���̺� �߰���.
INSERT INTO table_def (sa,owner,table_name,entity_name,seq,flag) 
 SELECT '�������̽�','shoppingnt',table_name,table_comment,1,'Y' FROM mysql_tables 
  WHERE  WORKDATE = TO_CHAR(SYSDATE,'YYYYMMDD') 
    AND table_name LIKE 'IF%' AND TABLE_NAME NOT LIKE '%_BK' AND TABLE_NAME NOT LIKE '%_BKUP'AND TABLE_NAME NOT LIKE '%_R' ;
(SELECT * FROM table_def WHERE table_name LIKE 'IF%';
SELECT * FROM table_def;

TRUNCATE TABLE final_table;
DROP TABLE final_table;
CREATE TABLE final_table (sa varchar2(64), owner varchar2(64), table_name varchar2(64),table_comment varchar2(4000), entity_name varchar2(4000), comments varchar2(4000));
INSERT INTO FINAL_table SELECT * FROM final_table_def ;
--- ���� db�� �ݿ��� table comment �� entity name �� ����ġ�� ���
SELECT * FROM final_table WHERE table_comment <> entity_name ORDER BY sa,table_name;
SELECT * FROM final_table WHERE sa IS NULL;
INSERT INTO table_def (sa,owner,table_name,entity_name,seq,flag) VALUES ('����','shoppingnt','CM_TCARDDTMONTHLOG','CM_ī��纰 ������ �����α�',1,'Y');

-- table_def ����, entity name �� prefix ���̱�
SELECT * FROM table_def WHERE upper(table_name) LIKE upper('%tcarddt%');  
UPDATE table_def SET entity_name = 'SC_'||entity_name WHERE sa = 'SCM' AND entity_name IS NOT NULL AND table_name LIKE 'SC_%' AND entity_name NOT LIKE 'SC_%';
UPDATE table_def SET entity_name = REPLACE(entity_name,'MK_null','null') WHERE sa = '����' AND entity_name IS NOT NULL AND table_name LIKE 'CM_%';
UPDATE table_def SET entity_name = REPLACE(entity_name,'CM_null','null') ;
COMMIT;

----------------------------------

TRUNCATE TABLE final_column;
SELECT * FROM mysql_columns;
ALTER TABLE column_def ADD (comments varchar2(4000));
CREATE TABLE final_column (table_name varchar2(64),column_name varchar2(64), column_comment varchar2(4000), column_type varchar2(64), is_nullable varchar2(8), column_key varchar2(8), column_default varchar2(64), comments varchar2(4000), column_comment_def varchar2(4000),ordinal_position NUMBER);
SELECT * FROM final_column ORDER BY table_name,ordinal_position;
SELECT * FROM final_column WHERE column_comment <> column_comment_def ORDER BY table_name,ordinal_position;
SELECT * FROM final_column WHERE column_key IS NOT NULL ORDER BY table_name,ordinal_position;


SELECT sa,table_name FROM final_col1 GROUP BY sa,table_name ORDER BY sa,table_name;
--- excel �� �ִ� ������ Ȱ���Ͽ� table_def ������Ʈ
SELECT * FROM excel WHERE WORKDATE = TO_CHAR(SYSDATE,'YYYYMMDD') ORDER BY c3 ;
--CREATE TABLE excel_temp AS SELECT * FROM excel;
--RENAME excel_temp TO excel;
SELECT a.*,b.c2,b.c3,b.c4,b.c5 FROM table_def a full OUTER JOIN (SELECT * FROM excel WHERE WORKDATE = TO_CHAR(SYSDATE,'YYYYMMDD')) b 
    ON a.table_name = b.c4
 --WHERE 
 ORDER BY a.table_name;

-- table_name �� prefix �� ���� ���
SELECT a.*,b.c2,b.c3,b.c4,b.c5 FROM 
    (SELECT sa,owner,table_name, substr(table_name,4,LENGTH(table_name)) new_table_name,entity_name,table_desc,seq,flag FROM table_def) a 
 full OUTER JOIN (SELECT * FROM excel WHERE WORKDATE = TO_CHAR(SYSDATE,'YYYYMMDD')) b 
 ON a.new_table_name = b.c3
 WHERE b.c3 NOT IN ('null','������','���̺�')  -- �������� ���̺� �̸��� �ƴѰ�� ����
 --WHERE substr(entity_name,4,LENGTH(entity_name)) <> c4 OR entity_name IS null 
-- WHERE substr(entity_name,4,LENGTH(entity_name)) = c4
   AND a.new_table_name IS NULL -- �������� �ִµ� table_def �� ���� ���
 ORDER BY a.table_name,b.c3;
    
INSERT INTO table_def (sa,owner,table_name,entity_name,seq,flag) VALUES ('����','shoppingnt','DP_TMODGOODSINFOIMAGE','DP_��ǰ���̹�������',1,'Y');
COMMIT;
--- excel ������ ���̺�� ��� 
--CREATE TABLE TRN_�������̺�_�׸�_20210415 AS SELECT * FROM excel;
SELECT * FROM TRN_�������̺�_�׸�_20210415;
--CREATE TABLE excel_tempa AS SELECT c2,c3,c4,c5 FROM 
SELECT a.*,b.c2,b.c3,b.c4,b.c5 FROM 
    (SELECT sa,owner,table_name, substr(table_name,4,LENGTH(table_name)) new_table_name,entity_name,table_desc,seq,flag FROM table_def) a 
 full OUTER JOIN (SELECT * FROM TRN_�������̺�_�׸�_20210415 WHERE WORKDATE = '20210428') b 
 ON a.new_table_name = b.c3
 WHERE b.c3 NOT IN ('null','������','���̺�')  -- �������� ���̺� �̸��� �ƴѰ�� ����
 --WHERE substr(entity_name,4,LENGTH(entity_name)) <> c4 OR entity_name IS null 
-- WHERE substr(entity_name,4,LENGTH(entity_name)) = c4
   AND a.new_table_name IS NULL -- �������� �ִµ� table_def �� ���� ���
   --AND b.c3 IS NULL -- table_def �� �ִµ� , ������ ���� ���̺�
   --AND a.new_table_name IS NOT NULL AND b.c3 IS NOT NULL  -- ���ʿ� ��� �ִ� ���̺�
 ORDER BY a.table_name,b.c3  ;
SELECT DISTINCT sa FROM table_def;
INSERT INTO table_def (sa,owner,table_name,entity_name,seq,flag) VALUES ('����','shoppingnt','DP_TMODGOODSINFOIMAGE','DP_��ǰ���̹�������',1,'Y');
INSERT INTO table_def (sa,owner,table_name,entity_name,comments,seq,flag)
SELECT sa,'shoppingnt',CASE sa WHEN '��ǰ' THEN 'PD_'||table_name WHEN '����' THEN 'DP_'||table_name WHEN '���θ��' THEN 'MK_'||table_name WHEN '����' THEN 'CM_'||TABLE_NAME 
                  WHEN 'SCM' THEN 'SC_'||table_name WHEN '��ü' THEN 'VD_'||table_name ELSE table_name END AS table_name,c4,c5,1,'Y' FROM (
SELECT CASE c2 WHEN '00.����' THEN '����'
               WHEN '10.��ǰ' THEN '��ǰ'
               WHEN '15.��ü' THEN '��ü'
               WHEN '20.���θ��' THEN '���θ��'
               WHEN '25.����' THEN '����'
               WHEN '30.���' THEN '���'
               WHEN '35.�м�' THEN '�м�'
               WHEN '40.����' THEN '����'
               WHEN '50.�ֹ�' THEN '�ֹ�'
               WHEN '55.����' THEN '����'     
               WHEN '60.��' THEN '��' 
               WHEN '65.���' THEN '���' 
               WHEN '70.����' THEN '����' 
               WHEN '80.����' THEN '����' 
               WHEN '85.����' THEN '����' 
               WHEN '90.�������̽�' THEN '�������̽�' 
               WHEN '95.��ġ' THEN '��ġ'            
               WHEN '99.SCM' THEN 'SCM'                
               ELSE '' END AS sa,
       c3 table_name ,c4,c5
  FROM excel_temp ) tt;
 SELECT c2,count(*) FROM excel_temp GROUP BY c2 ORDER BY c2;
COMMIT;
----------------------------------------
CREATE TABLE table_def_temp AS 
SELECT a.*,b.c2,b.c3,b.c4,b.c5 FROM 
    (SELECT sa,owner,table_name, substr(table_name,4,LENGTH(table_name)) new_table_name,entity_name,table_desc,seq,flag FROM table_def) a 
 full OUTER JOIN (SELECT * FROM excel WHERE WORKDATE = TO_CHAR(SYSDATE,'YYYYMMDD')) b 
 ON a.new_table_name = b.c3
 --WHERE substr(entity_name,4,LENGTH(entity_name)) <> c4 OR entity_name IS null
 WHERE substr(entity_name,4,LENGTH(entity_name)) = c4;
 
SELECT * FROM table_def a FULL OUTER JOIN table_def_temp b ON a.table_name = b.table_name ORDER BY a.table_name;
UPDATE table_def a SET a.comments = (SELECT b.c5 FROM table_def_temp b WHERE b.table_name = a.table_name) ;

--- table_def update ���� ��� ���� ��
CREATE TABLE table_def_0428 AS SELECT * FROM table_def;

---- migtarget ���̺� ���� �÷� ����
SELECT A.TABLE_NAME,B.TABLE_NAME,B.COLUMN_NAME,B.ORDINAL_POSITION FROM 
 ( SELECT * FROM MIGTARGET WHERE flag IS NULL OR flag <> 'N') A
   LEFT OUTER JOIN 
 ( SELECT * FROM MYSQL_COLUMNS WHERE WORKDATE =  TO_CHAR(SYSDATE,'YYYYMMDD')) B 
 ON A.TABLE_NAME = SUBSTR(B.TABLE_NAME,4,LENGTH(B.TABLE_NAME));

--- �÷� ���Ǽ�
SELECT TARGET_TABLE_NAME,T1.TABLE_NAME,T1.COLUMN_NAME,T1.ORDINAL_POSITION,T2.COLUMN_COMMENT,T2.COLUMN_DESC,T2.SEQ FROM 
 ( SELECT A.TABLE_NAME TARGET_TABLE_NAME,B.TABLE_NAME,B.COLUMN_NAME,B.ORDINAL_POSITION FROM 
 	( SELECT * FROM MIGTARGET WHERE flag IS NULL OR flag <> 'N') A
  		 LEFT OUTER JOIN 
	 ( SELECT * FROM MYSQL_COLUMNS WHERE WORKDATE =  TO_CHAR(SYSDATE,'YYYYMMDD')) B 
 ON A.TABLE_NAME = SUBSTR(B.TABLE_NAME,4,LENGTH(B.TABLE_NAME))) T1
  LEFT OUTER JOIN 
 (	    SELECT ia.* FROM COLUMN_DEF ia INNER JOIN ( SELECT table_name,COLUMN_NAME, MAX(seq) seq FROM COLUMN_DEF  GROUP BY table_name,COLUMN_NAME) ib 
            ON ia.table_name = ib.table_name AND ia.COLUMN_NAME = ib.column_name AND ia.seq = ib.seq  WHERE ia.flag IS NULL OR ia.flag <> 'N') T2
 ON T1.TABLE_NAME = T2.TABLE_NAME AND T1.COLUMN_NAME = T2.COLUMN_NAME
 WHERE t1.table_name LIKE upper('%lott%cust%')
 ORDER BY T1.table_name,T1.ORDINAL_POSITION;

SELECT * FROM TABLE_DEF;
select * FROM column_def;
SELECT * FROM table_list ORDER BY table_name;
SELECT * from excel;
SELECT * FROM table_def;
SELECT * FROM migtarget;
SELECT a.owner,a.table_name,a.comments,b.c2,b.c3,b.c4,b.c5 FROM migtarget a LEFT OUTER JOIN excel b ON a.table_name = b.c3 ORDER BY a.table_name;
--CREATE TABLE table_list (seq int, sa varchar2(64), table_name varchar2(64), entity_name varchar2(64), table_desc varchar2(1024));
--INSERT INTO table_list SELECT to_number(c1),c2,c3,c4,c5 FROM excel WHERE c1 NOT IN ('null','NO') AND c1 IS NOT null; 
SELECT DISTINCT c1 FROM excel ORDER BY 1;
SELECT a.table_name,a.comments,b.c9,b.c10,b.c11,b.c12,b.c17 FROM migtarget a LEFT OUTER JOIN excel b ON a.table_name = b.c10 ORDER BY a.table_name;
--CREATE TABLE column_list (table_name varchar2(64), entity_name varchar2(64), column_name varchar2(64), column_comment varchar2(1024));
--INSERT INTO column_list SELECT c10,c9,c11,c12 FROM excel WHERE c11 NOT IN ('null','NO') AND c11 IS NOT null; 
COMMIT;
--DELETE FROM column_list WHERE table_name IN ('���̺�');
SELECT table_name,column_name,count(*) FROM column_list GROUP BY table_name,column_name HAVING count(*) > 1;
SELECT a.table_name,a.comments,b.entity_name,b.column_name,b.column_comment FROM migtarget a LEFT OUTER JOIN column_list b ON a.table_name = b.table_name ORDER BY a.table_name,b.column_name;
SELECT * FROM column_list GROUP BY table_name;
--- migtarget �� ���̺� �߰�
SELECT * FROM table_list WHERE table_name LIKE 'TSALE%';
SELECT * FROM migtarget;
INSERT INTO migtarget (owner,table_name,comments,flag) SELECT 'BO_OWNER',table_name,entity_name,'Y' FROM table_list WHERE table_name = 'TSALENOGOODS' ;
COMMIT;



