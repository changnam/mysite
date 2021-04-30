execute immediate 'ALTER SESSION SET SESSION_CACHED_CURSORS = 0';
dbms_session.CLOSE_DATABASE_LINK('shoppingnt');
execute immediate 'ALTER SESSION SET SESSION_CACHED_CURSORS = 50';

EXECUTE DBMS_SESSION.CLOSE_DATABASE_LINK('shoppingnt');

select * from dba_tables where owner = 'BO_OWNER' order by table_name;
select count(*) from dba_tables where owner = 'BO_OWNER' order by table_name;
insert into sa_migtarget@shoppingnt select table_name,'N' from dba_tables where owner = 'BO_OWNER';
insert into sa_migtarget@shoppingnt values ('TBRAND','N');
insert into sa_migtarget@shoppingnt(table_name,ynflag) values ('TBRAND','N');
desc shoppingnt.sa_migtarget@shoppingnt;
select * from sa_migtarget@shoppingnt t1;
delete from sa_migtarget@shoppingnt;
commit;
create table migtarget (table_name varchar2(64) , ynflag varchar2(1));
insert into migtarget select table_name,'N' from dba_tables where owner = 'BO_OWNER';
commit;
select * from migtarget;
update migtarget set ynflag = 'Y' where table_name in (
'TBRAND',
'TCARDDTMONTH',
'TCARTDT',
'TCARTM',
'TCATEGORY',
'TDESCRIBE',
'TDESCRIBECODE',
'TDESCRIBENOTE',
'TFAQ',
'TGOODS',
'TGOODSCOMMENT',
'TGOODSCOMMENTIMAGE',
'TGOODSCOMMENTSUM',
'TGOODSDT',
'TGOODSDTHISTORY',
'TGOODSHISTORY',
'TGOODSIMAGE',
'TGOODSINFODT',
'TGOODSINFOIMAGE',
'TGOODSINFOM',
'TGOODSKINDS',
'TGOODSMODIFIER',
'TMD',
'TMDLINK',
'TOFFER',
'TOFFERCODE',
'TPROMOEXCEPT',
'TSHIPCOSTDT',
'TSHIPCOSTM',
'TSYNERGYGOODS',
'TWISHLIST',
'TYEARSERVICEDT');
commit;

---mig 대상 (32)
create table migflag as select * from migtarget;
select * from migflag;
drop table migtarget;
select * from migtarget where ynflag = 'Y' order by table_name;
select * from dba_tab_comments where owner = 'BO_OWNER' and table_name in (select table_name from migflag where ynflag = 'Y' ) order by table_name;
create table migtarget as select * from dba_tab_comments where owner = 'BO_OWNER' and table_name in (select table_name from migflag where ynflag = 'Y' ) ;
select * from migtarget;
select table_name,table_comment from information_schema.tables@shoppingnt where table_schema = 'shoppingnt' order by table_name;
create table migflag_m as select table_name,table_comment from information_schema.tables@shoppingnt where table_schema = 'shoppingnt';
create table migflag_m (table_name varchar2(64), table_comment varchar2(512), ynflag varchar2(1) default 'N');
insert into migflag_m (table_name) select table_name from  information_schema.tables@shoppingnt where table_schema = 'shoppingnt';
commit;
select * from migflag_m a full outer join migtarget b on a.table_name = b.table_name order by a.table_name;
select table_name,substr(table_name,instr(table_name,'_')+1,length(table_name)) originname,instr(table_name,'_') from migflag_m;

-- mig 대상 (32개) 과 실제 mysql 에 생성된 원장 비교 (21개만 원장 존재)
select * from migtarget a left outer join (select table_name,substr(table_name,instr(table_name,'_')+1,length(table_name)) originname,instr(table_name,'_') from migflag_m ) b
on a.table_name = b.originname where b.originname is not null order by a.table_name,b.originname;

select column_name,data_type,data_length,data_precision,data_scale,nullable,column_id,default_length,data_default from dba_tab_columns where owner = 'BO_OWNER' and table_name = 'TBRAND' order by column_id;
select column_name,ordinal_position,column_default,is_nullable,numeric_precision,numeric_scale,datetime_precision from information_schema.columns@shoppingnt 
 where table_schema = 'shoppingnt' and table_name = 'PD_TBRAND' order by ordinal_position; -- data_type,column_type,column_comment 못가져옴

drop table migcolumns_m;
create table migcolumns_m as select table_name,column_name,ordinal_position,is_nullable,column_default,numeric_precision,numeric_scale,datetime_precision from information_schema.columns@shoppingnt 
 where table_schema = 'shoppingnt' ;

select * from migcolumns_m;

--- 생성된 테이블 (21개) 중, 컬럼 비교
-- 1. 컬럼비교
select * from (
select column_name,data_type,data_length,data_precision,data_scale,nullable,column_id,default_length,data_default from dba_tab_columns where owner = 'BO_OWNER' and table_name = 'TBRAND') a
full outer join 
(select * from migcolumns_m where table_name = 'PD_TBRAND' ) b
on a.column_name = b.column_name order by a.column_id,b.ordinal_position; -- data_type,column_type,column_comment 못가져옴
-- 2.default 값 비교

select * from dba_col_comments where owner = 'BO_OWNER' and upper(comments) like upper('%계좌%번호%') order by owner,table_name,column_name;

drop table cddba1.mysql_tables;
create table cddba1.mysql_tables (
TABLE_CATALOG						varchar2(64) not null,	
TABLE_SCHEMA						varchar2(64) not null,	
TABLE_NAME						varchar2(64) not null,	
TABLE_TYPE						varchar2(64) not null,	
ENGINE						varchar2(64) ,	
VERSION						number(10),	
ROW_FORMAT						varchar2(64) not null,	
TABLE_ROWS						number(20),	
AVG_ROW_LENGTH						number(20),	
DATA_LENGTH						number(20),	
MAX_DATA_LENGTH						number(20),	
INDEX_LENGTH						number(20),	
DATA_FREE						number(20),	
AUTO_INCREMENT						number(20),	
CREATE_TIME						timestamp default current_timestamp not null,	
UPDATE_TIME						date,	
CHECK_TIME						date,	
TABLE_COLLATION						varchar2(64),	
CHECKSUM						number(20),	
CREATE_OPTIONS						varchar2(64),	
TABLE_COMMENT						clob )	;

select * from mysql_tables ;
select count(*) from mysql_tables;
select * from mysql_columns ;

drop table cddba1.mysql_columns;
create table cddba1.mysql_columns(
TABLE_CATALOG	varchar2(64) not null,
TABLE_SCHEMA	varchar2(64) not null,
TABLE_NAME	varchar2(64) not null,
COLUMN_NAME	varchar2(64) ,
ORDINAL_POSITION	number(10) not null,
COLUMN_DEFAULT	clob,
IS_NULLABLE	varchar2(3) not null,
DATA_TYPE	clob,
CHARACTER_MAXIMUM_LENGTH	decimal(19),
CHARACTER_OCTET_LENGTH	decimal(19),
NUMERIC_PRECISION	decimal(20),
NUMERIC_SCALE	decimal(20),
DATETIME_PRECISION	number(10) ,
CHARACTER_SET_NAME	varchar2(64) ,
COLLATION_NAME	varchar2(64) ,
COLUMN_TYPE	clob,
COLUMN_KEY	varchar2(3) ,
EXTRA	varchar2(256),
MPRIVILEGES	varchar2(154),
COLUMN_COMMENT	clob ,
GENERATION_EXPRESSION	clob ,
SRS_ID	number(10));

select * from mysql_columns where table_name = 'PD_TBRAND' order by ordinal_position;

select * from dba_tab_columns where table_name = 'TBRAND' order by column_id;

-- 컬럼일치여부 확인, default 값 확인,
select a.table_name,b.table_name,a.column_name,b.column_name,a.column_id id,b.ordinal_position pos,a.data_type,b.data_type,a.data_length,b.character_maximum_length mlen,a.data_default,b.column_default,a.nullable,b.is_nullable,a.data_precision,a.data_scale,a.default_length
,b.numeric_precision,b.numeric_scale,b.column_comment
from dba_tab_columns a full outer join mysql_columns b on a.table_name = substr(b.table_name,instr(b.table_name,'_')+1,length(b.table_name)) and a.column_name = b.column_name
where a.table_name like upper('%TCATEGORYGOODS%') or b.table_name like upper('%TCATEGORYGOODS%')
-- a.owner = 'BO_OWNER' and (a.table_name not like ('BATCH%') and a.table_name not like 'BIN%' and a.table_name not like 'IF%' and a.table_name not like 'MSA%' and a.table_name not like 'MMS%'
--and a.table_name not like 'NEO%' and a.table_name not like 'SMS%' and a.table_name not like 'T3PL%') 
 order by a.table_name,a.column_id,b.table_name,b.ordinal_position;
 
 ---- 컬럼이 일치하지 않은 것 확인
 select a.table_name,b.table_name,a.column_name,b.column_name,a.data_type,a.column_id id,a.data_length,a.data_default,b.ordinal_position pos,b.data_type,b.column_default,b.character_maximum_length mlen,b.is_nullable,a.data_precision,a.data_scale,a.nullable,a.default_length
,b.numeric_precision,b.numeric_scale,b.column_comment
from dba_tab_columns a full outer join mysql_columns b on a.table_name = substr(b.table_name,instr(b.table_name,'_')+1,length(b.table_name)) and a.column_name = b.column_name
where (a.column_name is null or b.column_name is null) and a.table_name in (select table_name from migtarget)  
-- where (a.table_name = upper('tdescribe') or b.table_name like upper('%tdescribe%')) and (a.column_name is null or b.column_name is null) 
 order by a.table_name,a.column_id,b.table_name,b.ordinal_position;
 
 --- default 값 불일치 확인
  ---- 컬럼이 일치하지 않은 것 확인
 select a.table_name,b.table_name,a.column_name,b.column_name,a.data_type,a.column_id id,a.data_length,a.data_default,b.ordinal_position pos,b.data_type,b.column_default,b.character_maximum_length mlen,a.nullable,b.is_nullable,a.data_precision,a.data_scale,a.default_length
,b.numeric_precision,b.numeric_scale,b.column_comment
from dba_tab_columns a inner join mysql_columns b on a.table_name = substr(b.table_name,instr(b.table_name,'_')+1,length(b.table_name)) and a.column_name = b.column_name
where a.data_default is not null and b.column_default is null 
 order by a.table_name,a.column_id,b.table_name,b.ordinal_position;
 
select 'alter table '||table_name||' modify column '||column_name||' defalut ',data_default,';',tabname,id,pos from ( select a.table_name tabname,b.table_name,a.column_name colname,b.column_name,a.data_type atype,a.column_id id,a.data_length,a.data_default,b.ordinal_position pos,b.data_type,b.column_default,b.character_maximum_length mlen,a.nullable,b.is_nullable,a.data_precision,a.data_scale,a.default_length
,b.numeric_precision,b.numeric_scale,b.column_comment
from dba_tab_columns a inner join mysql_columns b on a.table_name = substr(b.table_name,instr(b.table_name,'_')+1,length(b.table_name)) and a.column_name = b.column_name
where a.data_default is not null and b.column_default is null ) t
order by tabname,id,table_name,pos;
 
 desc mysql_columns;
 truncate table mysql_columns;
 
 select 'alter table' from dba_col_comments where owner = 'BO_OWNER' and table_name = 'TGOODSKINDS' ;
 select b.column_name,' comment '||' '''||a.comments||''' ' from dba_col_comments a inner join mysql_columns b on a.table_name = substr(b.table_name,instr(b.table_name,'_')+1,length(b.table_name)) and a.column_name = b.column_name
 where a.table_name = 'TOFFERCODE' order by b.ordinal_position;
 
 --- ORACLE 에 있는데, MYSQL에 없는 컬럼 리스트
 select * from dba_tab_columns a left outer join mysql_columns b
     on a.table_name = substr(b.table_name,instr(b.table_name,'_')+1,length(b.table_name)) and a.column_name = b.column_name
 where a.owner = 'BO_OWNER' and a.table_name in (select table_name from migtarget)
   and b.column_name is null 
   and a.column_name not in ('INSERT_ID','INSERT_DATE','MODIFY_ID','MODIFY_DATE')
   --and upper(a.table_name) like upper('tgoods')
 order by a.table_name,a.column_id;
 -- 특정 테이블 비교
select a.table_name,a.column_name,b.column_name,a.column_id,b.ordinal_position,a.data_type,b.data_type,a.data_length,b.character_maximum_length mlen,a.nullable,b.is_nullable from
--select *  from 
(select * from dba_tab_columns where owner='BO_OWNER' and upper(table_name)=upper('Toffer')) a full outer join (select * from mysql_columns where upper(table_name) = upper('pd_toffer_bkup')) b
 on a.column_name = b.column_name
 --where a.column_name is null or b.column_name is null
 --where upper(a.column_name) like upper('%media%code%')
 --where a.data_type = 'VARCHAR2' and a.data_length > b.character_maximum_length
 order by a.table_name,a.column_id;
 
 select * from mysql_columns where upper(table_name) like upper('if%');
 select * from dba_tab_columns where upper(table_name) = upper('tgoods') order by column_id;
 
 -- 컬럼 타입 비교
 select a.table_name,a.column_name,a.data_type||b.data_type as bothtype from dba_tab_columns a left outer join mysql_columns b
     on a.table_name = substr(b.table_name,instr(b.table_name,'_')+1,length(b.table_name)) and a.column_name = b.column_name
 where a.owner = 'BO_OWNER' and a.table_name in (select table_name from migtarget)
   and a.column_name not in ('INSERT_ID','INSERT_DATE','MODIFY_ID','MODIFY_DATE') 
  order by a.table_name,a.column_id;

-- 인터페이스 테이블 비교
select * from mysql_tables where upper(table_name) like upper('%describe%') order by table_name;
select * from migtarget where upper(table_name) like upper('%describe%')  order by table_name;
-- IF시작 테이블과 아닌 테이블간 컬럼 비교 (컬럼 이름이 IF 로 시작하지 않는것)
select a.table_name,a.column_name,b.table_name,b.column_name,a.ordinal_position,b.ordinal_position,a.data_type,b.data_type from 
  (select * from mysql_columns where table_name like 'IF%') a full outer join (select * from mysql_columns where table_name not like 'IF%' ) b
   on substr(a.table_name,4,length(a.table_name)) = substr(b.table_name,5,length(b.table_name))
   and a.column_name = b.column_name
--where a.table_name = 'IF_DESCRIBE' or b.table_name = 'PD_TDESCRIBE'
  where a.column_name not like 'IF%' and (a.column_name is null or b.column_name is null)
    AND (a.table_name NOT LIKE '%_BK' and a.table_name NOT LIKE '%_R' AND a.table_name NOT LIKE '%_MST')
order by a.table_name,a.ordinal_position,b.table_name,b.ordinal_position;
select substr(table_name,5,length(table_name)),table_name from mysql_columns where table_name like 'CM%' order by table_name;

-- 인터페이스 테이블중 필수 컬럼 누락여부 확인
SELECT * FROM mysql_columns WHERE table_name LIKE 'IF%' ORDER BY table_name,ORDINAL_POSITION ;
SELECT * FROM mysql_columns WHERE table_name LIKE 'IF%' AND column_name IN ('IF_TYPE','IF_FLAG','IF_MSG','IF_DTM','IF_REG_ID','IF_REG_DTM','IF_UPD_ID','IF_UPD_DTM','IF_SEQ','IF_SEQ_NO');
SELECT table_name,count(*) FROM (SELECT * FROM mysql_columns WHERE table_name LIKE 'IF%' AND column_name IN ('IF_TYPE','IF_FLAG','IF_MSG','IF_DTM','IF_REG_ID','IF_REG_DTM','IF_UPD_ID','IF_UPD_DTM','IF_SEQ','IF_SEQ_NO')) T
GROUP BY t.table_name ORDER BY count(*) ;
SELECT * FROM mysql_columns WHERE table_name LIKE 'IF_LOTTERYPROMOCUST%' ORDER BY table_name,ORDINAL_POSITION ;
SELECT COLUMN_NAME,COLUMN_COMMENT,count(*) FROM MYSQL_COLUMNS WHERE COLUMN_NAME LIKE 'IF%' GROUP BY COLUMN_NAME,COLUMN_COMMENT ORDER BY COLUMN_NAME,COLUMN_COMMENT;
SELECT * FROM dba_tab_columns WHERE table_name LIKE 'IF_BRAND%' ORDER BY table_name,column_id;
-- set method
TRUNCATE TABLE MYSQL_TABLES ;
TRUNCATE TABLE MYSQL_COLUMNS ;
select * from mysql_columns where table_name = 'DP_TCATEGORY_BKUP';
select 'dpTcategoryBkup.set'||replace(initcap(lower(column_name)),'_')||'(tcategory.get'||replace(initcap(lower(column_name)),'_')||'());' from mysql_columns where table_name = 'DP_TCATEGORY_BKUP' order by ordinal_position;
select 'pdTgoodsBkup.set'||replace(initcap(lower(column_name)),'_')||'(tgoods.get'||replace(initcap(lower(column_name)),'_')||'());' from mysql_columns where table_name = 'PD_TGOODS_BKUP' order by ordinal_position;
select 'pdTgoodsdtBkup.set'||replace(initcap(lower(column_name)),'_')||'(tgoodsdt.get'||replace(initcap(lower(column_name)),'_')||'());' from mysql_columns where table_name = 'PD_TGOODSDT_BKUP' order by ordinal_position;
select 'pdTofferBkup.set'||replace(initcap(lower(column_name)),'_')||'(toffer.get'||replace(initcap(lower(column_name)),'_')||'());' from mysql_columns where table_name = 'PD_TOFFER_BKUP' order by ordinal_position;
select 'mkTpromomBkup.set'||replace(initcap(lower(column_name)),'_')||'(tpromom.get'||replace(initcap(lower(column_name)),'_')||'());' from mysql_columns where table_name = 'MK_TPROMOM_BKUP' order by ordinal_position;
select 'mkTpromorefeatBkup.set'||replace(initcap(lower(column_name)),'_')||'(tpromorefeat.get'||replace(initcap(lower(column_name)),'_')||'());' from mysql_columns where table_name = 'MK_TPROMOREFEAT_BKUP' order by ordinal_position;
select 'pdTgoodsaddinfoBkup.set'||replace(initcap(lower(column_name)),'_')||'(tgoodsaddinfo.get'||replace(initcap(lower(column_name)),'_')||'());' from mysql_columns where table_name = 'PD_TGOODSADDINFO_BKUP' order by ordinal_position;
select 'pdTgoodsmodifierBkup.set'||replace(initcap(lower(column_name)),'_')||'(tgoodsmodifier.get'||replace(initcap(lower(column_name)),'_')||'());' from mysql_columns where table_name = 'PD_TGOODSMODIFIER_BKUP' order by ordinal_position;
select 'pdTgoodsshareBkup.set'||replace(initcap(lower(column_name)),'_')||'(tgoodsshare.get'||replace(initcap(lower(column_name)),'_')||'());' from mysql_columns where table_name = 'PD_TGOODSSHARE_BKUP' order by ordinal_position;
select 'pdTgoodsvodBkup.set'||replace(initcap(lower(column_name)),'_')||'(tgoodsvod.get'||replace(initcap(lower(column_name)),'_')||'());' from mysql_columns where table_name = 'PD_TGOODSVOD_BKUP' order by ordinal_position;
select 'dpTcategorygoodsBkup.set'||replace(initcap(lower(column_name)),'_')||'(tcategorygoods.get'||replace(initcap(lower(column_name)),'_')||'());' from mysql_columns where table_name = 'DP_TCATEGORYGOODS_BKUP' order by ordinal_position;
