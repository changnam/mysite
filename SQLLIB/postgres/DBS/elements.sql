DROP TABLE elements;
CREATE TABLE elements (file_path varchar2(512),file_name varchar2(64),el_DEPTH NUMBER,element_name varchar2(64),element_id NUMBER,parent_name varchar2(64),parent_id NUMBER,attr_name varchar(128),attr_value varchar(4000), control_id number);
ALTER TABLE elements ADD (control_id NUMBER);
TRUNCATE TABLE elements;
DROP TABLE xdatasets;
CREATE TABLE xdatasets (file_path varchar2(512),file_name varchar2(64),ds_name varchar2(64),col_name varchar2(64), col_desc varchar2(512), col_length NUMBER, col_data varchar2(1), col_callback varchar2(512),col_order number);
TRUNCATE TABLE xdatasets;
SELECT * FROM xdatasets ORDER BY file_path,ds_name,col_order;

SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'^C:\\xFrame.+cmc312p','i') ;
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'^C:\\ntree','i') ;
SELECT file_path,count(*) FROM elements GROUP BY file_path ORDER BY file_path;
DELETE FROM elements WHERE REGEXP_LIKE(file_path,'C:\\xFrame\\project\\DSI\\screen.+CPA006L\.xml','i') ;
DELETE FROM elements WHERE REGEXP_LIKE(file_path,'C:\\xFrame\\project\\DSI\\screen\\_SYS','i') ;
-- CREATE TABLE cpa006l_0806_2 AS 
SELECT *  FROM elements WHERE REGEXP_LIKE(file_path,'C:\\xFrame\\project\\DSI\\screen.+CPA006L\.xml','i') ;
COMMIT;
SELECT * FROM cpa006l_0806_2 MINUS SELECT * FROM cpa006l_0806;
SELECT * FROM cpa006l_0806 MINUS SELECT * FROM cpa006l_0806_2;
DROP TABLE elements_t;
CREATE TABLE elements_t AS SELECT substr(file_path,instr(file_path,'\',-1)-2,2) pgm_path, substr(file_path,instr(file_path,'\',-1)-2, instr(file_path,'.',-1) - instr(file_path,'\',-1) + 2) new_file_path, t.* 
  FROM elements t WHERE REGEXP_LIKE(file_path,'^c:\\xframe','i') ;
   FROM elements t WHERE REGEXP_LIKE(file_path,'^C:\\ntree|^c:\\xframe|^c:\\conv_result','i') ;
SELECT substr(file_path,instr(file_path,'\',-1)-2,2) pgm_path, substr(file_path,instr(file_path,'\',-1)-2, instr(file_path,'.',-1)-1) new_file_path, t.* 
,instr(file_path,'\',-1)-2 startloc, instr(file_path,'.',-1)-1 endloc, LENGTH(file_path) totallen FROM elements t WHERE REGEXP_LIKE(file_path,'C:\\xFrame\\project\\DSI\\screen\\NTREE\\bd\\BDM029P.xml','i') ;
SELECT * FROM elements_t WHERE REGEXP_LIKE(file_path,'mainframe','i') AND REGEXP_LIKE(attr_name,'^on','i') ORDER BY file_path,element_id;

DROP TABLE TARGET_ELEMENTS ;
CREATE TABLE target_elements AS SELECT GUBUN,
MENU1,
MENU2,
MENU3,
SCR_ID,
PGM_FULLPATH,
PGM_NAME,
USE_YN,
SCR_TYPE,
DEV_YN,
RPT_NM,
MENU_YN,
REALUSE_YN,
IMPORTANT_YN,
FREQ_YN,
MANAGER,
MENUREG_YN,
COMMENTS,b.* FROM targets a INNER JOIN elements_t b ON a.pgm_path = b.pgm_path AND substr(a.file_name,1,instr(a.file_name,'.')-1) = substr(b.file_name,1,instr(b.file_name,'.')-1);
SELECT * FROM targets a INNER JOIN elements_t b ON a.pgm_path = b.pgm_path;
SELECT * FROM elements_t WHERE REGEXP_LIKE(file_path,'C:\\xFrame\\project\\DSI\\screen\\NTREE','i') ; -- ntree, conv 모두 포함되어 있음
SELECT * FROM targets WHERE REGEXP_LIKE(file_name,'bdm001l|bdm071l','i') ;

SELECT * FROM target_elements WHERE REGEXP_LIKE(file_path,'bdm001l','i') AND REGEXP_LIKE(attr_name,'^on','i') ORDER BY file_path,element_id;
SELECT file_path,count(*) FROM target_elements GROUP BY file_path ORDER BY file_path;

DROP TABLE ntree_elements;
CREATE TABLE ntree_elements AS SELECT * FROM target_elements WHERE REGEXP_LIKE(file_path,'^c:\\ntree','i'); 
DROP TABLE conv_elements;
CREATE TABLE conv_elements AS SELECT * FROM target_elements WHERE REGEXP_LIKE(file_path,'^C:\\xFrame','i'); 
CREATE TABLE conv_elements_ori AS SELECT * FROM target_elements WHERE REGEXP_LIKE(file_path,'^C:\\conv_result','i'); 

SELECT * FROM ntree_elements WHERE REGEXP_LIKE(file_path,'.*','i') AND REGEXP_LIKE(element_name,'.*','i') AND REGEXP_LIKE(attr_name,'url','i') AND REGEXP_LIKE(attr_value,'BDM084P_Sub04','i') ORDER BY file_path,element_id  ;
CREATE TABLE ntree_link as
SELECT pgm_path,substr(attr_value,5,length(attr_value)-4) file_name FROM ntree_elements WHERE REGEXP_LIKE(file_path,'.*','i') AND REGEXP_LIKE(element_name,'.*','i') AND REGEXP_LIKE(attr_name,'url','i') AND REGEXP_LIKE(attr_value,'.*xfdl','i') ORDER BY file_path,element_id  ;
SELECT * FROM targets a FULL OUTER JOIN ntree_link b ON a.pgm_path = b.pgm_path AND a. file_name = b.file_name  WHERE a.file_name IS NULL ORDER BY a.pgm_path,a.file_name;
SELECT * FROM targets a FULL OUTER JOIN ntree_link b ON a.pgm_path = b.pgm_path AND a. file_name = b.file_name  WHERE a.file_name IS NOT NULL AND b.file_name IS NOT NULL ORDER BY a.pgm_path,a.file_name;
SELECT * FROM targets WHERE manager IS null;
SELECT * FROM ntree_link;
SELECT * FROM ntree_elements WHERE REGEXP_LIKE(file_path,'.*BDM103U','i') AND element_id IN (287,286,285)  ORDER BY file_path,element_id, attr_name;
SELECT * FROM dba_tab_cols WHERE REGEXP_LIKE(table_name,'^ntree_elements$','i') ORDER BY column_id ;
SELECT * FROM dba_tab_cols WHERE REGEXP_LIKE(table_name,'^target_elements$','i') ORDER BY column_id ;
SELECT * FROM dba_tab_cols WHERE REGEXP_LIKE(table_name,'^elements$','i') ORDER BY column_id ;

SELECT * FROM conv_elements  ;
SELECT * FROM target_jsfunctions a INNER JOIN (SELECT * FROM conv_elements WHERE attr_name = 'name') b ON a.NEW_FILE_PATH =b.NEW_file_path AND a.FUNCTION_NAME = b.attr_value;
SELECT NEW_FILE_PATH,upper(attr_value) FROM conv_elements WHERE attr_name = 'name' ;
SELECT new_file_path,id,count(*) FROM (SELECT NEW_FILE_PATH,upper(attr_value) id FROM conv_elements WHERE attr_name = 'name' ) GROUP BY new_file_path,id HAVING count(*) > 1 ORDER BY new_file_path;

-- CREATE TABLE grid_all AS
-- CREATE TABLE grid_bind AS  
-- create TABLE combos as
-- create table radios as 
-- create table edits as 
DROP TABLE allcomps;
DELETE FROM NTREE_ELEMENTS ne WHERE REGEXP_LIKE(file_path,'DBSB\.nTreeWorks.+bdm029l|DBSB\.nTreeWorks.+bdm977l|DBSB\.nTreeWorks.+bdm953l','i');
COMMIT;
-- CREATE TABLE allcomps AS 
SELECT * FROM NTREE_ELEMENTS ne WHERE REGEXP_LIKE(file_path,'BDM103P_TSub04','i') AND REGEXP_LIKE(element_name,'.*','i') AND  REGEXP_LIKE(attr_name,'color','i') AND REGEXP_LIKE(attr_value,'.*','i')  ORDER BY file_path,element_id,attr_name;
SELECT * FROM NTREE_ELEMENTS ne WHERE REGEXP_LIKE(file_path,'bdm081l','i') AND REGEXP_LIKE(element_name,'.*','i') AND REGEXP_LIKE(attr_name,'expr','i') AND REGEXP_LIKE(attr_value,'.*','i')  ORDER BY file_path,element_id,attr_name;
SELECT * FROM NTREE_ELEMENTS ne WHERE REGEXP_LIKE(file_path,'.*','i') AND REGEXP_LIKE(attr_name,'.*','i') AND REGEXP_LIKE(attr_value,'BDM103U_TSub01C','i')  ORDER BY file_path,element_id;
SELECT * FROM NTREE_ELEMENTS ne WHERE REGEXP_LIKE(file_path,'cpa301p','i') AND REGEXP_LIKE(element_name,'rows','i') AND REGEXP_LIKE(parent_name,'dataset','i') ORDER BY file_path,element_id  ;
SELECT element_name,attr_name,attr_value,count(*) FROM ntree_elements WHERE REGEXP_LIKE(element_name,'combo','i') AND REGEXP_LIKE(attr_name,'enable','i') GROUP BY element_name,attr_name,attr_value ORDER by element_name,attr_name,attr_value;
SELECT * FROM ntree_elements WHERE regexp_like(file_path,'bdm081l','i') AND element_id in(6) ORDER BY file_path,element_id,attr_name;
SELECT * FROM NTREE_ELEMENTS ne WHERE REGEXP_LIKE(file_path,'cpa301p','i') AND REGEXP_LIKE(element_name,'dataset','i') AND  REGEXP_LIKE(attr_name,'^id$','i') AND REGEXP_LIKE(attr_value,'.*','i')  
 AND element_id IN (SELECT parent_id FROM NTREE_ELEMENTS ne WHERE REGEXP_LIKE(element_name,'rows','i') AND REGEXP_LIKE(parent_name,'dataset','i') ) ORDER BY file_path,element_id,attr_name;
SELECT * FROM ntree_elements WHERE REGEXP_LIKE(file_path,'cpa301p','i') AND  REGEXP_LIKE(parent_name,'rows','i');
SELECT file_path,parent_id,attr_name,count(*) FROM NTREE_ELEMENTS ne 
WHERE REGEXP_LIKE(attr_name,'text','i') AND REGEXP_LIKE(element_name,'cell','i') AND REGEXP_LIKE(attr_value,'^[^bind|expr]','i') AND parent_id IN (SELECT element_id FROM grid_summary)  
GROUP BY file_path,parent_id,attr_name HAVING count(*) > 1 ORDER BY file_path; 
SELECT * FROM NTREE_ELEMENTS ne WHERE parent_name = 'Format' AND attr_name = 'id' AND attr_value = 'summary';
CREATE TABLE datasetrows AS SELECT * FROM NTREE_ELEMENTS WHERE REGEXP_LIKE(element_name,'rows','i') AND REGEXP_LIKE(parent_name,'dataset','i') ;
--SELECT file_path FROM (
SELECT SUBSTR(file_path,instr(file_path,'\',-1)+1,LENGTH(file_path) - instr(file_path,'\',-1) -5) filename, ne.file_path,'    '||ne.ds_name||'.insertrow(0);' FROM (SELECT file_path,ds_name,count(*) rowcnt FROM dscols  GROUP BY file_path,ds_name HAVING count(*) = 1) ne ORDER BY ne.file_path,ne.ds_name;
--) t1 GROUP BY file_path;
SELECT file_path,ds_name,count(*) rowcnt FROM dscols WHERE  REGEXP_LIKE(file_path,'cpa301p','i') GROUP BY file_path,ds_name HAVING count(*) = 1 ;
--데이터셋에는 columninfo 와 ROWS 가 있다. 즉, element가 ROW 이면서 parent가 dataset 이면 한개의 ROW 이상인 건들이다. 
CREATE TABLE dsnames AS SELECT file_path,element_name ds_element_name,element_id ds_element_id,attr_value ds_name FROM ntree_elements WHERE REGEXP_LIKE(element_name,'dataset','i') AND regexp_like(parent_name,'objects','i') AND REGEXP_LIKE(attr_name,'^id$','i');
CREATE TABLE dsrows AS SELECT dn.*,ne.ELEMENT_name rows_element_name,ne.element_id rows_element_id FROM dsnames dn INNER JOIN ntree_elements ne ON dn.file_path = ne.file_path AND dn.ds_element_id = ne.parent_id WHERE REGEXP_LIKE(ne.element_name,'rows','i') AND  REGEXP_LIKE(ne.parent_name,'dataset','i') ;
SELECT file_path,ds_name,count(*) FROM dscols WHERE  REGEXP_LIKE(file_path,'cpa301p','i') GROUP BY file_path,ds_name;
CREATE TABLE dsrows1 AS SELECT dr.*,ne.element_name row_element_name,ne.element_id row_element_id FROM dsrows dr INNER JOIN NTREE_ELEMENTS ne ON dr.file_path = ne.FILE_PATH AND dr.rows_element_id = ne.PARENT_ID ;
DROP TABLE dscols;
CREATE TABLE dscols AS SELECT dr.*,ne.element_name col_element_name,ne.element_id col_element_id FROM dsrows1 dr LEFT OUTER JOIN NTREE_ELEMENTS ne ON dr.file_path = ne.FILE_PATH AND dr.row_element_id = ne.parent_id ;
SELECT * FROM ntree_elements WHERE REGEXP_LIKE(file_path,'cpa301p','i') AND REGEXP_LIKE(element_name,'rows','i') AND  REGEXP_LIKE(parent_name,'dataset','i');
SELECT * FROM datasetrows WHERE REGEXP_LIKE(file_path,'cpa301p','i') ORDER BY element_id;
SELECT * FROM datasetrows1 WHERE REGEXP_LIKE(file_path,'cpa301p','i') ORDER BY element_id;
DROP TABLE datasetrows1;
CREATE TABLE datasetrows1 AS SELECT ne.*,dr.element_name rows_element_name,dr.element_id rows_element_id FROM ntree_elements ne INNER JOIN datasetrows dr ON ne.FILE_PATH = dr.file_path AND ne.parent_id = dr.element_id AND ne.attr_name = 'id';
SELECT ne.*,dr.element_id row_element_id FROM ntree_elements ne INNER JOIN datasetrows1 dr ON ne.FILE_PATH = dr.file_path AND ne.parent_id = dr.row_element_id WHERE REGEXP_LIKE(ne.file_path,'cpa301p','i');
-- 부모화면에 링크되어 있으면서 부모화면의 데이터셋에 바인딩 되어 있는 화면 목록
CREATE TABLE ntree_bind_grid AS 
SELECT * FROM NTREE_ELEMENTS WHERE attr_name = 'binddataset';
SELECT * FROM ntree_bind_grid;
SELECT * FROM ntree_bind_grid a LEFT OUTER JOIN ntree_bind b ON a.file_path = b.file_path AND a.attr_value = b.datasetid WHERE b.file_path IS NOT null ORDER BY a.file_path,a.attr_value;
SELECT * FROM ntree_bind WHERE REGEXP_LIKE(file_path,'.*','i') AND regexp_like(DATASETID,'ds_param','i') ORDER BY file_path,element_id;
SELECT * FROM ntree_bind WHERE propid = 'text' ;
SELECT * FROM ntree_elements WHERE element_name = 'Dataset' AND attr_name = 'id' AND attr_value NOT IN ('innerdataset');
SELECT file_path,datasetid,count(*) FROM (
SELECT * FROM ntree_bind WHERE propid = 'value' 
 and (file_path,datasetid) NOT IN (SELECT file_path,attr_value FROM ntree_elements WHERE element_name = 'Dataset' AND attr_name = 'id' AND attr_value NOT IN ('innerdataset')) ) x GROUP BY file_path,datasetid;
-- 이벤트에 정의 되어 있으나, 구현안되어 있는 함수 
SELECT * FROM ntree_ids_onevents a LEFT OUTER JOIN TARGET_JSFUNCTIONS b ON a.new_file_path = b.NEW_FILE_PATH AND a.event_handler = b.FUNCTION_NAME 
WHERE REGEXP_LIKE(a.file_path,'LNC077P','i') AND  b.FUNCTION_NAME IS NULL ORDER BY a.FILE_PATH ,a.event_handler;
SELECT * FROM ntree_ids_onevents ne  ;
SELECT * FROM TARGET_JSFUNCTIONS tj ;
SELECT * FROM grid_all a LEFT OUTER JOIN grid_bind b ON a.file_path = b.file_path AND a.element_id = b.element_id WHERE b.file_path  IS NULL;
20240504
DELETE FROM conv_elements WHERE REGEXP_LIKE(file_path,'project.+DSI.+bdm029l|project.+DSI.+bdm977l|project.+DSI.+bdm953l','i');
COMMIT;
SELECT * FROM conv_elements WHERE REGEXP_LIKE(FILE_PATH,'bdm103p_tsub11','i') AND REGEXP_LIKE(element_name,'datas','i') AND REGEXP_LIKE(attr_name,'.*','i') AND REGEXP_LIKE(attr_value,'.*','i') ORDER BY file_path,element_id ;
SELECT * FROM conv_elements WHERE REGEXP_LIKE(FILE_PATH,'bdm103p_tsub03','i') AND element_id IN (173,200,207,208) ORDER BY file_path,element_id ;
SELECT * FROM conv_elements WHERE REGEXP_LIKE(FILE_PATH,'bdm103p_tsub17','i') AND REGEXP_LIKE(attr_value,'s_acco_no','i') ORDER BY file_path,element_id,attr_name;
SELECT * FROM conv_elements WHERE REGEXP_LIKE(FILE_PATH,'bdm103u','i') AND NOT REGEXP_LIKE(element_name,'.*','i')  AND REGEXP_LIKE(attr_name,'.*','i')  AND REGEXP_LIKE(attr_value,'getAGREEPOP','i') ORDER BY file_path,attr_value,element_id;
SELECT * FROM conv_elements WHERE REGEXP_LIKE(ATTR_NAME,'statistics_row','i') AND ATTR_VALUE IS NOT NULL; 
SELECT file_path,CONTROL_ID ,name, statistics_row FROM XF_GRID xg WHERE REGEXP_LIKE(file_path,'.*','i') AND STATISTICS_ROW IS NOT NULL ORDER BY file_path;
SELECT file_path,name,pattern FROM XF_NUMERICEX_FIELD xnf WHERE REGEXP_LIKE(HORZ_ALIGN,'0|2','i') AND (APPLY_RIGHTPATTERN IS NULL OR APPLY_RIGHTPATTERN <> '1')  ORDER BY file_path,element_id;
SELECT 'path.node.id.name == "'||evfunc||'" || ' FROM (SELECT REGEXP_SUBSTR(attr_value,'^eventfunc:(.*)\(',1,1,'i',1) evfunc FROM elements_t 
 WHERE REGEXP_LIKE(FILE_PATH,'_SYS|bdm081l|bdm082p|lnc002u|bdm103u|bdm001l|cmc033p|cmc315p','i') AND REGEXP_LIKE(element_name,'.*','i') AND REGEXP_LIKE(attr_name,'^on_','i') AND REGEXP_LIKE(attr_value,'.*','i') ) t
GROUP BY evfunc ORDER BY evfunc ;
SELECT * FROM xf_timer ORDER BY file_path,element_id;
SELECT * FROM conv_elements_ori  WHERE REGEXP_LIKE(FILE_PATH,'bdm103p_tsub03','i') AND REGEXP_LIKE(element_name,'.*','i') AND REGEXP_LIKE(attr_name,'fore_color','i') AND REGEXP_LIKE(attr_value,'.*','i') ORDER BY file_path,element_id ;
SELECT * FROM conv_elements_ori WHERE REGEXP_LIKE(FILE_PATH,'bdm103p_tsub03','i') AND element_id IN (9,40,56,83,90,91,114) ORDER BY file_path,element_id ;
SELECT * FROM conv_elements_ori a LEFT OUTER JOIN conv_elements b ON a.new_file_path = b.NEW_FILE_PATH AND a.

-- link_data
DROP TABLE link_datas;
CREATE TABLE link_datas AS 
SELECT file_path,ELEMENT_ID,substr(attr_value,1,INSTR(attr_value,':')-1) dsname,substr(attr_value,INSTR(attr_value,':')+1) colname,attr_value FROM conv_elements WHERE REGEXP_LIKE(FILE_PATH,'.*','i') AND REGEXP_LIKE(element_name,'.*','i') AND REGEXP_LIKE(attr_name,'link_data','i') AND REGEXP_LIKE(attr_value,'.*','i') ORDER BY file_path,element_id ;
DROP TABLE add_columns ;
CREATE TABLE add_columns AS 
SELECT a.file_path,a.element_id,a.dsname,a.colname,b.col_name,b.col_desc,b.col_length,b.col_data,b.col_order 
FROM (SELECT * FROM link_datas WHERE dsname IS NOT NULL) a LEFT OUTER JOIN xdatasets b ON a.file_path = b.file_path 
 AND a.dsname = b.ds_name 
 AND a.colname = b.col_name
WHERE REGEXP_LIKE(a.file_path,'.*','i') AND b.file_path IS null
ORDER BY a.file_path,a.element_id;

SELECT * FROM link_datas WHERE REGEXP_LIKE(file_path,'tsub11','i') ;
SELECT * FROM xdatasets WHERE REGEXP_LIKE(file_path,'tsub11','i') AND REGEXP_LIKE(ds_name,'.*','i') ORDER BY file_path,ds_name,col_order;

SELECT * FROM add_columns ORDER BY file_path,element_id;
SELECT file_path,element_name,element_id,attr_value control_id FROM elements WHERE attr_name = 'control_id';
SELECT file_path,element_id,dsname,colname,element_name,control_id FROM (
SELECT a.file_path,a.element_id,a.dsname,a.colname,b.element_name,b.control_id FROM add_columns a LEFT OUTER JOIN (SELECT file_path,element_name,element_id,attr_value control_id FROM elements WHERE attr_name = 'control_id') B 
ON a.file_path = b.file_path AND a.element_id = b.element_id 
ORDER BY a.file_path,a.element_id) t
GROUP BY file_path,element_id,dsname,colname,element_name,control_id
ORDER BY file_path,element_id;

--SELECT * FROM conv_elements WHERE REGEXP_LIKE(FILE_PATH,'bdm103p_tsub11','i') AND REGEXP_LIKE(attr_value,'res_code','i') ; 
SELECT * FROM conv_elements WHERE REGEXP_LIKE(FILE_PATH,'bdm103p_tsub11','i') AND REGEXP_LIKE(element_name,'dataset','i') ; 
DROP TABLE forecolorlist;
CREATE TABLE forecolorlist AS SELECT t1.file_path,t1.new_file_path,t1.element_name,t1.element_id,t1.attr_value,COALESCE (SUBSTR(t1.attr_value,0,INSTR(t1.attr_value,':')-1),t1.attr_value) dsname, SUBSTR(t1.attr_value,INSTR(t1.attr_value,':')+1) colname, t2.attr_value control_id FROM 
(SELECT file_path,new_file_path,ELEMENT_NAME,element_id,attr_value FROM conv_elements WHERE REGEXP_LIKE(FILE_PATH,'.*','i') AND REGEXP_LIKE(element_name,'.*','i')  AND REGEXP_LIKE(attr_name,'^fore_color','i')  AND REGEXP_LIKE(attr_value,'.*','i') ) t1
LEFT OUTER JOIN 
(SELECT file_path,new_file_path,ELEMENT_NAME,element_id,attr_value FROM conv_elements WHERE REGEXP_LIKE(FILE_PATH,'.*','i') AND REGEXP_LIKE(element_name,'.*','i')  AND REGEXP_LIKE(attr_name,'^control_id','i')  AND REGEXP_LIKE(attr_value,'.*','i') ) t2
ON t1.file_path = t2.file_path AND t1.element_id = t2.element_id
ORDER BY t1.file_path,t1.attr_value,t1.element_id;
SELECT * FROM FORECOLORLIST ;
SELECT file_path,element_name,element_id,attr_value,dsname,colname,comp_name FROM bindlist  WHERE REGEXP_LIKE(file_path,'bdm103u_tsub01c','i') AND REGEXP_LIKE(dsname,'.*','i') ORDER BY file_path,dsname,dsname,element_id;


DROP TABLE bindlist;
CREATE TABLE bindlist AS SELECT t1.file_path,t1.element_name,t1.element_id,t1.attr_value,COALESCE (SUBSTR(t1.attr_value,0,INSTR(t1.attr_value,':')-1),t1.attr_value) dsname, SUBSTR(t1.attr_value,INSTR(t1.attr_value,':')+1) colname, t2.attr_value comp_name FROM 
(SELECT file_path,ELEMENT_NAME,element_id,attr_value FROM conv_elements WHERE REGEXP_LIKE(FILE_PATH,'.*','i') AND NOT REGEXP_LIKE(element_name,'data','i')  AND REGEXP_LIKE(attr_name,'link_data','i')  AND REGEXP_LIKE(attr_value,'.*','i') ) t1
LEFT OUTER JOIN 
(SELECT file_path,ELEMENT_NAME,element_id,attr_value FROM conv_elements WHERE REGEXP_LIKE(FILE_PATH,'.*','i') AND NOT REGEXP_LIKE(element_name,'data','i')  AND REGEXP_LIKE(attr_name,'^name$','i')  AND REGEXP_LIKE(attr_value,'.*','i') ) t2
ON t1.file_path = t2.file_path AND t1.element_id = t2.element_id
ORDER BY t1.file_path,t1.attr_value,t1.element_id;
SELECT file_path,element_name,element_id,attr_value,dsname,colname,comp_name FROM bindlist  WHERE REGEXP_LIKE(file_path,'bdm103u_tsub01c','i') AND REGEXP_LIKE(dsname,'.*','i') ORDER BY file_path,dsname,dsname,element_id;

-- 
DROP TABLE conv_elements_style;
CREATE TABLE conv_elements_style as
SELECT file_path,element_name,element_id,max(control_name) control_name ,max(control_id) control_id,max(style_name) style_name FROM ( 
SELECT file_path,element_name,element_id,attr_value control_name,'' control_id,'' style_name FROM conv_elements WHERE REGEXP_LIKE(FILE_PATH,'.*','i') AND REGEXP_LIKE(attr_name,'^name$','i')
UNION all
SELECT file_path,element_name,element_id,'' control_name,attr_value control_id,'' style_name FROM conv_elements WHERE REGEXP_LIKE(FILE_PATH,'.*','i') AND REGEXP_LIKE(attr_name,'^control_id$','i')
UNION all
SELECT file_path,element_name,element_id,'' control_name,'' control_id,attr_value style_name FROM conv_elements WHERE REGEXP_LIKE(FILE_PATH,'.*','i') AND REGEXP_LIKE(attr_name,'^style$','i') ) T
GROUP BY file_path,element_name,element_id ORDER BY file_path,element_name,element_id;

SELECT * FROM conv_elements_style ORDER BY file_path,control_name;
SELECT * FROM combos WHERE attr_name IN ('index','value') ORDER BY file_path,element_id,attr_name;
SELECT file_path,element_id,count(*) FROM radios WHERE attr_name IN ('index','value') GROUP BY file_path,element_id HAVING count(*) <> 2 ORDER BY file_path,element_id;
SELECT * FROM radios WHERE (file_path,element_id) IN (SELECT file_path,element_id FROM radios WHERE attr_name IN ('index','value') GROUP BY file_path,element_id HAVING count(*) <> 2 ) AND attr_name IN ('index','value') ORDER BY file_path,element_id;
SELECT * FROM edits;
SELECT * FROM allcomps WHERE NOT REGEXP_LIKE(element_name,'column|col|band','i') ;
SELECT file_path,parent_id,attr_value,count(*) FROM allcomps WHERE NOT REGEXP_LIKE(element_name,'column|col|band','i') GROUP BY file_path,parent_id,attr_value HAVING count(*) > 1; 
-- 
CREATE TABLE elements_hint AS 
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'screen_rev_last','i') ;
CREATE TABLE elements_hint_before AS 
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'screen_0613_hint','i') ;
CREATE TABLE elements_hint_0613 AS 
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'conv_result.+screen_0613_hint','i') ;

SELECT * FROM elements_hint a FULL OUTER JOIN elements_hint_0613 b ON 
a.file_name  =b.file_name AND a.element_id = b.element_id AND a.attr_name = b.attr_name 
WHERE REGEXP_LIKE(a.FILE_PATH,'bdm103p_tsub07','i') AND b.file_name IS null;
SELECT * FROM elements_hint WHERE REGEXP_LIKE(file_path,'bdm103p_tsub07','i') AND element_name = 'column' AND parent_id = 10 ORDER BY file_path,element_id,attr_name;  
SELECT * FROM elements_hint_before WHERE REGEXP_LIKE(file_path,'bdm103p_tsub07','i') AND element_name = 'column' AND parent_id = 10 ORDER BY file_path,element_id,attr_name; 
SELECT * FROM elements_hint_0613 WHERE REGEXP_LIKE(file_path,'bdm103p_tsub07','i') AND element_name = 'column' AND parent_id = 10 ORDER BY file_path,element_id,attr_name; 
SELECT * FROM elements_hint WHERE REGEXP_LIKE(file_path,'bdm103p_tsub07','i') ORDER BY file_path,element_id,attr_name;
SELECT * FROM elements_hint_before WHERE REGEXP_LIKE(file_path,'bdm103p_tsub07','i') ORDER BY file_path,element_id,attr_name;
SELECT a.*,b.attr_name,b.attr_value
	FROM 
(SELECT * FROM elements_hint WHERE attr_name IS NOT NULL) a FULL OUTER JOIN (SELECT * FROM elements_hint_before WHERE attr_name IS NOT NULL) b 
ON a.file_name = b.file_name AND a.element_name = b.element_name AND a.element_id = b.element_id AND a.attr_name = b.attr_name AND a.attr_value = b.attr_value
WHERE REGEXP_LIKE(a.file_path,'bdm103p_tsub07','i') AND b.file_path IS NULL ORDER BY  a.file_path,a.element_id,a.attr_name;


WHERE REGEXP_LIKE(a.file_path,'bdm103p_tsub07','i') AND a.file_path IS NULL OR b.file_path IS NULL ORDER BY a.file_path, a.element_id,a.attr_name, b.file_path,b.element_id,b.attr_name;

-- on_event 정보 
DROP TABLE ntree_onevents;
CREATE TABLE ntree_onevents AS SELECT * FROM ntree_elements WHERE REGEXP_LIKE(attr_name,'^on','i'); 
SELECT * FROM ntree_onevents WHERE REGEXP_LIKE(file_path,'bdm001l','i') ORDER BY file_path,element_id;
DROP TABLE ntree_ids;
CREATE TABLE ntree_ids AS SELECT * FROM ntree_elements WHERE REGEXP_LIKE(attr_name,'^id$','i');
DROP TABLE ntree_ids_onevents;
CREATE TABLE ntree_ids_onevents AS SELECT REPLACE(substr(a.file_path,44,instr(a.file_path,'.',-1)-44),'\\','\') new_file_path,a.file_path,a.element_id,a.element_name,a.attr_value id,b.attr_name event_name,b.attr_value event_handler FROM ntree_ids a LEFT OUTER JOIN ntree_onevents b ON a.file_path = b.file_path AND a.element_id = b.element_id WHERE b.element_id IS NOT null;
SELECT * from ntree_ids;
SELECT * FROM ntree_onevents;
DROP TABLE ntree_onevents;
CREATE TABLE ntree_onevents AS 
SELECT REPLACE(substr(file_path,44,instr(file_path,'.',-1)-44),'\\','\') new_file_path,file_path,element_id,element_name,id,class,inputtype,maxlength,readonly,autoselect,mask,limitbymask FROM 
(
SELECT file_path,element_id,element_name,max(id) id,max(class) class, max(inputtype) inputtype, max(maxlength) maxlength, max(readonly) readonly, max(autoselect) autoselect, max(mask) mask, max(limitbymask) limitbymask FROM (
SELECT file_path,element_id,element_name,attr_value id,'' class,'' inputtype,'' maxlength,'' readonly,'' autoselect,'' mask,'' limitbymask FROM ntree_elements WHERE element_name = 'Edit' AND attr_name = 'id'
UNION all
SELECT file_path,element_id,element_name,'' id,attr_value class,'' inputtype,'' maxlength,'' readonly,'' autoselect,'' mask,'' limitbymask FROM ntree_elements WHERE element_name = 'Edit' AND attr_name = 'class'
UNION all
SELECT file_path,element_id,element_name,'' id,'' class,attr_value inputtype,'' maxlength,'' readonly,'' autoselect,'' mask,'' limitbymask FROM ntree_elements WHERE element_name = 'Edit' AND attr_name = 'inputtype'
UNION all
SELECT file_path,element_id,element_name,'' id,'' class,'' inputtype,attr_value maxlength,'' readonly,'' autoselect,'' mask,'' limitbymask FROM ntree_elements WHERE element_name = 'Edit' AND attr_name = 'maxlength'
UNION all
SELECT file_path,element_id,element_name,'' id,'' class,'' inputtype,'' maxlength,attr_value readonly,'' autoselect,'' mask,'' limitbymask FROM ntree_elements WHERE element_name = 'Edit' AND attr_name = 'readonly'
UNION all
SELECT file_path,element_id,element_name,'' id,'' class,'' inputtype,'' maxlength,'' readonly,attr_value autoselect,'' mask,'' limitbymask FROM ntree_elements WHERE element_name = 'Edit' AND attr_name = 'autoselect'
UNION all
SELECT file_path,element_id,element_name,'' id,'' class,'' inputtype,'' maxlength,'' readonly,'' autoselect,attr_value mask,'' limitbymask FROM ntree_elements WHERE element_name = 'Edit' AND attr_name = 'mask'
UNION all
SELECT file_path,element_id,element_name,'' id,'' class,'' inputtype,'' maxlength,'' readonly,'' autoselect,'' mask,attr_value limitbymask FROM ntree_elements WHERE element_name = 'Edit' AND attr_name = 'limitbymask') T
GROUP BY file_path,element_id,element_name
ORDER BY file_path,element_id,element_name ) tt
;

-- edit 정보 
DROP TABLE ntree_edit;
CREATE TABLE ntree_edit AS 
SELECT REPLACE(substr(file_path,44,instr(file_path,'.',-1)-44),'\\','\') new_file_path,file_path,element_id,element_name,id,class,inputtype,maxlength,readonly,autoselect,mask,limitbymask FROM 
(
SELECT file_path,element_id,element_name,max(id) id,max(class) class, max(inputtype) inputtype, max(maxlength) maxlength, max(readonly) readonly, max(autoselect) autoselect, max(mask) mask, max(limitbymask) limitbymask FROM (
SELECT file_path,element_id,element_name,attr_value id,'' class,'' inputtype,'' maxlength,'' readonly,'' autoselect,'' mask,'' limitbymask FROM ntree_elements WHERE element_name = 'Edit' AND attr_name = 'id'
UNION all
SELECT file_path,element_id,element_name,'' id,attr_value class,'' inputtype,'' maxlength,'' readonly,'' autoselect,'' mask,'' limitbymask FROM ntree_elements WHERE element_name = 'Edit' AND attr_name = 'class'
UNION all
SELECT file_path,element_id,element_name,'' id,'' class,attr_value inputtype,'' maxlength,'' readonly,'' autoselect,'' mask,'' limitbymask FROM ntree_elements WHERE element_name = 'Edit' AND attr_name = 'inputtype'
UNION all
SELECT file_path,element_id,element_name,'' id,'' class,'' inputtype,attr_value maxlength,'' readonly,'' autoselect,'' mask,'' limitbymask FROM ntree_elements WHERE element_name = 'Edit' AND attr_name = 'maxlength'
UNION all
SELECT file_path,element_id,element_name,'' id,'' class,'' inputtype,'' maxlength,attr_value readonly,'' autoselect,'' mask,'' limitbymask FROM ntree_elements WHERE element_name = 'Edit' AND attr_name = 'readonly'
UNION all
SELECT file_path,element_id,element_name,'' id,'' class,'' inputtype,'' maxlength,'' readonly,attr_value autoselect,'' mask,'' limitbymask FROM ntree_elements WHERE element_name = 'Edit' AND attr_name = 'autoselect'
UNION all
SELECT file_path,element_id,element_name,'' id,'' class,'' inputtype,'' maxlength,'' readonly,'' autoselect,attr_value mask,'' limitbymask FROM ntree_elements WHERE element_name = 'Edit' AND attr_name = 'mask'
UNION all
SELECT file_path,element_id,element_name,'' id,'' class,'' inputtype,'' maxlength,'' readonly,'' autoselect,'' mask,attr_value limitbymask FROM ntree_elements WHERE element_name = 'Edit' AND attr_name = 'limitbymask') T
GROUP BY file_path,element_id,element_name
ORDER BY file_path,element_id,element_name ) tt
;

SELECT DISTINCT attr_name FROM NTREE_ELEMENTS ne WHERE REGEXP_LIKE(attr_name,'^on','i') ORDER BY 1;

SELECT * FROM ntree_edit WHERE inputtype IN ('alpha','english') ORDER BY new_file_path,id;

DROP TABLE conv_edit;
CREATE TABLE conv_edit AS 
SELECT REPLACE(substr(file_path,21,instr(file_path,'.',-1)-21),'\\','\') new_file_path,file_path,element_id,element_name,name,style_xf,input_type,maxlength,default_value,enable FROM 
(
SELECT file_path,element_id,element_name,max(name) name,max(style_xf) style_xf, max(input_type) input_type, max(maxlength) maxlength, max(default_value) default_value, max(enable) enable FROM (
SELECT file_path,element_id,element_name,attr_value name,'' style_xf,'' input_type,'' maxlength,'' default_value,'' enable FROM conv_elements WHERE element_name IN ('hangul_field','numericex_field','normal_field') AND attr_name = 'name'
UNION all
SELECT file_path,element_id,element_name,'' name,attr_value style_xf,'' input_type,'' maxlength,'' default_value,'' enable FROM conv_elements WHERE element_name = 'Edit' AND attr_name = 'style'
UNION all
SELECT file_path,element_id,element_name,'' name,'' style_xf,attr_value input_type,'' maxlength,'' default_value,'' enable FROM conv_elements WHERE element_name = 'Edit' AND attr_name = 'input_type' -- 선택/필수/잠금
UNION all
SELECT file_path,element_id,element_name,'' name,'' style_xf,'' input_type,attr_value maxlength,'' default_value,'' enable FROM conv_elements WHERE element_name = 'Edit' AND attr_name = 'maxlength'
UNION all
SELECT file_path,element_id,element_name,'' name,'' style_xf,'' input_type,'' maxlength,attr_value default_value,'' enable FROM conv_elements WHERE element_name = 'Edit' AND attr_name = 'default_value'
UNION all
SELECT file_path,element_id,element_name,'' name,'' style_xf,'' input_type,'' maxlength,'' default_value,attr_value enable FROM conv_elements WHERE element_name = 'Edit' AND attr_name = 'enable') T
GROUP BY file_path,element_id,element_name
ORDER BY file_path,element_id,element_name ) tt
;
SELECT * FROM conv_edit ORDER BY new_file_path,element_id;

SELECT a.new_file_path,a.element_id,a.element_name,a.id,a.inputtype,b.element_name,b.name FROM ntree_edit a LEFT OUTER JOIN conv_edit b ON a.new_file_path = b.new_file_path AND a.id = b.name
WHERE a.inputtype IS NOT NULL AND a.inputtype NOT IN ('full','half','numberandenglish','alpha','english') ORDER BY a.new_file_path,a.element_id;  -- 숫자필드으로 변환되어야하는 목록

SELECT a.new_file_path,a.element_id,a.element_name,a.id,a.inputtype,b.element_name,b.name FROM ntree_edit a LEFT OUTER JOIN conv_edit b ON a.new_file_path = b.new_file_path AND a.id = b.name
WHERE a.inputtype IS NOT NULL AND a.inputtype NOT IN ('full','half','number','digit','number,dot') ORDER BY a.new_file_path,a.element_id;  -- 일반필드로 변환되어야하는 목록

SELECT * FROM conv_elements WHERE REGEXP_LIKE(element_name,'field','i') ORDER BY file_path,element_id,attr_name;

-- onclick 과 onmouseup 중복확인, onkeyup과 onkeydown 중복확인
SELECT DISTINCT attr_name FROM NTREE_ELEMENTS ne WHERE REGEXP_LIKE(file_path,'.*','i') AND REGEXP_LIKE(element_name,'.*','i') AND REGEXP_LIKE(attr_name,'on.+','i') AND REGEXP_LIKE(attr_value,'.*','i')  ORDER BY 1;

DROP TABLE ntree_onevent;
-- CREATE TABLE ntree_onevent (new_file_path varchar2(64), file_path varchar2(512), element_id NUMBER, element_name varchar2(64), onkeydown varchar2(512), onkeyup varchar2(512), onlbuttondown varchar2(512), onlbuttonup varchar2(512), onrbuttondown varchar2(512));
CREATE TABLE ntree_onevent AS
-- INSERT INTO ntree_onevent  
SELECT REPLACE(substr(file_path,44,instr(file_path,'.',-1)-44),'\\','\') new_file_path,file_path,element_id,element_name,onkeydown,onkeyup,onlbuttondown,onlbuttonup,onrbuttondown,onclick FROM 
(
SELECT file_path,element_id,element_name,max(onkeydown) onkeydown, max(onkeyup) onkeyup, max(onlbuttondown) onlbuttondown, max(onlbuttonup) onlbuttonup, max(onrbuttondown) onrbuttondown , max(onclick) onclick FROM (
SELECT file_path,element_id,element_name,attr_value onkeydown,'' onkeyup,'' onlbuttondown,'' onlbuttonup,'' onrbuttondown,'' onclick FROM ntree_elements WHERE attr_name = 'onkeydown'
UNION all
SELECT file_path,element_id,element_name,'' onkeydown,attr_value onkeyup,'' onlbuttondown,'' onlbuttonup,'' onrbuttondown,'' onclick FROM ntree_elements WHERE attr_name = 'onkeyup'
UNION all
SELECT file_path,element_id,element_name,'' onkeydown,'' onkeyup,attr_value onlbuttondown,'' onlbuttonup,'' onrbuttondown,'' onclick FROM ntree_elements WHERE attr_name = 'onlbuttondown'
UNION all
SELECT file_path,element_id,element_name,'' onkeydown,'' onkeyup,'' onlbuttondown,attr_value onlbuttonup,'' onrbuttondown,'' onclick FROM ntree_elements WHERE attr_name = 'onlbuttonup'
UNION all
SELECT file_path,element_id,element_name,'' onkeydown,'' onkeyup,'' onlbuttondown,'' onlbuttonup,attr_value onrbuttondown,'' onclick FROM ntree_elements WHERE attr_name = 'onrbuttondown'
UNION all
SELECT file_path,element_id,element_name,'' onkeydown,'' onkeyup,'' onlbuttondown,'' onlbuttonup,'' onrbuttondown,attr_value onclick FROM ntree_elements WHERE attr_name = 'onclick') T
GROUP BY file_path,element_id,element_name
ORDER BY file_path,element_id,element_name ) tt
;
COMMIT;
SELECT * FROM ntree_onevent;
SELECT * FROM ntree_onevent WHERE onclick IS NOT NULL AND (onlbuttondown IS NOT NULL OR onlbuttonup IS NOT NULL OR onrbuttondown IS NOT NULL);


-- event 정보 
DROP TABLE ntree_events;
CREATE TABLE ntree_events AS 
SELECT REPLACE(substr(file_path,44,instr(file_path,'.',-1)-44),'\\','\') new_file_path,file_path,element_id,element_name,id,onactivate,onbeforeclose,onblur,oncellclick,oncelldblclick,onchanged,onchar,onclick,onclose,oncolumnchanged,ondblclick,oneditclick,onexport,onheadclick,onheaddblclick,oninit,onitemchanged,onitemclick,onitemdblclick,onkeydown,onkeyup,onkillfocus,onlbuttondown,onlbuttonup,onload,onmouseenter,onmouseleave,onmousemove,onrbuttondown,onselectchanged,onsetfocus,onsize,onstatus,ontextchange,ontextchanged,ontimer,onusernotify FROM 
(
SELECT file_path,element_id,element_name,max(id) id,max(onactivate) onactivate, max(onbeforeclose) onbeforeclose, max(onblur) onblur, max(oncellclick) oncellclick, max(oncelldblclick) oncelldblclick, max(onchanged) onchanged, max(onchar) onchar,max(onclick) onclick, max(onclose) onclose, max(oncolumnchanged) oncolumnchanged, max(ondblclick) ondblclick, max(oneditclick) oneditclick, max(onexport) onexport, max(onheadclick) onheadclick, max(onheaddblclick) onheaddblclick, max(oninit) oninit, max(onitemchanged) onitemchanged, max(onitemclick) onitemclick, max(onitemdblclick) onitemdblclick, max(onkeydown) onkeydown, max(onkeyup) onkeyup, max(onkillfocus) onkillfocus, max(onlbuttondown) onlbuttondown, max(onlbuttonup) onlbuttonup, max(onload) onload, max(onmouseenter) onmouseenter, max(onmouseleave) onmouseleave, max(onmousemove) onmousemove, max(onrbuttondown) onrbuttondown, max(onselectchanged) onselectchanged, max(onsetfocus) onsetfocus, max(onsize) onsize, max(onstatus) onstatus, max(ontextchange) ontextchange, max(ontextchanged) ontextchanged, max(ontimer) ontimer, max(onusernotify) onusernotify FROM (
SELECT file_path,element_id,element_name,attr_value id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'id'
UNION all
SELECT file_path,element_id,element_name,'' id,attr_value onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onactivate'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,attr_value onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onbeforeclose'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,attr_value onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onblur'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,attr_value oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'oncellclick'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,attr_value oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'oncelldblclick'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,attr_value onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onchanged'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,attr_value onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onchar'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,attr_value onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onclick'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,attr_value onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onclose'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,attr_value oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'oncolumnchanged'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,attr_value ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'ondblclick'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,attr_value oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'oneditclick'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,attr_value onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onexport'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,attr_value onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onheadclick'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,attr_value onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onheaddblclick'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,attr_value oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'oninit'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,attr_value onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onitemchanged'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,attr_value onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onitemclick'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,attr_value onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onitemdblclick'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,attr_value onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onkeydown'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,attr_value onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onkeyup'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,attr_value onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onkillfocus'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,attr_value onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onlbuttondown'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,attr_value onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onlbuttonup'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,attr_value onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onload'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,attr_value onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onmouseenter'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,attr_value onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onmouseleave'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,attr_value onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onmousemove'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,attr_value onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onrbuttondown'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,attr_value onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onselectchanged'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,attr_value onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onsetfocus'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,attr_value onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onsize'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,attr_value onstatus,'' ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'onstatus'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,attr_value ontextchange,'' ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'ontextchange'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,attr_value ontextchanged,'' ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'ontextchanged'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,attr_value ontimer,'' onusernotify FROM ntree_elements WHERE attr_name = 'ontimer'
UNION all
SELECT file_path,element_id,element_name,'' id,'' onactivate,'' onbeforeclose,'' onblur,'' oncellclick,'' oncelldblclick,'' onchanged,'' onchar,'' onclick,'' onclose,'' oncolumnchanged,'' ondblclick,'' oneditclick,'' onexport,'' onheadclick,'' onheaddblclick,'' oninit,'' onitemchanged,'' onitemclick,'' onitemdblclick,'' onkeydown,'' onkeyup,'' onkillfocus,'' onlbuttondown,'' onlbuttonup,'' onload,'' onmouseenter,'' onmouseleave,'' onmousemove,'' onrbuttondown,'' onselectchanged,'' onsetfocus,'' onsize,'' onstatus,'' ontextchange,'' ontextchanged,'' ontimer,attr_value onusernotify FROM ntree_elements WHERE attr_name = 'onusernotify') T
GROUP BY file_path,element_id,element_name
ORDER BY file_path,element_id,element_name ) tt
;

SELECT * FROM ntree_events;
-- bind 정보  
DROP TABLE ntree_bind;
CREATE TABLE ntree_bind AS 
SELECT REPLACE(substr(file_path,44,instr(file_path,'.',-1)-44),'\\','\') new_file_path,file_path,element_id,element_name,id,compid,propid,datasetid,columnid FROM 
(
SELECT file_path,element_id,element_name,max(id) id,max(compid) compid, max(propid) propid, max(datasetid) datasetid, max(columnid) columnid FROM (
SELECT file_path,element_id,element_name,attr_value id,'' compid,'' propid,'' datasetid,'' columnid FROM ntree_elements WHERE element_name = 'BindItem' AND attr_name = 'name'
UNION all
SELECT file_path,element_id,element_name,'' id,attr_value compid,'' propid,'' datasetid,'' columnid FROM ntree_elements WHERE element_name = 'BindItem' AND attr_name = 'compid'
UNION all
SELECT file_path,element_id,element_name,'' id,'' compid,attr_value propid,'' datasetid,'' columnid FROM ntree_elements WHERE element_name = 'BindItem' AND attr_name = 'propid'
UNION all
SELECT file_path,element_id,element_name,'' id,'' compid,'' propid,attr_value datasetid,'' columnid FROM ntree_elements WHERE element_name = 'BindItem' AND attr_name = 'datasetid'
UNION all
SELECT file_path,element_id,element_name,'' id,'' compid,'' propid,'' datasetid,attr_value columnid FROM ntree_elements WHERE element_name = 'BindItem' AND attr_name = 'columnid') T
GROUP BY file_path,element_id,element_name
ORDER BY file_path,element_id,element_name ) tt
;
SELECT * FROM ntree_bind WHERE REGEXP_LIKE(file_path,'lnd','i') ORDER BY file_path,id;
SELECT * FROM ntree_bind WHERE (new_file_path,compid) IN (SELECT REPLACE(substr(file_path,44,instr(file_path,'.',-1)-44),'\\','\'),attr_value FROM ntree_elements WHERE element_name = 'Calendar' AND attr_name = 'id');
SELECT * FROM ntree_elements;
CREATE TABLE calid AS SELECT REPLACE(substr(file_path,44,instr(file_path,'.',-1)-44),'\\','\') new_file_path ,attr_value FROM ntree_elements WHERE element_name = 'Calendar' AND attr_name = 'id' ORDER BY 1,2;
SELECT * FROM ntree_bind a INNER JOIN calid b ON a.new_file_path = b.new_file_path AND a.compid = b.attr_value;
-- 버튼 속성 
CREATE TABLE ntree_button AS 
SELECT file_path,element_id,element_name,max(id) id,max(class) class, max(onclick) onclick, max(text) text FROM (
SELECT file_path,element_id,element_name,attr_value id,'' class,'' onclick,'' text FROM ntree_elements WHERE element_name = 'Button' AND attr_name = 'id'
UNION all
SELECT file_path,element_id,element_name,'' id,attr_value class,'' onclick,'' text FROM ntree_elements WHERE element_name = 'Button' AND attr_name = 'class'
UNION all
SELECT file_path,element_id,element_name,'' id,'' class,attr_value onclick,'' text FROM ntree_elements WHERE element_name = 'Button' AND attr_name = 'onclick'
UNION all
SELECT file_path,element_id,element_name,'' id,'' class,'' onclick,attr_value text FROM ntree_elements WHERE element_name = 'Button' AND attr_name = 'text') T
GROUP BY file_path,element_id,element_name
ORDER BY file_path,element_id,element_name;
SELECT * FROM ntree_button;

-- cell 컬럼 display / edit type 관련 
DROP TABLE ntree_cell_type;
CREATE TABLE ntree_cell_type AS 
SELECT file_path,element_id,element_name,max(displaytype) displaytype,max(edittype) edittype, max(expr) expr, max(text) text FROM (
SELECT file_path,element_id,element_name,attr_value displaytype,'' edittype,'' expr,'' text FROM ntree_elements WHERE element_name = 'Cell' AND attr_name = 'displaytype'
UNION all
SELECT file_path,element_id,element_name,'' displaytype,attr_value edittype,'' expr,'' text FROM ntree_elements WHERE element_name = 'Cell' AND attr_name = 'edittype'
UNION all
SELECT file_path,element_id,element_name,'' displaytype,'' edittype,attr_value expr,'' text FROM ntree_elements WHERE element_name = 'Cell' AND attr_name = 'expr'
UNION all
SELECT file_path,element_id,element_name,'' displaytype,'' edittype,'' expr,attr_value text FROM ntree_elements WHERE element_name = 'Cell' AND attr_name = 'text') T
GROUP BY file_path,element_id,element_name
ORDER BY file_path,element_id,element_name;
SELECT * FROM comp_cell_type ORDER BY  file_path,element_id;
SELECT displaytype,count(*) FROM comp_cell_type GROUP BY displaytype ORDER BY  displaytype;
SELECT * FROM COMP_CELL_TYPE WHERE REGEXP_LIKE(FILE_PATH ,'lnd013u','i') ORDER BY file_path,element_id;
SELECT * FROM COMP_CELL_TYPE WHERE REGEXP_LIKE(displaytype,'^expr','i') OR REGEXP_LIKE(edittype,'^expr','i') ORDER BY file_path,element_id;
SELECT * FROM COMP_CELL_TYPE WHERE REGEXP_LIKE(displaytype,'^date','i') ORDER BY file_path,element_id;
SELECT * FROM COMP_CELL_TYPE WHERE displaytype IS null ORDER BY file_path,element_id;
SELECT * FROM COMP_CELL_TYPE WHERE displaytype <> edittype ORDER BY file_path,element_id;

-- cell 컬럼 display / edit type 관련 
DROP TABLE conv_cell_type;
CREATE TABLE conv_cell_type AS 
SELECT file_path,element_id,element_name,max(displaytype) displaytype,max(edittype) edittype, max(expr) expr, max(text) text FROM (
SELECT file_path,element_id,element_name,attr_value displaytype,'' edittype,'' expr,'' text FROM conv_elements WHERE element_name = 'data' AND attr_name = 'displaytype'
UNION all
SELECT file_path,element_id,element_name,'' displaytype,attr_value edittype,'' expr,'' text FROM conv_elements WHERE element_name = 'Cell' AND attr_name = 'edittype'
UNION all
SELECT file_path,element_id,element_name,'' displaytype,'' edittype,attr_value expr,'' text FROM conv_elements WHERE element_name = 'Cell' AND attr_name = 'expr'
UNION all
SELECT file_path,element_id,element_name,'' displaytype,'' edittype,'' expr,attr_value text FROM conv_elements WHERE element_name = 'Cell' AND attr_name = 'text') T
GROUP BY file_path,element_id,element_name
ORDER BY file_path,element_id,element_name;
SELECT * FROM comp_cell_type ORDER BY  file_path,element_id;
SELECT displaytype,count(*) FROM comp_cell_type GROUP BY displaytype ORDER BY  displaytype;
SELECT * FROM COMP_CELL_TYPE WHERE REGEXP_LIKE(FILE_PATH ,'lnd013u','i') ORDER BY file_path,element_id;
SELECT * FROM COMP_CELL_TYPE WHERE REGEXP_LIKE(displaytype,'^expr','i') OR REGEXP_LIKE(edittype,'^expr','i') ORDER BY file_path,element_id;
SELECT * FROM COMP_CELL_TYPE WHERE REGEXP_LIKE(displaytype,'^date','i') ORDER BY file_path,element_id;
SELECT * FROM COMP_CELL_TYPE WHERE displaytype IS null ORDER BY file_path,element_id;
SELECT * FROM COMP_CELL_TYPE WHERE displaytype <> edittype ORDER BY file_path,element_id;
SELECT * FROM conv_elements;

TRUNCATE TABLE elements;
DELETE FROM elements WHERE file_path LIKE 'C:\\nTree\\workspace%';
DELETE FROM elements WHERE REGEXP_LIKE(file_path,'conv.+screen_0426','i');
CREATE TABLE convlist AS SELECT DISTINCT substr(file_name,1,instr(file_name,'.')-1) file_name FROM elements WHERE REGEXP_LIKE(file_path,'conv','i');
DELETE FROM elements WHERE REGEXP_LIKE(file_path,'ntree','i') AND substr(file_name,1,instr(file_name,'.')-1) NOT IN (SELECT file_name FROM convlist) ;
COMMIT;
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'ntree.*bdm175','i') and REGEXP_LIKE(element_name,'edit','i') AND REGEXP_LIKE(attr_name,'id','i') ORDER BY file_path,element_id,ATTR_NAME ;  
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'conv.*bdm175','i') AND REGEXP_LIKE(element_name,'field','i') AND REGEXP_LIKE(attr_name,'name','i') ORDER BY file_path,element_id,attr_name ; 

DROP TABLE scripts;
CREATE TABLE scripts (file_path varchar2(512),file_name varchar2(64),script_text clob);

TRUNCATE TABLE scripts;
SELECT * FROM scripts;
SELECT * FROM scripts WHERE REGEXP_LIKE(file_path,'com','i') ORDER BY file_path;

SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'ibosxml','i') ORDER BY file_path,element_id,attr_name; 

SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'ibosxml','i') AND element_name = 'FIELD' ORDER BY file_path,element_id,attr_name; 
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'ibosxml','i') AND element_name = 'NAME' AND attr_name = 'value' ORDER BY file_path,element_id,attr_name; 

SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'ibosxml','i') AND element_name = 'TYPE' AND attr_name = 'name' ORDER BY file_path,element_id,attr_name;  -- TYPE 만 추출
SELECT file_path,file_name,el_depth,element_id,element_name,parent_id FROM elements WHERE REGEXP_LIKE(file_path,'ibosxml','i') AND element_name = 'FIELD' AND parent_name = 'TYPE' GROUP BY file_path,file_name,el_depth,element_id,element_name,parent_id ORDER BY file_path,file_name,el_depth,element_id,element_name,parent_id; -- FIELD이면서 parent가 TYPE 인것만 추출

SELECT * FROM 
(SELECT file_path,file_name,el_depth,element_id,parent_id FROM elements WHERE REGEXP_LIKE(file_path,'ibosxml','i') AND element_name = 'FIELD' AND parent_name = 'TYPE' GROUP BY file_path,file_name,el_depth,element_id,parent_id ) t1
LEFT OUTER JOIN 
(SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'ibosxml','i') AND element_name = 'TYPE' AND attr_name = 'name' ) t2
ON t1.file_path = t2.file_path AND t1.file_name = t2.file_name AND t1.parent_id = t2.parent_id
WHERE REGEXP_LIKE(t1.file_path,'.*','i')
ORDER BY t1.file_path,t1.element_id,t2.element_id;

SELECT file_path,file_name,el_depth,element_name,element_id,parent_name,parent_id,attr_name,attr_value 
  FROM elements 
 WHERE REGEXP_LIKE(file_path,'ibosxml','i') AND element_name = 'NAME' AND PARENT_NAME = 'FIELD' AND attr_name = 'value'; -- 해당 클래스의 필드 이름
 
 SELECT file_path,file_name,el_depth,element_name,element_id,parent_name,parent_id,attr_name,attr_value 
  FROM elements 
 WHERE REGEXP_LIKE(file_path,'ibosxml','i') AND element_name = 'TYPE' AND PARENT_NAME = 'FIELD' AND attr_name = 'name'; -- 해당 클래스의 필드 타입
 
 -- 폼에 정의된 필드 정보 추출
 -- drop table form_fields;
 -- create table form_fields as 
 SELECT t1.file_path,t1.file_name,t1.el_depth,t1.parent_name,t1.parent_id,t1.attr_value field_name,t2.attr_value field_type FROM 
 (SELECT file_path,file_name,el_depth,element_name,element_id,parent_name,parent_id,attr_name,attr_value 
  FROM elements 
 WHERE REGEXP_LIKE(file_path,'ibosxml','i') AND element_name = 'NAME' AND PARENT_NAME = 'FIELD' AND attr_name = 'value') t1
 FULL OUTER JOIN 
 (SELECT file_path,file_name,el_depth,element_name,element_id,parent_name,parent_id,attr_name,attr_value 
  FROM elements 
 WHERE REGEXP_LIKE(file_path,'ibosxml','i') AND element_name = 'TYPE' AND PARENT_NAME = 'FIELD' AND attr_name = 'name') t2
 ON t1.file_path = t2.file_path AND t1.file_name = t2.file_name AND t1.parent_id = t2.parent_id
 ORDER BY t1.file_path,t1.element_id,t2.element_id;

SELECT * FROM form_fields;

 -- 폼에 정의된 메소드 정보 추출
-- drop table form_methods;
-- create table form_methods as
SELECT file_path,file_name,el_depth,element_name,element_id,parent_name,parent_id,max(method_type) method_type,max(method_name) method_name FROM 
(SELECT file_path,file_name,el_depth,element_name,element_id,parent_name,parent_id,attr_value method_type,'' method_name 
  FROM elements 
 WHERE REGEXP_LIKE(file_path,'ibosxml','i') AND element_name = 'METHOD' AND parent_name = 'IMPLEMENTATION' and attr_name = 'kind' 
 UNION ALL
SELECT file_path,file_name,el_depth,element_name,element_id,parent_name,parent_id,'' method_type,attr_value method_name 
  FROM elements 
 WHERE REGEXP_LIKE(file_path,'ibosxml','i') AND element_name = 'METHOD' AND parent_name = 'IMPLEMENTATION' AND attr_name = 'name' ) t1
 GROUP BY  file_path,file_name,el_depth,element_name,element_id,parent_name,parent_id
 ORDER BY file_path,file_name,el_depth,element_name,element_id,parent_name,parent_id;

SELECT * FROM form_methods;
SELECT file_path,file_name,method_type,method_name,substr(method_name,INSTR(method_name,'.')+1) short_name  FROM form_methods;

 -- 폼에 정의된 변수 정보 추출
-- create table form_vars as 
SELECT file_path,file_name,el_depth,parent_name,parent_id,max(var_type) var_type,max(var_name) var_name FROM 
( SELECT file_path,file_name,el_depth,element_name,element_id,parent_name,parent_id,'' var_type,attr_value var_name 
  FROM elements 
 WHERE REGEXP_LIKE(file_path,'ibosxml','i') AND element_name = 'NAME' AND parent_name = 'VARIABLE' and attr_name = 'value' 
 UNION ALL 
  SELECT file_path,file_name,el_depth,element_name,element_id,parent_name,parent_id,attr_value var_type,'' var_name 
  FROM elements 
 WHERE REGEXP_LIKE(file_path,'ibosxml','i') AND element_name = 'TYPE' AND parent_name = 'VARIABLE' and attr_name = 'name' ) t1
  GROUP BY  file_path,file_name,el_depth,parent_name,parent_id
 ORDER BY file_path,file_name,el_depth,parent_name,parent_id;

SELECT * FROM form_vars;

-- 
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'ge','i'); 

 SELECT t1.file_path,t1.file_name,t1.el_depth,t1.parent_name,t1.parent_id,t1.attr_value field_name,t2.attr_value field_type FROM 
 (SELECT file_path,file_name,el_depth,element_name,element_id,parent_name,parent_id,attr_name,attr_value 
  FROM elements 
 WHERE REGEXP_LIKE(file_path,'ibosxml','i') AND element_name = 'METHOD' AND PARENT_NAME = 'FIELD' AND attr_name = 'value') t1
 FULL OUTER JOIN 
 (SELECT file_path,file_name,el_depth,element_name,element_id,parent_name,parent_id,attr_name,attr_value 
  FROM elements 
 WHERE REGEXP_LIKE(file_path,'ibosxml','i') AND element_name = 'TYPE' AND PARENT_NAME = 'FIELD' AND attr_name = 'name') t2
 ON t1.file_path = t2.file_path AND t1.file_name = t2
 
 SELECT file_path,file_name,el_depth,element_name,element_id,parent_name,parent_id,attr_value method_type,'' method_name 
  FROM elements 
 WHERE REGEXP_LIKE(file_path,'ibosxml','i') AND element_name = 'METHOD' AND parent_name = 'IMPLEMENTATION' and attr_name = 'kind' ORDER BY file_path,element_id,attr_name; -- 해당 클래스의 메소드 타입
 
  SELECT file_path,file_name,el_depth,element_name,element_id,parent_name,parent_id,'' method_type,attr_value method_name 
  FROM elements 
 WHERE REGEXP_LIKE(file_path,'ibosxml','i') AND element_name = 'METHOD' AND parent_name = 'IMPLEMENTATION' AND attr_name = 'name' ORDER BY file_path,element_id,attr_name; -- 해당 클래스의 메소드 이름
 
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'stdctrl','i') AND element_name = 'PROPERTY' AND parent_name = 'PUBLISHED' AND attr_name = 'name'; 

SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'stdctrl','i') AND element_name = 'TYPEDECL' AND attr_name = 'name' ORDER BY file_path,element_id,attr_name; 
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'stdctrl','i') AND element_name = 'TYPEDECL' AND attr_name = 'name' ORDER BY file_path,attr_value; 
SELECT * FROM (SELECT * FROM elements WHERE parent_id IN (SELECT element_id FROM elements WHERE REGEXP_LIKE(file_path,'stdctrl','i') AND element_name = 'TYPEDECL' AND attr_name = 'name')) t 
WHERE REGEXP_LIKE(t.file_path,'stdctrl','i') AND t.attr_name NOT IN ('col','line') ORDER BY file_path,element_id;


SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'stdctrls','i') ORDER BY file_path,element_id; 
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'stdctrls','i') AND REGEXP_LIKE(element_name,'typedecl','i') AND REGEXP_LIKE(attr_name,'name','i') ORDER BY file_path,attr_value; 

SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'ybtreeview','i') AND REGEXP_LIKE(parent_id,'2225','i') ORDER BY file_path,element_id;

--
-- =========================== 타입이 TYBTreeView 인 element 가 하나인지 확인
SELECT * FROM elements WHERE REGEXP_LIKE(element_name,'typedecl','i') AND REGEXP_LIKE(attr_name,'name','i') AND REGEXP_LIKE(attr_value,'TYBMemTable','i');
SELECT * FROM elements WHERE REGEXP_LIKE(attr_name,'type','i') AND  (file_path,parent_id) IN (SELECT file_path,element_id FROM elements WHERE REGEXP_LIKE(element_name,'typedecl','i') AND REGEXP_LIKE(attr_name,'name','i') AND REGEXP_LIKE(attr_value,'TYBMemTable','i'));
SELECT * FROM elements WHERE (file_path,parent_id) IN (SELECT file_path,element_id FROM elements WHERE REGEXP_LIKE(attr_name,'type','i') AND  (file_path,parent_id) IN (SELECT file_path,element_id FROM elements WHERE REGEXP_LIKE(element_name,'typedecl','i') AND REGEXP_LIKE(attr_name,'name','i') AND REGEXP_LIKE(attr_value,'TYBMemTable','i')));
-- 상속 클래스
SELECT * FROM elements WHERE REGEXP_LIKE(element_name,'type','i') AND REGEXP_LIKE(attr_name,'name','i') AND  (file_path,parent_id) IN 
	(SELECT file_path,element_id FROM elements WHERE REGEXP_LIKE(attr_name,'type','i') AND  (file_path,parent_id) IN 
		(SELECT file_path,element_id FROM elements WHERE REGEXP_LIKE(element_name,'typedecl','i') AND REGEXP_LIKE(attr_name,'name','i') AND REGEXP_LIKE(attr_value,'TControl','i')));
-- Public 아래 정보
SELECT * FROM elements WHERE regexp_like(attr_name,'name','i') AND (file_path,parent_id) IN 
	(SELECT file_path,element_id FROM elements WHERE REGEXP_LIKE(element_name,'public','i') AND REGEXP_LIKE(attr_name,'visibility','i') AND (file_path,parent_id) IN 
		(SELECT file_path,element_id FROM elements WHERE REGEXP_LIKE(attr_name,'type','i') AND  (file_path,parent_id) IN 
			(SELECT file_path,element_id FROM elements WHERE REGEXP_LIKE(element_name,'typedecl','i') AND REGEXP_LIKE(attr_name,'name','i') AND REGEXP_LIKE(attr_value,'TYBTreeView','i'))))  ORDER BY file_path,element_name,element_id,attr_name,attr_value;
-- Published 아래 정보
SELECT * FROM elements WHERE regexp_like(attr_name,'name','i') AND (file_path,parent_id) IN 
	(SELECT file_path,element_id FROM elements WHERE REGEXP_LIKE(element_name,'published','i') AND REGEXP_LIKE(attr_name,'visibility','i') AND (file_path,parent_id) IN 
		(SELECT file_path,element_id FROM elements WHERE REGEXP_LIKE(attr_name,'type','i') AND  (file_path,parent_id) IN 
			(SELECT file_path,element_id FROM elements WHERE REGEXP_LIKE(element_name,'typedecl','i') AND REGEXP_LIKE(attr_name,'name','i') AND REGEXP_LIKE(attr_value,'TYBTreeView','i'))))  ORDER BY file_path,element_name,element_id,attr_name,attr_value;

-- ===================================
SELECT * FROM elements WHERE  (file_path,parent_id) IN (SELECT file_path,parent_id FROM elements WHERE REGEXP_LIKE(attr_name,'type','i') AND  (file_path,parent_id) IN (SELECT file_path,parent_id FROM elements WHERE REGEXP_LIKE(attr_name,'type','i') AND  (file_path,parent_id) IN (SELECT file_path,element_id FROM elements WHERE REGEXP_LIKE(element_name,'typedecl','i') AND REGEXP_LIKE(attr_name,'name','i') AND REGEXP_LIKE(attr_value,'tybtreeview','i'))));
-- TRadioButton 을 부모로 하는 자식노드 정보들
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'ybtreeview','i') AND parent_id IN (SELECT element_id FROM elements WHERE REGEXP_LIKE(file_path,'stdctrls','i') AND REGEXP_LIKE(attr_name,'type','i') AND parent_id IN (SELECT element_id FROM elements WHERE REGEXP_LIKE(file_path,'stdctrls','i') AND REGEXP_LIKE(element_name,'typedecl','i') AND REGEXP_LIKE(attr_name,'name','i') AND REGEXP_LIKE(attr_value,'tybtreeview','i')));
-- 자식노드 정보중에 상속받은 클래스 이름
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'stdctrls','i') AND REGEXP_LIKE(element_name,'type','i') AND REGEXP_LIKE(attr_name,'name','i') AND parent_id IN (SELECT element_id FROM elements WHERE REGEXP_LIKE(file_path,'stdctrls','i') AND REGEXP_LIKE(attr_name,'type','i') AND parent_id IN (SELECT element_id FROM elements WHERE REGEXP_LIKE(file_path,'stdctrls','i') AND REGEXP_LIKE(element_name,'typedecl','i') AND REGEXP_LIKE(attr_name,'name','i') AND REGEXP_LIKE(attr_value,'tradiobutton','i')));
-- 자식노드 정보중에 PUBLIC 아래 정보들
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'stdctrls','i') AND regexp_like(attr_name,'kind|name|methodbinding','i') AND parent_id IN (SELECT element_id FROM elements WHERE REGEXP_LIKE(file_path,'stdctrls','i') AND REGEXP_LIKE(element_name,'public','i') AND REGEXP_LIKE(attr_name,'visibility','i') AND parent_id IN (SELECT element_id FROM elements WHERE REGEXP_LIKE(file_path,'stdctrls','i') AND REGEXP_LIKE(attr_name,'type','i') AND parent_id IN (SELECT element_id FROM elements WHERE REGEXP_LIKE(file_path,'stdctrls','i') AND REGEXP_LIKE(element_name,'typedecl','i') AND REGEXP_LIKE(attr_name,'name','i') AND REGEXP_LIKE(attr_value,'ttreeview','i')))) ORDER BY file_path,element_name,element_id,attr_name,attr_value;
-- 자식노드 정보중에 published 아래 정보들
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'stdctrls','i') AND regexp_like(attr_name,'kind|name|methodbinding','i') AND parent_id IN (SELECT element_id FROM elements WHERE REGEXP_LIKE(file_path,'stdctrls','i') AND REGEXP_LIKE(element_name,'published','i') AND REGEXP_LIKE(attr_name,'visibility','i') AND parent_id IN (SELECT element_id FROM elements WHERE REGEXP_LIKE(file_path,'stdctrls','i') AND REGEXP_LIKE(attr_name,'type','i') AND parent_id IN (SELECT element_id FROM elements WHERE REGEXP_LIKE(file_path,'stdctrls','i') AND REGEXP_LIKE(element_name,'typedecl','i') AND REGEXP_LIKE(attr_name,'name','i') AND REGEXP_LIKE(attr_value,'ttreeview','i')))) ORDER BY file_path,element_name,element_id,attr_name,attr_value;


--
-- ================================
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'stdctrls','i') AND REGEXP_LIKE(element_name,'method','i') AND REGEXP_LIKE(attr_name,'name','i') ORDER BY file_path,attr_value; 
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'stdctrls','i') AND REGEXP_LIKE(element_name,'method','i') AND REGEXP_LIKE(attr_name,'kind','i') ORDER BY file_path,attr_value; 

--
-- nTree 
--
DELETE FROM elements WHERE REGEXP_LIKE(file_path,'ntreeworks.+aca805','i');
COMMIT;
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'C:\\xFrame\\project\\DSI\\screen\\TEMP\\grid','i') AND REGEXP_LIKE(ELEMENT_name,'column','i') ;
SELECT a.*,b.attr_name,b.attr_value FROM (
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'C:\\xFrame\\project\\DSI\\screen\\TEMP\\grid','i') AND parent_id IN (10)  ) a 
FULL OUTER JOIN (
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'C:\\xFrame\\project\\DSI\\screen\\TEMP\\grid','i') AND parent_id IN (25)  ) B
ON a.file_path = b.file_path AND a.attr_name = b.attr_name ORDER BY a.attr_name;
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'ntree','i') ORDER BY file_path,element_id,attr_name;

SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'ntree.+login','i') ORDER BY file_path,element_id,attr_name;
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'conv.+login','i')  ORDER BY file_path,element_id,attr_name;

SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'ntree.+lnd013','i') AND REGEXP_LIKE(ELEMENT_NAME,'^button$','i') ORDER BY file_path,element_id,attr_name;
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'conv.+lnd013','i') AND REGEXP_LIKE(ELEMENT_NAME,'^pushbutton$','i') ORDER BY file_path,element_id,attr_name;

SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'ntree.+lnd019','i') AND REGEXP_LIKE(ELEMENT_NAME,'button','i') ORDER BY file_path,element_id,attr_name;
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'ntreeworks.+lnd013','i') AND REGEXP_LIKE(ELEMENT_NAME,'layout','i') ORDER BY file_path,element_id,attr_name;
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'ntreeworks.+lnd013','i') AND REGEXP_LIKE(ELEMENT_NAME,'.*','i') AND REGEXP_LIKE(ATTR_NAME,'image','i') ORDER BY file_path,element_id,attr_name;
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'ntreeworks.+lnd01','i') AND REGEXP_LIKE(ELEMENT_NAME,'.*','i') AND REGEXP_LIKE(ATTR_VALUE,'btn_WFSA_Search_N','i') ORDER BY file_path,element_id,attr_name;
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'ntreeworks.+','i') AND REGEXP_LIKE(ELEMENT_NAME,'.*','i') AND REGEXP_LIKE(ATTR_VALUE,'btn_WFSA_Search_N','i') ORDER BY file_path,element_id,attr_name;

SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'ntreeworks.+sample','i');
DELETE FROM elements WHERE REGEXP_LIKE(file_path,'ntreeworks.+sample','i');
ROLLBACK;
-- nTree TypeDefinition
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'ntreeworks.+typedef','i') ;
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'typedef','i') ORDER BY element_id,attr_name ;

SELECT file_path,element_id,max(id) id, max(classname) classname, max(module) module FROM (
SELECT file_path,element_id,attr_value id,'' classname, '' module FROM elements WHERE REGEXP_LIKE(file_path,'typedef','i') AND REGEXP_LIKE(ELEMENT_NAME,'^component$','i') AND REGEXP_LIKE(ATTR_NAME,'^id$','i')  
UNION all
SELECT file_path,element_id,'' id,attr_value classname, '' module FROM elements WHERE REGEXP_LIKE(file_path,'typedef','i') AND REGEXP_LIKE(ELEMENT_NAME,'^component$','i') AND REGEXP_LIKE(ATTR_NAME,'^classname$','i')  
UNION all
SELECT file_path,element_id,'' id,'' classname, attr_value module FROM elements WHERE REGEXP_LIKE(file_path,'typedef','i') AND REGEXP_LIKE(ELEMENT_NAME,'^component$','i') AND REGEXP_LIKE(ATTR_NAME,'^module$','i')  ) T
WHERE REGEXP_LIKE(file_path,'typedef\.xml$','i') 
GROUP BY file_path,element_id;
--
--
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'ntreeworks.+workFrame','i') AND ELEMENT_ID IN (50) ORDER BY file_path,element_id,attr_name;
SELECT * FROM menus WHERE REGEXP_LIKE(pgm_id,'HMM001','i') ;
SELECT * FROM menus ORDER BY sort;
--
--
-- global variables
select * from elements WHERE REGEXP_LIKE(file_path,'globalvars','i') ORDER BY element_id,attr_name ;

-- 화면내에 스타일을 가지고 있는 목록 (nTree는 없음)
SELECT * FROM elements WHERE REGEXP_LIKE(ELEMENT_NAME,'style','i');

-- 스타일 속성에 transformation , animation 이 있는 경우
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'screen_0423','i') AND REGEXP_LIKE(ELEMENT_NAME,'.*','i') AND REGEXP_LIKE(ATTR_NAME,'style','i') AND REGEXP_LIKE(ATTR_VALUE ,'transformation|effect','i');
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'screen_0423','i') AND ELEMENT_ID IN (163) ORDER BY file_path,element_id,attr_name;

-- animation 속성이 있는경우
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'screen_0423','i') AND REGEXP_LIKE(ELEMENT_NAME,'animation','i');

-- button의 클래스
SELECT attr_value,count(*) FROM elements WHERE REGEXP_LIKE(file_path,'screen_0423','i') AND REGEXP_LIKE(ELEMENT_NAME,'button','i') AND REGEXP_LIKE(ATTR_NAME,'^class$','i') GROUP BY attr_value ORDER BY count(*) desc; 


-- top frame
SELECT *  FROM elements WHERE REGEXP_LIKE(file_path,'ntreeworks.+topframe','i') AND REGEXP_LIKE(ELEMENT_NAME,'.*','i') AND REGEXP_LIKE(ATTR_NAME,'.*','i')  ORDER BY file_path,element_id,attr_name;
SELECT attr_value,count(*) FROM elements WHERE REGEXP_LIKE(file_path,'ntreeworks.+topframe','i') AND REGEXP_LIKE(ELEMENT_NAME,'.*','i') AND REGEXP_LIKE(ATTR_NAME,'.*','i') GROUP BY attr_value ORDER BY count(*) desc; 

SELECT file_path,element_name,element_id,count(*) FROM elements WHERE REGEXP_LIKE(file_path,'ntreeworks.+','i') GROUP BY file_path,element_name,element_id ORDER BY  file_path,element_name,element_id;
SELECT *  FROM elements WHERE REGEXP_LIKE(file_path,'ntreeworks.+aca805','i') AND REGEXP_LIKE(ELEMENT_NAME,'.*','i') AND REGEXP_LIKE(ATTR_NAME,'.*','i')  ORDER BY file_path,element_id,attr_name;
SELECT *  FROM elements WHERE REGEXP_LIKE(file_path,'ntreeworks.+CMF001U','i') ORDER BY file_path,element_id,attr_name;
SELECT *  FROM elements WHERE REGEXP_LIKE(file_path,'ntreeworks.+','i') AND REGEXP_LIKE(ELEMENT_NAME,'.*','i') AND REGEXP_LIKE(ATTR_NAME,'.*ontimer','i')  ORDER BY file_path,element_id,attr_name;
SELECT *  FROM elements WHERE REGEXP_LIKE(file_path,'0423','i') AND REGEXP_LIKE(ELEMENT_NAME,'^button','i')  ORDER BY file_path,element_id,attr_name;
SELECT file_path,element_id,max(id) id,max(progid) progid FROM (
SELECT file_path,element_id,attr_value id,'' progid  FROM elements WHERE REGEXP_LIKE(file_path,'ntreeworks.+','i') AND REGEXP_LIKE(ELEMENT_NAME,'^ActiveX','i')  AND REGEXP_LIKE(ATTR_NAME,'^id$','i') 
UNION all
SELECT file_path,element_id,'' id,attr_value progid  FROM elements WHERE REGEXP_LIKE(file_path,'ntreeworks.+','i') AND REGEXP_LIKE(ELEMENT_NAME,'^ActiveX','i')  AND REGEXP_LIKE(ATTR_NAME,'^progid$','i') )
GROUP BY file_path,element_id
ORDER BY file_path,element_id;

SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'dsi','i') ; 
-- 

CREATE TABLE elements_t AS SELECT substr(file_path,instr(file_path,'\',-1)-2,2) pgm_path,t.* FROM elements t WHERE REGEXP_LIKE(file_path,'.*','i') ;
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'ntree','i') ;
DROP TABLE elements_t;
SELECT substr(pgm_id,instr(pgm_id,':',-1)+1),count(*)  FROM menus WHERE pgm_id IS NOT NULL GROUP BY substr(pgm_id,instr(pgm_id,':',-1)+1) HAVING count(*) > 1  ORDER BY 1;
SELECT * FROM elements_t WHERE REGEXP_LIKE(file_path,'ntree','i') ;

SELECT * FROM target_elements WHERE REGEXP_LIKE(file_path,'conv','i') ;
SELECT file_path,attr_value,count(*) FROM TARGET_ELEMENTS te WHERE attr_name = 'id' AND NOT REGEXP_LIKE(parent_name,'^columninfo$','i') GROUP BY FILE_PATH,attr_value HAVING count(*) > 1;
SELECT * FROM TARGET_ELEMENTS te WHERE attr_name = 'id'AND REGEXP_LIKE(attr_value,'sta_WFDA_Label02') ;
SELECT * FROM TARGET_ELEMENTS te WHERE REGEXP_LIKE(file_path,'bdm175l','i') AND element_id IN (88,238) ORDER BY file_path,element_id,attr_name ;
-- nTree에서 사용중인 컴포넌트 유형 목록
SELECT element_name,count(*) FROM (
	SELECT file_path,element_name,element_id,count(*) FROM target_elements WHERE REGEXP_LIKE(file_path,'conv.+','i') GROUP BY file_path,element_name,element_id ) t 
GROUP BY element_name ORDER BY element_name ;


CREATE TABLE ntree_columninfo AS SELECT * FROM ntree_elements WHERE REGEXP_LIKE(file_path,'.*','i') AND REGEXP_LIKE(element_name,'columninfo','i') ORDER  BY file_path,element_id  ;
CREATE TABLE ntree_column AS SELECT * FROM ntree_elements WHERE REGEXP_LIKE(file_path,'.*','i') AND REGEXP_LIKE(element_name,'column','i') ORDER  BY file_path,element_id  ;
SELECT file_path,parent_id,attr_value,count(*) FROM (
SELECT a.file_path,a.element_id,a.attr_value,b.parent_id FROM ntree_column a inner JOIN ntree_columninfo b ON a.file_path = b.file_path AND a.parent_id = b.element_id 
WHERE a.attr_name = 'id' AND a.attr_value NOT IN ('codecolumn','datacolumn') ) t GROUP BY file_path,parent_id,attr_value HAVING count(*) > 1;

SELECT * FROM ntree_elements WHERE REGEXP_LIKE(file_path,'.*','i') AND REGEXP_LIKE(element_name,'month','i') ORDER  BY file_path,element_id  ;
SELECT file_path,attr_name,attr_value FROM ntree_elements WHERE REGEXP_LIKE(file_path,'.*','i') AND REGEXP_LIKE(element_name,'form','i') AND REGEXP_LIKE(attr_name,'^on','i') ORDER  BY file_path,element_id  ;
SELECT * FROM ntree_elements WHERE REGEXP_LIKE(file_path,'bdm070l','i') ORDER BY file_path,element_id  ;
SELECT * FROM funclist_target WHERE REGEXP_LIKE(line_text,'onload','i');
SELECT * FROM event_target;
CREATE TABLE funclist_target_redefine (file_path varchar2(512), fname varchar2(512), fparam varchar2(512));
INSERT INTO funclist_target_redefine SELECT file_path,fname,fparam FROM funclist_target;
COMMIT;
SELECT a.file_path,a.element_name,a.attr_name,a.attr_value,b.fname,b.fparam FROM event_target a LEFT OUTER JOIN funclist_target_redefine b ON a.file_path = b.file_path AND a.attr_value = b.fname ORDER BY a.file_path,a.element_id;
CREATE TABLE event_target AS 
SELECT * FROM ntree_elements WHERE REGEXP_LIKE(attr_name,'^onlo','i') ORDER BY file_path,element_id  ;
SELECT *  FROM ntree_elements WHERE REGEXP_LIKE(attr_value,'P_ds_CustList','i') ;
SELECT imgurl,count(*) FROM (
SELECT file_path,element_id,element_name,attr_name,attr_value,max(imgurl) imgurl FROM (
SELECT file_path,element_id,element_name,attr_name,attr_value,REGEXP_SUBSTR(attr_value,'theme://images/([^'']+)',1,1,'i',1) imgurl  FROM ntree_elements WHERE REGEXP_LIKE(attr_value,'url\(','i')
UNION all
SELECT file_path,element_id,element_name,attr_name,attr_value,REGEXP_SUBSTR(attr_value,'img::([^'']+)',1,1,'i',1) imgurl  FROM ntree_elements WHERE REGEXP_LIKE(attr_value,'url\(','i') ) t
GROUP BY file_path,element_id,element_name,attr_name,attr_value
ORDER BY imgurl,file_path,element_id   
) t GROUP BY imgurl;

CREATE TABLE funclist_target as
SELECT file_path,file_name,file_ext,line_num,line_text,ltrim(rtrim(REPLACE(substr(line_text,1,instr(line_text,'(')-1),'function',''))) fname,substr(line_text,instr(line_text,'(')) fparam FROM funclist WHERE upper(file_ext) = 'XFDL' ;

-- 데이터셋의 숫자타입에 바인딩되어 있는 component
SELECT * FROM ntree_elements WHERE REGEXP_LIKE(attr_name,'^text$','i') AND REGEXP_LIKE(attr_value,'bind','i') AND (file_path,substr(attr_value,6)) IN (SELECT file_path,id FROM COMP_DS_COLS_ALL WHERE NOT REGEXP_LIKE(coltype,'string','i') ) ORDER BY file_path,element_id ;
SELECT * FROM ntree_elements WHERE REGEXP_LIKE(file_path,'bdm085','i') AND element_id IN (199) ORDER BY file_path,element_id ;

SELECT * FROM ntree_elements WHERE (file_path,element_id) IN (SELECT file_path,element_id FROM ntree_elements WHERE REGEXP_LIKE(attr_name,'^text$','i') AND REGEXP_LIKE(attr_value,'bind','i') AND substr(attr_value,6) IN (SELECT id FROM COMP_DS_COLS_ALL WHERE NOT REGEXP_LIKE(coltype,'string','i') ) ) AND REGEXP_LIKE(attr_name,'^mask$','i') AND  (NOT REGEXP_LIKE(attr_value,'####-##-##|:','i') OR attr_value IS NULL) ;

-- 그리드 비교
SELECT * FROM (SELECT * FROM ntree_elements WHERE REGEXP_LIKE(element_name,'grid','i') AND REGEXP_LIKE(attr_name,'^id$','i') ) t1 
FULL OUTER JOIN 
(SELECT * FROM conv_elements WHERE REGEXP_LIKE(element_name,'grid','i') AND REGEXP_LIKE(attr_name,'^name$','i') ) t2 ON t1.pgm_path = t2.pgm_path AND substr(t1.file_name,1,instr(t1.file_name,'.')-1) = substr(t2.file_name,1,instr(t2.file_name,'.')-1) AND t1.attr_value = t2.attr_value
WHERE t1.attr_name IS NULL OR t2.attr_name IS NULL 
ORDER BY t1.file_path,t1.attr_name,t2.file_path,t2.attr_name; 

SELECT * FROM ntree_elements WHERE REGEXP_LIKE(element_name,'grid','i') AND REGEXP_LIKE(attr_name,'autosizing','i') AND REGEXP_LIKE(attr_value,'.*','i') ORDER BY file_path,element_id; 
SELECT * FROM conv_elements WHERE REGEXP_LIKE(element_name,'pushbutton','i') AND REGEXP_LIKE(attr_value,'^엑셀$','i'); 

-- 버튼 비교
SELECT * FROM (SELECT * FROM ntree_elements WHERE REGEXP_LIKE(element_name,'data','i') AND REGEXP_LIKE(attr_name,'^id$','i') ) t1 
FULL OUTER JOIN 
(SELECT * FROM conv_elements WHERE REGEXP_LIKE(element_name,'pushbutton','i') AND REGEXP_LIKE(attr_name,'^name$','i') ) t2 ON t1.pgm_path = t2.pgm_path AND substr(t1.file_name,1,instr(t1.file_name,'.')-1) = substr(t2.file_name,1,instr(t2.file_name,'.')-1) AND t1.attr_value = t2.attr_value
WHERE t1.attr_name IS NULL OR t2.attr_name IS NULL 
ORDER BY t1.file_path,t1.attr_name,t2.file_path,t2.attr_name; 

SELECT * FROM ntree_elements WHERE REGEXP_LIKE(element_name,'button','i') AND REGEXP_LIKE(attr_value,'^엑셀$','i'); 
SELECT * FROM conv_elements WHERE REGEXP_LIKE(element_name,'pushbutton','i') AND REGEXP_LIKE(attr_value,'^엑셀$','i'); 

-- 
SELECT element_name,count(*) FROM ( SELECT file_path,element_name,element_id,count(*) FROM target_elements  GROUP BY file_path,element_name,element_id ) t GROUP BY element_name ORDER BY element_name;
SELECT * FROM target_elements WHERE REGEXP_LIKE(element_name,'^tab','i') AND attr_name IN ('id') ORDER BY file_path,element_id,attr_name; 
SELECT new_file_path,attr_value,count(*) FROM TARGET_ELEMENTS te WHERE attr_name = 'id' GROUP BY NEW_FILE_PATH,attr_value HAVING count(*) > 1;
SELECT * FROM target_elements WHERE REGEXP_LIKE(element_name,'.*','i') AND attr_name IN ('mask') AND  REGEXP_LIKE(attr_value,':','i') ORDER BY file_path,element_id,attr_name; 

SELECT attr_value,count(*) FROM (SELECT * FROM target_elements WHERE REGEXP_LIKE(element_name,'^button','i') AND attr_name IN ('text') ) t GROUP BY attr_value ORDER BY count(*) desc; 
SELECT * FROM target_elements WHERE REGEXP_LIKE(element_name,'^button','i') AND attr_name IN ('text') AND REGEXP_LIKE(attr_value,'expr:','i') AND gubun LIKE '%메뉴%' ORDER BY file_path,element_id,attr_name; 
SELECT * FROM target_elements WHERE REGEXP_LIKE(element_name,'^HttpObject','i') ORDER BY file_path,element_id,attr_name; 
SELECT * FROM target_elements WHERE REGEXP_LIKE(file_path,'BDM103U_TSub01C','i') ORDER BY file_path,element_id,attr_name; 
SELECT * FROM target_elements WHERE REGEXP_LIKE(file_path,'BDM103U_TSub01C','i') AND el_depth IN (1,2) ORDER BY file_path,element_id,attr_name; 
SELECT * FROM target_elements WHERE REGEXP_LIKE(file_path,'tabFrame','i') AND element_id IN (10,18,19) ORDER BY file_path,element_id,attr_name; 
SELECT * FROM target_elements WHERE REGEXP_LIKE(file_path,'bdm011p','i') AND parent_id IN (89,90) ORDER BY file_path,element_id,attr_name; 
SELECT * FROM target_elements WHERE REGEXP_LIKE(file_path,'lnd040','i') AND REGEXP_LIKE(element_name,'^dataset','i') ORDER BY file_path,element_id,attr_name; 
SELECT DISTINCT attr_name FROM target_elements WHERE REGEXP_LIKE(file_path,'.*','i') AND REGEXP_LIKE(element_name,'.*','i')  AND REGEXP_LIKE(ATTR_NAME ,'^on','i') ORDER BY file_path,element_id,attr_name; 
SELECT * FROM target_elements WHERE REGEXP_LIKE(file_path,'.*','i') AND REGEXP_LIKE(element_name,'.*','i')  AND REGEXP_LIKE(ATTR_NAME ,'autosi','i') ORDER BY file_path,element_id; 
SELECT * FROM target_elements WHERE REGEXP_LIKE(file_path,'CMF001U','i') AND REGEXP_LIKE(ATTR_VALUE ,'REQ_TY','i') ORDER BY file_path,element_id,attr_name; 
SELECT file_path,attr_name,attr_value,count(*) FROM target_elements WHERE attr_name = 'id' AND element_name <> 'Column' GROUP BY file_path,attr_name,attr_value HAVING count(*) > 1 ORDER BY file_path;
SELECT * FROM target_elements WHERE REGEXP_LIKE(file_path,'.*','i') AND REGEXP_LIKE(element_name,'layout','i')  AND REGEXP_LIKE(ATTR_NAME ,'.*','i')  ORDER BY file_path,element_id,attr_name; 
SELECT file_path,element_id,element_name,parent_id,parent_name FROM target_elements WHERE REGEXP_LIKE(file_path,'.*','i') AND REGEXP_LIKE(element_name,'layout','i')  AND REGEXP_LIKE(ATTR_NAME ,'.*','i')  GROUP BY file_path,element_id,element_name,parent_id,parent_name; 
SELECT file_path,parent_id,count(*) FROM (SELECT file_path,element_id,element_name,parent_id,parent_name FROM target_elements WHERE REGEXP_LIKE(file_path,'.*','i') AND REGEXP_LIKE(element_name,'layout','i')  AND REGEXP_LIKE(ATTR_NAME ,'.*','i')  GROUP BY file_path,element_id,element_name,parent_id,parent_name) t GROUP BY file_path,parent_id; 
SELECT file_path,count(*) FROM (SELECT file_path,element_id,element_name,parent_id,parent_name FROM target_elements WHERE REGEXP_LIKE(file_path,'.*','i') AND REGEXP_LIKE(element_name,'layout','i')  AND REGEXP_LIKE(ATTR_NAME ,'.*','i')  GROUP BY file_path,element_id,element_name,parent_id,parent_name) t GROUP BY file_path HAVING count(*) > 1 ORDER BY file_path;
SELECT file_path,parent_id,count(*) FROM (SELECT file_path,element_id,parent_id FROM target_elements WHERE REGEXP_LIKE(parent_name,'layouts','i') GROUP BY file_path,element_id,parent_id) t GROUP BY file_path,parent_id ORDER BY file_path,parent_id;
SELECT * FROM target_elements WHERE REGEXP_LIKE(file_path,'bdm011p','i') AND element_name = 'Layouts' ORDER BY file_path,element_id;
SELECT file_path,count(*) FROM (SELECT file_path,element_id,element_name,parent_id,parent_name FROM target_elements WHERE REGEXP_LIKE(file_path,'.*','i') AND REGEXP_LIKE(parent_name,'layouts','i')  AND REGEXP_LIKE(ATTR_NAME ,'.*','i')  GROUP BY file_path,element_id,element_name,parent_id,parent_name) t GROUP BY file_path HAVING count(*) > 1 ORDER BY file_path; 

SELECT file_path,element_id,element_name,count(*) FROM target_elements WHERE REGEXP_LIKE(file_path,'.*','i') AND REGEXP_LIKE(element_name,'layout','i')  AND REGEXP_LIKE(ATTR_NAME ,'.*','i')  GROUP BY file_path,element_id,element_name; 

-- 컴포넌트 스타일 관련
CREATE TABLE comp_class AS 
SELECT * FROM target_elements WHERE (file_path,element_id) IN (SELECT file_path,element_id FROM target_elements WHERE attr_name = 'class' AND attr_value IS NOT null) AND attr_name IN ('id','class','text') ORDER BY file_path,element_id;
create TABLE comp_id_class_text AS 
SELECT file_path,element_id,element_name,max(id) id, max(class) class, max(text) text FROM (
SELECT file_path,element_id,element_name,attr_value id,'' class,'' text FROM comp_class WHERE attr_name = 'id'
UNION all
SELECT file_path,element_id,element_name,'' id,attr_value class,'' text FROM comp_class WHERE attr_name = 'class'
UNION all
SELECT file_path,element_id,element_name,'' id,'' class,attr_value text FROM comp_class WHERE attr_name = 'text') T
GROUP BY file_path,element_id,element_name
ORDER BY file_path,element_id,element_name;
SELECT element_name,class,count(*) FROM comp_id_class_text GROUP BY element_name,class ORDER BY element_name,count(*) desc;
SELECT element_name,class,text,count(*) FROM comp_id_class_text GROUP BY element_name,class,text ORDER BY element_name,class,count(*) desc;
SELECT  element_name,text,class,count(*) FROM comp_id_class_text WHERE REGEXP_LIKE(text,'^\.\.\.$|^초기화$|^조회|^엑셀|^등록|^삭제|^수정|^저장|^변경|^확인','i') GROUP BY element_name,text,class ORDER BY element_name,text,class; 
SELECT  * FROM comp_id_class_text WHERE REGEXP_LIKE(text,'^등록$') ORDER BY file_path,element_id; 
SELECT  * FROM comp_id_class_text WHERE REGEXP_LIKE(class,'input_point_02') ORDER BY file_path,element_id; 

-- 컴포넌트 속성
SELECT element_name,attr_name,count(*) FROM target_elements GROUP BY element_name,attr_name ORDER BY element_name,attr_name; 



SELECT * FROM target_elements WHERE REGEXP_LIKE(file_path,'bdm007l','i') AND element_id IN (95) ORDER BY file_path,element_id,attr_name; 
SELECT * FROM target_elements WHERE element_name = 'Cell' AND REGEXP_LIKE(attr_name,'displaytype','i') ORDER BY file_path,element_id,attr_name;
SELECT * FROM target_elements WHERE REGEXP_LIKE(file_path,'.*','i') AND REGEXP_LIKE(attr_name,'.*','i')  AND REGEXP_LIKE(attr_value,'^gridCellClick','i') ORDER BY file_path,element_id;
SELECT * FROM target_elements WHERE REGEXP_LIKE(file_path,'cmf006u','i') AND element_name = 'Cell' AND REGEXP_LIKE(attr_name,'displaytype','i') AND REGEXP_LIKE(attr_value,'^button','i') ORDER BY file_path,element_id,attr_name;
SELECT * FROM target_elements WHERE element_name = 'Cell' AND REGEXP_LIKE(attr_name,'.*','i') AND REGEXP_LIKE(attr_value,'^gridCellClick','i') ORDER BY file_path,element_id,attr_name;
SELECT * FROM target_elements WHERE (file_path,element_id) IN (SELECT file_path,element_id FROM target_elements WHERE attr_name = 'displaytype' AND attr_value IS NOT null) ORDER BY file_path,element_id;
SELECT * FROM target_elements WHERE element_name = 'Cell' AND REGEXP_LIKE(attr_name,'text','i')  AND REGEXP_LIKE(attr_value,'^expr','i') ORDER BY file_path,element_id;

-- 데이터셋의 컬럼 유형 (Date 타입이 있는지 확인 필요. edit type 에 normal 인 경우 바인드된 컬럼이 Date 인 경우 , edit type 이 Date 가 됨. 나머지는 text)
DROP TABLE comp_columns;
CREATE TABLE comp_columns AS 
SELECT file_path,element_id,element_name,parent_id,max(id) id, max(coltype) coltype, max(colsize) colsize FROM (
SELECT file_path,element_id,element_name,parent_id,attr_value id,'' colTYPE,'' colsize FROM target_elements WHERE element_name = 'Column' AND parent_name = 'ColumnInfo' AND attr_name = 'id'
UNION all
SELECT file_path,element_id,element_name,parent_id,'' id,attr_value colTYPE,'' colsize FROM target_elements WHERE element_name = 'Column' AND parent_name = 'ColumnInfo' AND attr_name = 'type'
UNION all
SELECT file_path,element_id,element_name,parent_id,'' id,'' colTYPE,attr_value colsize FROM target_elements WHERE element_name = 'Column' AND parent_name = 'ColumnInfo' AND attr_name = 'size') t 
GROUP BY file_path,element_id,element_name,parent_id
ORDER BY file_path,element_id,element_name,parent_id;
SELECT * FROM COMP_COLUMNS ORDER BY file_path,element_id;  -- 전체 데이터셋 컬럼 16,794
SELECT * FROM COMP_COLUMNS WHERE id NOT IN ('codecolumn','datacolumn') ORDER BY file_path,element_id;  -- INNER dataset 제외한 실제 데이터셋 컬럼수 15,796

SELECT * FROM comp_columns a LEFT OUTER JOIN (SELECT * FROM target_elements WHERE REGEXP_LIKE(element_name,'^dataset','i') AND attr_name = 'id') b 
ON a.file_path = b.file_path AND a.parent_id = b.element_id 
ORDER BY a.file_path,a.element_id;

DROP TABLE comp_ds_cols;
CREATE TABLE comp_ds_cols AS 
SELECT a.file_path,a.element_id dsid,a.attr_value dsname,b.element_id colid FROM 
 (SELECT * FROM target_elements WHERE REGEXP_LIKE(element_name,'^dataset$','i') AND attr_name = 'id') a  -- 1,985개 데이터셋
 LEFT OUTER JOIN 
 (SELECT file_path,element_id,parent_id FROM target_elements WHERE (file_path,parent_id) IN (SELECT file_path,element_id FROM target_elements WHERE REGEXP_LIKE(element_name,'^dataset$','i') AND attr_name = 'id') AND element_name = 'ColumnInfo') b
 ON a.file_path = b.file_path AND a.element_id = b.parent_id;

SELECT * FROM comp_ds_cols ORDER BY file_path,dsid,colid; -- 컬럼 info 1,985개 (11개는 컬럼정보가 없다. 데이터셋은 정의되었으나 컬럼이 정의되어 있지 않음)
SELECT * FROM comp_ds_cols WHERE colid IS NULL ORDER BY file_path,dsid,colid;
DROP TABLE comp_ds_cols_all;
CREATE TABLE comp_ds_cols_all AS 
SELECT a.file_path,a.element_id,a.element_name,a.id,a.coltype,a.colsize,b.dsid,b.dsname,b.colid FROM comp_columns a LEFT OUTER JOIN comp_ds_cols b ON a.file_path = b.file_path AND a.parent_id = b.colid ORDER BY a.file_path,a.element_id;
SELECT * FROM target_elements WHERE REGEXP_LIKE(element_name,'^dataset','i')  ORDER BY file_path,element_id,attr_name;  
SELECT * FROM target_elements WHERE REGEXP_LIKE(file_path,'BDM140U','i') AND element_id IN (96,97,98,136,144) ORDER BY file_path,element_id,attr_name;  
SELECT * FROM target_elements WHERE REGEXP_LIKE(file_path,'BDM140U','i') AND parent_id IN (144) ORDER BY file_path,element_id,attr_name;  

SELECT * FROM COMP_DS_COLS_ALL ORDER BY file_path,element_id ;
SELECT * FROM COMP_DS_COLS_ALL WHERE id NOT IN ('codecolumn','datacolumn') ORDER BY file_path,element_id ;
SELECT * FROM COMP_DS_COLS_ALL WHERE NOT REGEXP_LIKE(coltype,'string','i') ORDER BY file_path,element_id ;

-- 특정컬럼에 바인드 된 element 확인
SELECT * FROM target_elements WHERE REGEXP_LIKE(attr_name,'^text$','i') AND substr(attr_value,instr(attr_value,':')+1) IN (SELECT id FROM COMP_DS_COLS_ALL WHERE REGEXP_LIKE(coltype,'int','i')) ;

-- MaskEdit 컴포넌트의 패턴
DROP TABLE COMP_MASKEDIT ;
CREATE TABLE comp_maskedit AS 
SELECT file_path,element_id,element_name,parent_id,max(id) id, max(mask) mask,max(limitbymask) limitbymask,max(masktype) masktype,max(readonly) readonly FROM (
SELECT file_path,element_id,element_name,parent_id,attr_value id,'' mask,'' limitbymask,'' masktype,'' readonly FROM target_elements WHERE element_name = 'MaskEdit' AND attr_name = 'id'
UNION all
SELECT file_path,element_id,element_name,parent_id,'' id,attr_value mask,'' limitbymask,'' masktype,'' readonly FROM target_elements WHERE element_name = 'MaskEdit' AND attr_name = 'mask'
UNION all
SELECT file_path,element_id,element_name,parent_id,'' id,'' mask,attr_value limitbymask,'' masktype,'' readonly FROM target_elements WHERE element_name = 'MaskEdit' AND attr_name = 'limitbymask'
UNION all
SELECT file_path,element_id,element_name,parent_id,'' id,'' mask,'' limitbymask,attr_value masktype,'' readonly FROM target_elements WHERE element_name = 'MaskEdit' AND attr_name = 'type'
UNION all
SELECT file_path,element_id,element_name,parent_id,'' id,'' mask,'' limitbymask,'' masktype,attr_value readonly FROM target_elements WHERE element_name = 'MaskEdit' AND attr_name = 'readonly') t 
GROUP BY file_path,element_id,element_name,parent_id
ORDER BY file_path,element_id,element_name,parent_id;

SELECT * FROM COMP_MASKEDIT ORDER BY file_path,element_id;
SELECT * FROM COMP_MASKEDIT WHERE REGEXP_LIKE(ID,'rate','i') ORDER BY file_path,element_id;
SELECT * FROM COMP_MASKEDIT WHERE REGEXP_LIKE(mask,'^####-##-##$','i') ORDER BY file_path,element_id;
SELECT * FROM TARGET_ELEMENTS WHERE element_name = 'MaskEdit' ORDER BY file_path,element_id,attr_name;

-- 라디오 버튼 
DROP TABLE COMP_RADIO ;
CREATE TABLE comp_radio AS 
SELECT file_path,element_id,element_name,parent_id,max(id) id, max(direction) direction,max(radioindex) radioindex, max(value) value,max(columncount) columncount,max(rowcount) rowcount,max(codecolumn) codecolumn,max(datacolumn) datacolumn FROM (
SELECT file_path,element_id,element_name,parent_id,attr_value id,'' direction,'' radioindex,'' value,'' columncount,'' rowcount,'' codecolumn,'' datacolumn FROM target_elements WHERE element_name = 'Radio' AND attr_name = 'id'
UNION all
SELECT file_path,element_id,element_name,parent_id,'' id,attr_value direction,'' radioindex,'' value,'' columncount,'' rowcount,'' codecolumn,'' datacolumn FROM target_elements WHERE element_name = 'Radio' AND attr_name = 'direction'
UNION all
SELECT file_path,element_id,element_name,parent_id,'' id,'' direction,attr_value radioindex,'' value,'' columncount,'' rowcount,'' codecolumn,'' datacolumn FROM target_elements WHERE element_name = 'Radio' AND attr_name = 'index'
UNION all
SELECT file_path,element_id,element_name,parent_id,'' id,'' direction,'' radioindex,attr_value value,'' columncount,'' rowcount,'' codecolumn,'' datacolumn FROM target_elements WHERE element_name = 'Radio' AND attr_name = 'value'
UNION all
SELECT file_path,element_id,element_name,parent_id,'' id,'' direction,'' radioindex,'' value,attr_value columncount,'' rowcount,'' codecolumn,'' datacolumn FROM target_elements WHERE element_name = 'Radio' AND attr_name = 'columncount'
UNION all
SELECT file_path,element_id,element_name,parent_id,'' id,'' direction,'' radioindex,'' value,'' columncount,attr_value rowcount,'' codecolumn,'' datacolumn FROM target_elements WHERE element_name = 'Radio' AND attr_name = 'rowcount'
UNION all
SELECT file_path,element_id,element_name,parent_id,'' id,'' direction,'' radioindex,'' value,'' columncount,'' rowcount,attr_value codecolumn,'' datacolumn FROM target_elements WHERE element_name = 'Radio' AND attr_name = 'codecolumn'
UNION all
SELECT file_path,element_id,element_name,parent_id,'' id,'' direction,'' radioindex,'' value,'' columncount,'' rowcount,'' codecolumn,attr_value datacolumn FROM target_elements WHERE element_name = 'Radio' AND attr_name = 'datacolumn') t 
GROUP BY file_path,element_id,element_name,parent_id
ORDER BY file_path,element_id,element_name,parent_id;
SELECT * FROM comp_radio ORDER BY file_path,element_id;
SELECT * FROM TARGET_ELEMENTS WHERE element_name = 'Radio' ORDER BY file_path,element_id,attr_name;

-- 특정 element 의 속성 조합

SELECT file_path,element_id,max(id) id,max(progid) progid FROM (
	SELECT file_path,element_id,attr_value id,'' progid  FROM target_elements WHERE REGEXP_LIKE(ELEMENT_NAME,'^ActiveX','i')  AND REGEXP_LIKE(ATTR_NAME,'^id$','i') 
	UNION all
	SELECT file_path,element_id,'' id,attr_value progid  FROM target_elements WHERE REGEXP_LIKE(ELEMENT_NAME,'^ActiveX','i')  AND REGEXP_LIKE(ATTR_NAME,'^progid$','i') )
GROUP BY file_path,element_id
ORDER BY file_path,element_id;

SELECT * FROM targets ORDER BY file_name;
DELETE FROM targets WHERE REGEXP_LIKE(file_name,'bdm204l|jsp$','i'); 
COMMIT;
SELECT * FROM target_elements;
SELECT * FROM target_elements WHERE REGEXP_LIKE(pgm_fullpath,'CMC313P','i') ORDER BY PGM_FULLPATH ;
SELECT * FROM menus WHERE REGEXP_LIKE(menu_nm,'.*','i') AND  REGEXP_LIKE(PGM_ID,'.*CMC313P','i') ORDER BY sort ;
SELECT * FROM menus WHERE REGEXP_LIKE(MENU_NM,'파트|시스템|캠페인|업무지원|심사진행','i') ORDER BY sort;
SELECT * FROM menus WHERE sort2 IN (1) AND MENU_LVL IN (1) ORDER BY sort; -- 상단 8개 메뉴 아이템
SELECT * FROM menus WHERE UP_MENU_CD in ('bd') ORDER BY sort; -- 상단 채권관리에 대한 하위메뉴 (좌측메뉴)
SELECT * FROM menus WHERE MENU_CD in ('bc0368') ORDER BY sort; 

--

SELECT * FROM target_elements;
SELECT substr(file_name,1,instr(file_name,'.')-1) FROM targets;
SELECT * FROM elements_t;
CREATE TABLE target_elements AS SELECT targets a INNER JOIN elements_t b ON a.pgm_path = b.pgm_path AND a.file_name = b.file_name;

SELECT * FROM scripts;
SELECT * FROM scripts WHERE REGEXP_LIKE(file_path,'BDM951P','i'); 
SELECT CASE substr(file_name,INSTR(file_name,'.',-1)+1) WHEN 'xfdl' THEN REPLACE (file_path,'.xfdl','.js') WHEN 'xjs' THEN REPLACE (file_path,'.xjs','.js') END AS file_path_js,script_text  FROM scripts ORDER BY file_name;
SELECT substr(file_name,INSTR(file_name,'.')+1) FROM scripts;
SELECT file_ext,count(*) FROM (SELECT substr(file_name,INSTR(file_name,'.',-1)+1) file_ext FROM scripts) GROUP BY file_ext;

SELECT CASE substr(file_name,INSTR(file_name,'.',-1)+1) WHEN 'xfdl' THEN REPLACE (file_path,'.xfdl','.js') WHEN 'xjs' THEN REPLACE (file_path,'.xjs','.js') END AS file_path_js,script_text  FROM scripts ORDER BY file_name;

TRUNCATE TABLE scripts;

SELECT * FROM menus WHERE REGEXP_LIKE(MENU_NM,'.*','i') and REGEXP_LIKE(PGM_ID,'MBA','i') ORDER BY sort;
SELECT * FROM menus WHERE REGEXP_LIKE(PGM_ID,'lnc99','i') ORDER BY sort;
SELECT * FROM menus WHERE REGEXP_LIKE(MENU_NM,'중앙회|신용','i') ORDER BY sort;

SELECT  instr(pgm_id,':',-1)+1,instr(pgm_id,'.',-1),substr(pgm_id,instr(pgm_id,':',-1)+1),substr(pgm_id,instr(pgm_id,':',-1)+1,instr(pgm_id,'.',-1) - instr(pgm_id,':',-1) -1),pgm_id FROM menus WHERE  REGEXP_LIKE(MENU_NM,'중앙회|신용','i') ORDER BY sort ;

SELECT  * FROM menus 
WHERE substr(pgm_id,instr(pgm_id,':',-1)+1) 
  IN (SELECT file_name  FROM elements WHERE REGEXP_LIKE(file_path,'ntreeworks.+','i') AND REGEXP_LIKE(ELEMENT_NAME,'^timer','i'))  
ORDER BY sort ;

SELECT * FROM menus;
SELECT * FROM menus_t;
SELECT substr(pgm_id,1,2),pgm_id FROM menus;
drop TABLE menus_t;
CREATE TABLE menus_t AS SELECT substr(pgm_id,1,2) pgm_path,substr(pgm_id,instr(pgm_id,':',-1)+1) file_name  FROM menus WHERE pgm_id IS NOT null;
SELECT file_path,substr(file_path,instr(file_path,'\',-1)-2,2),file_name FROM elements;


TRUNCATE TABLE elements;
SELECT * FROM menus_t a LEFT OUTER JOIN elements_t b 
ON a.pgm_path = b.pgm_path AND a.file_name = b.file_name
WHERE b.pgm_path IS null;

DELETE FROM elements WHERE file_path LIKE 'C:\nTree\workspace\DBSB.nTreeWorks\Web\xui\convert%';
COMMIT;
DROP TABLE targets;
CREATE TABLE targets (gubun varchar2(16),menu1 varchar2(32), menu2 varchar2(32),menu3 varchar2(64), scr_id varchar2(64), pgm_path varchar2(16), pgm_fullpath varchar2(64), pgm_name varchar2(32), use_yn varchar2(1), scr_type varchar2(16), dev_yn varchar2(16), rpt_nm NUMBER, menu_yn varchar2(1), realuse_yn varchar2(1), important_yn varchar2(8), freq_yn varchar2(8) , file_name varchar2(64), manager varchar2(16), menureg_yn varchar2(16), comments varchar2(512));
TRUNCATE TABLE targets;
SELECT * FROM targets;
SELECT column_name FROM dba_tab_columns WHERE table_name = 'TARGETS' ORDER BY column_id;
COMMIT;

SELECT * FROM targets a LEFT OUTER JOIN elements_t b ON a.pgm_path = b.pgm_path AND a.file_name = b.file_name WHERE b.file_name IS NULL AND NOT REGEXP_LIKE(a.file_name,'jsp$','i') ;

SELECT * FROM elements_t WHERE upper(FILE_NAME) IN ('MYFRAME.XFDL');

--
insert into targets values('메뉴','채권관리','','','','bd','','','Y','','',1,'','Y','','','BDM001L','장목비','','');
COMMIT;

UPDATE elements_t SET pgm_path = 'frame' WHERE upper(FILE_NAME) IN ('ALERTPOP.XFDL',
'LEFTFRAME.XFDL',
'COMMFRAME.XFDL',
'PASSWORDCHG.XFDL',
'TOPFRAME.XFDL',
'LOGIN.XFDL',
'TABFRAME.XFDL',
'MYFRAME.XFDL',
'WORKFRAME.XFDL');

COMMIT;

SELECT * FROM 
( SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'C:\\CONV_RESULT\\screen_0903_hint\\forcompare\\CPA010P.xml','i' )) OL
FULL OUTER JOIN 
( SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'C:\\CONV_RESULT\\screen_0903_hint\\CPA010P.xml','i' )) NE
ON ol.element_name = ne.element_name AND ol.parent_name =ne.parent_name AND ol.attr_name = ne.attr_name AND ol.attr_value = ne.attr_value AND ol.control_id = ne.control_id
ORDER BY ol.file_path,ol.element_id,ol.attr_name,ne.element_id,ne.attr_name;

SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'screen_0903_hint','i'); 
SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'screen_0903_hint.*forcompare','i'); 
DELETE FROM elements WHERE REGEXP_LIKE(file_path,'screen_0903_hint','i'); 
COMMIT;
SELECT * FROM elements_t WHERE REGEXP_LIKE(file_path,'ntree.+myframe','i'); 

SELECT file_path,element_id,count(*) FROM elements WHERE REGEXP_LIKE(file_path,'C:\\CONV_RESULT\\screen_0903_hint\\forcompare\\CPA010P.xml','i' ) GROUP BY file_path,element_id ORDER BY 1,2;
SELECT file_path,element_id,attr_name,attr_value FROM elements WHERE REGEXP_LIKE(file_path,'C:\\CONV_RESULT\\screen_0903_hint\\forcompare\\CPA010P.xml','i' ) AND attr_name = 'control_id' AND attr_value IS NOT NULL;

UPDATE elements e 
   SET e.control_id = ( SELECT c.attr_value 
                          FROM elements_c c 
	                     WHERE c.file_path = e.file_path AND c.element_id = e.element_id ) 
 WHERE exists (SELECT 0 
               FROM elements_c c  
              WHERE c.file_path = e.file_path AND c.element_id = e.element_id);

SELECT file_path,element_id,attr_name,attr_value FROM elements WHERE REGEXP_LIKE(file_path,'C:\\CONV_RESULT\\screen_0903_hint','i' ) AND attr_name = 'control_id' AND attr_value IS NOT NULL;
SELECT * FROM elements;
CREATE TABLE elements_c AS 
SELECT file_path,element_id,attr_value 
                                  FROM elements 
                                 WHERE REGEXP_LIKE(file_path,'C:\\CONV_RESULT\\screen_0903_hint','i' ) 
                                   AND attr_name = 'control_id' 
                                   AND attr_value IS NOT NULL;
SELECT * FROM XF_PUSHBUTTON ORDER BY file_path,element_id;
SELECT STYLE,count(*) FROM XF_PUSHBUTTON xp WHERE NOT REGEXP_LIKE(file_path,'^c:\\xFrame.*frame','i' ) GROUP BY STYLE ORDER BY 2 DESC;     
SELECT * FROM XF_PUSHBUTTON xp WHERE NOT REGEXP_LIKE(file_path,'frame','i' ) AND REGEXP_LIKE(STYLE,'btn_TopQmenu11','i') ORDER BY file_path,element_id; 

