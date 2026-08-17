SELECT * FROM elements;

DROP TABLE all_elements;
CREATE TABLE all_elements AS SELECT file_path,element_id,element_name,parent_id,parent_name,el_depth,control_id,grid_depth FROM elements GROUP BY file_path,element_id,element_name,parent_id,parent_name,el_depth,control_id,grid_depth;
SELECT * FROM all_elements ORDER BY file_path,element_id;

DROP TABLE all_elements_info;
CREATE TABLE all_elements_info AS 
SELECT a.*,b.attr_value control_name FROM all_elements a LEFT OUTER JOIN (SELECT * FROM elements WHERE attr_name = 'name') b ON a.file_path = b.file_path AND a.element_id = b.element_id AND a.element_name = b.element_name;
SELECT * FROM all_elements WHERE element_name IN ('data') ORDER BY file_path,element_id,el_depth;
SELECT * FROM all_elements_info ORDER BY file_path,element_id;

DROP TABLE ELEMENTS_MAPINFO_DETAIL ;
CREATE TABLE ELEMENTS_MAPINFO_DETAIL 
   (	FILE_PATH VARCHAR2(512), 
	ELEMENT_ID NUMBER, 
	FCODE VARCHAR2(64), 
	DEFAULTMAP NUMBER, 
	CONTROL_ID NUMBER,
	COntrol_name varchar2(64),
    element_name varchar2(64),
	HEADER_HORZCOUNT VARCHAR2(8), 
	ATTR_VALUE VARCHAR2(8), 
	INPUT_ORDER VARCHAR2(8), 
	OUTPUT_ORDER VARCHAR2(8), 
	MAPINFO_ORDER NUMBER
   ) ;
  
--
-- grid columns 
--
DROP TABLE all_data_columns;
CREATE TABLE all_data_columns AS
SELECT a.file_path,a.element_id,a.element_name,a.parent_id,a.parent_name,a.grid_depth,a.control_name column_name,b.element_id column_element_id,b.parent_id column_parent_id,b.parent_name column_parent_name FROM (SELECT * FROM all_elements_info WHERE element_name = 'data') a LEFT OUTER JOIN (SELECT * FROM all_elements_info WHERE element_name = 'column') b
ON a.file_path = b.file_path AND a.parent_id = b.element_id;
SELECT * FROM all_data_columns;

DROP TABLE all_grids;
CREATE TABLE all_grids AS
SELECT * FROM  all_elements_info WHERE element_name IN ('grid','multilinegrid','treegrid');
SELECT * FROM all_grids;

DROP TABLE all_data_column_grids;
CREATE TABLE all_data_column_grids AS
SELECT a.*,b.element_id grid_element_id,b.control_id grid_control_id,b.control_name grid_control_name FROM all_data_columns a LEFT OUTER JOIN all_grids b ON a.file_path = b.file_path AND a.column_parent_id = b.element_id;
SELECT * FROM all_data_column_grids ORDER BY file_path,grid_control_id,grid_depth;

SELECT substr(file_path,33,instr(file_path,'\',-1) -33) gubun,substr(file_path,instr(file_path,'\',-1)+1,instr(file_path,'.',-1) -instr(file_path,'\',-1) -1) screenid
,substr(file_path,33) sub_file_path,file_path,element_id,element_name,parent_id,parent_name,grid_depth,column_name,column_element_id,column_parent_id,column_parent_name
,grid_element_id,grid_control_id,grid_control_name FROM all_data_column_grids ORDER BY file_path,grid_control_id,grid_depth;

CREATE TABLE all_data_info_temp as
SELECT file_path,element_id,parent_id,to_number(grid_depth) grid_depth,to_number(max(width)) width,to_number(max(height)) height,max(STYLE) style FROM (
SELECT file_path,element_id,parent_id,grid_depth,attr_value width,'' height,'' style FROM elements WHERE element_name = 'data' AND attr_name = 'width'
UNION ALL 
SELECT file_path,element_id,parent_id,grid_depth,'' width,attr_value height,'' style FROM elements WHERE element_name = 'data' AND attr_name = 'height'
UNION ALL 
SELECT file_path,element_id,parent_id,grid_depth,'' width,'' height,attr_value style FROM elements WHERE element_name = 'data' AND attr_name = 'style')
GROUP BY file_path,element_id,parent_id,grid_depth;

CREATE TABLE all_data_infos AS 
SELECT a.*,b.width,b.height,b.style FROM all_data_column_grids a LEFT OUTER JOIN all_data_info_temp b ON a.file_path = b.file_path AND a.element_id = b.element_id AND a.grid_depth = b.grid_depth;

SELECT * FROM all_data_infos ORDER BY file_path,grid_control_id,grid_depth;
SELECT * FROM all_data_infos WHERE width IS NULL ORDER BY file_path,grid_control_id,grid_depth ;

--
-- all fields and combobox size compare 
--
SELECT DISTINCT element_name FROM elements ORDER BY element_name;

DROP TABLE all_fields_infos_temp;
CREATE TABLE all_fields_infos_temp as
SELECT file_path,element_id,parent_id,to_number(max(width)) width,to_number(max(height)) height,max(style) STYLE FROM (
SELECT file_path,element_id,parent_id,attr_value width,'' height,'' style FROM elements WHERE element_name IN ('normal_field','numericex_field','hangul_field','password_field','combobox') AND attr_name = 'width'
UNION ALL 
SELECT file_path,element_id,parent_id,'' width,attr_value height,'' style FROM elements WHERE element_name IN ('normal_field','numericex_field','hangul_field','password_field','combobox') AND attr_name = 'height'
UNION ALL 
SELECT file_path,element_id,parent_id,'' width,'' height,attr_value style FROM elements WHERE element_name IN ('normal_field','numericex_field','hangul_field','password_field','combobox') AND attr_name = 'style')
GROUP BY file_path,element_id,parent_id;

CREATE TABLE all_fields_infos AS 
SELECT a.*,b.width,b.height,b.style FROM (SELECT * FROM ALL_ELEMENTS_INFO WHERE element_name IN ('normal_field','numericex_field','hangul_field','password_field','combobox')) a 
LEFT OUTER JOIN all_fields_infos_temp b ON a.file_path = b.file_path AND a.element_id = b.element_id AND a.parent_id = b.parent_id;
SELECT * FROM all_fields_infos ORDER BY file_path,control_id;

--
-- all control name 비교
--
SELECT * FROM all_elements_info;
SELECT * FROM 
    (SELECT substr(file_path,33) sub_file_path,element_name,control_id,control_name FROM all_elements_info WHERE control_id >= 0 AND control_name IS NOT null) a 
		LEFT OUTER JOIN 
	(SELECT substr(file_path,33) sub_file_path,element_name,control_id,control_name FROM all_elements_info WHERE control_id >= 0 AND control_name IS NOT null) b 
ON a.sub_file_path = b.sub_file_path AND a.control_name = b.control_name WHERE b.sub_file_path IS NULL ORDER BY a.sub_file_path,a.control_id;

--
-- all mapinfo compare
--
SELECT * FROM elements_mapinfo_detail;
DROP TABLE asis_elements_mapinfo_detail;
CREATE TABLE asis_elements_mapinfo_detail AS
SELECT substr(file_path,26) sub_file_path,substr(file_path,instr(file_path,'\',-1)+1,instr(file_path,'.',-1) - instr(file_path,'\',-1) -1) screenid
,substr(file_path,40,instr(file_path,'\',-1) - 40) gubun
,element_id,fcode,defaultmap,control_id,control_name,element_name,HEADER_HORZCOUNT,ATTR_VALUE,INPUT_ORDER,OUTPUT_ORDER, MAPINFO_ORDER  FROM elements_mapinfo_detail;
SELECT * FROM ASIS_ELEMENTS_MAPINFO_DETAIL ;
SELECT count(*) FROM asis_elements_mapinfo_detail;

DROP TABLE tobe_elements_mapinfo_detail;
CREATE TABLE tobe_elements_mapinfo_detail AS 
SELECT substr(file_path,26) sub_file_path,substr(file_path,instr(file_path,'\',-1)+1,instr(file_path,'.',-1) - instr(file_path,'\',-1) -1) screenid
,substr(file_path,40,instr(file_path,'\',-1) - 40) gubun
,element_id,fcode,defaultmap,control_id,control_name,element_name,HEADER_HORZCOUNT,ATTR_VALUE,INPUT_ORDER,OUTPUT_ORDER, MAPINFO_ORDER  FROM elements_mapinfo_detail;
SELECT * FROM tobe_elements_mapinfo_detail;
SELECT count(*) FROM tobe_elements_mapinfo_detail;

DROP TABLE ASIS_TOBE_MAPS_TEMP ;
CREATE TABLE asis_tobe_maps_temp as
SELECT a.*,b.sub_file_path bsub_file_path,b.screenid bscreenid,b.gubun bgubun,b.element_id belement_id,b.fcode bfcode,b.defaultmap bdefaultmap,b.control_id bcontrol_id
,b.control_name bcontrol_name,b.element_name belement_name,b.header_horzcount bheader_horzcount,b.attr_value battr_value,b.input_order binput_order
,b.output_order boutput_order,b.mapinfo_order bmapinfo_order FROM asis_elements_mapinfo_detail a FULL OUTER JOIN tobe_elements_mapinfo_detail b 
ON a.sub_file_path = b.sub_file_path AND a.fcode = b.fcode AND a.mapinfo_order = b.mapinfo_order ;

SELECT * FROM ASIS_TOBE_MAPS_TEMP ORDER BY sub_file_path,fcode,mapinfo_order,bsub_file_path,bfcode,bmapinfo_order;

-- CDDBA1.ASIS_TOBE_MAPS_TEMP definition
CREATE SEQUENCE ASIS_TOBE_MAPS_SEQ
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
   
  SELECT * FROM v$version;
  
 SELECT column_name||',' FROM ALL_TAB_COLUMNS WHERE table_name LIKE 'ASIS_TOBE_MAPS' ORDER BY column_id;
 
DROP TABLE asis_tobe_maps;
CREATE TABLE asis_tobe_maps as
SELECT ASIS_TOBE_MAPS_SEQ.nextval seq,
SUB_FILE_PATH,
SCREENID,
GUBUN,
ELEMENT_ID,
FCODE,
DEFAULTMAP,
CONTROL_ID,
CONTROL_NAME,
ELEMENT_NAME,
HEADER_HORZCOUNT,
ATTR_VALUE,
INPUT_ORDER,
OUTPUT_ORDER,
MAPINFO_ORDER,
BSUB_FILE_PATH,
BSCREENID,
BGUBUN,
BELEMENT_ID,
BFCODE,
BDEFAULTMAP,
BCONTROL_ID,
BCONTROL_NAME,
BELEMENT_NAME,
BHEADER_HORZCOUNT,
BATTR_VALUE,
BINPUT_ORDER,
BOUTPUT_ORDER,
BMAPINFO_ORDER FROM ASIS_TOBE_MAPS_TEMP ;

ALTER TABLE asis_tobe_maps add (
	ALL_equals varchar2(1), --mapinfo_order , control_id, attr_value, input_order, OUTPUT_order 모두 일치
	attr_notequals varchar2(1), --mapinfo_order, control_id, input_order, output_order 는 일치하나 attr_value 불일치
	input_notequals varchar2(1), -- mapinfo_order, control_id, attr_value, output_order 는 일치하지만 input_order 불일치
	output_notequals varchar2(1), --mapinfo_order, control_id, attr_value, input_order 는 일치하지만 output_order 불일치
	maporder_notequals varchar2(1), -- mapinfo_order, control_id 가 불일치
	oneside varchar2(1) -- mapinfo_order 가 asis 또는 tobe 에만 있는 것	
);

SELECT * FROM asis_tobe_maps ORDER BY sub_file_path,fcode,mapinfo_order,bsub_file_path,bfcode,bmapinfo_order;

UPDATE asis_tobe_maps SET all_equals = 'Y' WHERE sub_file_path = bsub_file_path AND fcode = bfcode = AND mapinfo_order = bmapinfo_order 
AND control_id = bcontrol_id AND control_name = bcontrol_name AND attr_value = battr_value AND input_order = binput_order AND output_order = boutput_order;

UPDATE asis_tobe_maps SET attr_notequals = 'Y' WHERE sub_file_path = bsub_file_path AND fcode = bfcode = AND mapinfo_order = bmapinfo_order 
AND control_id = bcontrol_id AND control_name = bcontrol_name AND attr_value <> battr_value AND input_order = binput_order AND output_order = boutput_order;

UPDATE asis_tobe_maps SET input_notequals = 'Y' WHERE sub_file_path = bsub_file_path AND fcode = bfcode = AND mapinfo_order = bmapinfo_order 
AND control_id = bcontrol_id AND control_name = bcontrol_name and input_order <> binput_order ;

UPDATE asis_tobe_maps SET output_notequals = 'Y' WHERE sub_file_path = bsub_file_path AND fcode = bfcode = AND mapinfo_order = bmapinfo_order 
AND control_id = bcontrol_id AND control_name = bcontrol_name and output_order <> boutput_order ;

UPDATE asis_tobe_maps SET maporder_notequals = 'Y' WHERE sub_file_path = bsub_file_path AND fcode = bfcode = AND mapinfo_order = bmapinfo_order 
AND control_id <> bcontrol_id ;

UPDATE asis_tobe_maps SET oneside = 'A' WHERE bsub_file_path IS null;
UPDATE asis_tobe_maps SET oneside = 'T' WHERE sub_file_path IS null;
