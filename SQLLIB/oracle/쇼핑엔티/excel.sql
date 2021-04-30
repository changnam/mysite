SELECT * from excel;
SELECT * FROM table_def;
SELECT * FROM migtarget;
SELECT a.owner,a.table_name,a.comments,b.c2,b.c3,b.c4,b.c5 FROM migtarget a LEFT OUTER JOIN excel b ON a.table_name = b.c3 ORDER BY a.table_name;
CREATE TABLE table_list (seq int, sa varchar2(64), table_name varchar2(64), entity_name varchar2(64), table_desc varchar2(1024));
INSERT INTO table_list SELECT to_number(c1),c2,c3,c4,c5 FROM excel WHERE c1 NOT IN ('null','NO') AND c1 IS NOT null; 
SELECT DISTINCT c1 FROM excel ORDER BY 1;

SELECT * FROM table_list WHERE table_name LIKE 'TSALE%';
SELECT * FROM migtarget;
INSERT INTO migtarget (owner,table_name,comments,flag) SELECT 'BO_OWNER',table_name,entity_name,'Y' FROM table_list WHERE table_name = 'TSALENOGOODS' ;
COMMIT;

SELECT * FROM excel WHERE workdate = to_char(sysdate,'YYYYMMDD');
CREATE TABLE ASIS_TOBE_테이블_매핑_도메인 AS SELECT * FROM excel WHERE workdate = to_char(sysdate,'YYYYMMDD');
SELECT * FROM excel WHERE workdate = to_char(sysdate,'YYYYMMDD') and c12 NOT IN ('null') AND c12 IS NOT NULL ORDER BY c12;
SELECT REPLACE(INITCAP(c1),'_','') FROM excel WHERE workdate = to_char(sysdate,'YYYYMMDD') and c16 NOT IN ('null') AND c16 IS NOT NULL ORDER BY c16;
SELECT * FROM mysql_columns WHERE table_name LIKE upper('MK%LOT%promo%') ORDER BY workdate,table_name,ordinal_position;
SELECT * FROM excel WHERE workdate = to_char(sysdate,'YYYYMMDD') and upper(c5) LIKE upper('%tot%sale%'); -- erd 컬럼명
SELECT * FROM excel WHERE workdate = to_char(sysdate,'YYYYMMDD') and upper(c6) LIKE upper('%배송%비용%'); -- erd 속성명
SELECT * FROM excel WHERE workdate = to_char(sysdate,'YYYYMMDD') and upper(c1) LIKE upper('%상품%부가%'); -- erd 엔티티명