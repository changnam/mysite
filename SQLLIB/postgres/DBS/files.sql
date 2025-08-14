CREATE TABLE filecontents (id NUMBER,file_path varchar2(512),file_name varchar2(64),file_ext varchar2(32),line_num NUMBER,line_text clob,work_timestamp timestamp, PRIMARY KEY (id));

DROP TABLE files;
TRUNCATE TABLE files;
CREATE TABLE files (id NUMBER,file_path varchar2(512),file_name varchar2(128),file_size NUMBER,file_ext varchar2(32), last_mod_time timestamp ,last_access_time timestamp,creation_time timestamp, runjob_time timestamp, runjob_id NUMBER);
TRUNCATE TABLE files;
DELETE FROM files WHERE REGEXP_LIKE(file_path,'project.+DSI','i');
DELETE FROM files WHERE REGEXP_LIKE(file_path,'C:\\xFrame\\project\\DSI\\screen','i');
DELETE FROM files WHERE REGEXP_LIKE(file_path,'project.+DSI.+bdm029l|project.+DSI.+bdm977l|project.+DSI.+bdm953l','i');
COMMIT;


SELECT * FROM files;
SELECT count(*) FROM files;
SELECT * FROM files WHERE REGEXP_LIKE(file_path,'dsi.+ibos','i') ORDER BY file_path; 
SELECT * FROM files WHERE REGEXP_LIKE(file_path,'project.+DSI.+bdm953l','i') ORDER BY file_path; 

SELECT * FROM (SELECT * FROM files WHERE REGEXP_LIKE(file_path,'dsi.+ibos','i')) A INNER JOIN (SELECT * FROM files WHERE REGEXP_LIKE(file_path,'황태영','i')) B
ON a.file_name = b.file_name AND a.file_ext = b.file_ext ORDER BY a.file_name;

SELECT * FROM files WHERE REGEXP_LIKE(file_path,'Z:\\098. 공유문서\\여신관리시스템구축 산출물','i') ORDER BY file_path;

SELECT * FROM files WHERE REGEXP_LIKE(file_name,'bdm100p_tsub07','i') ORDER BY file_path; 
SELECT * FROM files WHERE REGEXP_LIKE(file_name,'매뉴얼|가이드','i') ORDER BY file_path; 

SELECT * FROM files WHERE REGEXP_LIKE(FILE_EXT ,'hlp|html|chm|tif|pdf','i') ORDER BY file_path; 
SELECT * FROM files WHERE REGEXP_LIKE(FILE_EXT ,'bak','i') ORDER BY file_path;

SELECT * FROM files WHERE REGEXP_LIKE(file_path,'ntree.+workspace','i') AND REGEXP_LIKE(FILE_EXT ,'^js$','i') ORDER BY file_path; 
SELECT 'node --check '||file_path ||' >> node_check.txt 2>&1'FROM files WHERE REGEXP_LIKE(file_path,'C:\\xFrame\\project\\DSI\\screen\\NTREE','i') AND REGEXP_LIKE(FILE_EXT ,'^js$','i') 
AND NOT REGEXP_LIKE(file_name,'_\d{4}\.js$|_bk\.js$|_old\.js$','i') ORDER BY file_path; 
SELECT 'node runBabelPlugin.js '||file_path ||' >> jsfiles_insert.txt 2>&1'FROM files WHERE REGEXP_LIKE(file_path,'C:\\xFrame\\project\\DSI\\screen\\NTREE','i') AND REGEXP_LIKE(FILE_EXT ,'^js$','i')
AND NOT REGEXP_LIKE(file_name,'_\d{4}\.js$|_bk\.js$|_old\.js$','i') ORDER BY file_path; 
SELECT 'node runBabelTrans.js '||file_path FROM files WHERE REGEXP_LIKE(file_path,'C:\\xFrame\\project\\DSI\\screen\\_SYS|nTreeUtil|SYSLog|bdm081l|bdm082p|lnc002u|bdm103u|bdm001l|cmc033p|cmc315p','i') 
AND NOT REGEXP_LIKE(file_path,'C:\\conv','i') AND NOT REGEXP_LIKE(file_path,'C:\\ntree','i') AND NOT REGEXP_LIKE(file_path,'C:\\screen','i') 
AND NOT REGEXP_LIKE(file_path,'_sys\\backup|_sys\\test','i') AND NOT REGEXP_LIKE(file_path,'TSWayComm_EX|SpvsrAthorPopup_1|SpvsrAthorPopup_ex','i') 
AND REGEXP_LIKE(FILE_EXT ,'^js$','i')
AND NOT REGEXP_LIKE(file_name,'_\d{4}\.js$|_bk\.js$|_old\.js$','i') ORDER BY file_path; 

SELECT * FROM files WHERE REGEXP_LIKE(file_path,'ntree.+workspace','i') AND REGEXP_LIKE(FILE_EXT ,'js','i') AND NOT REGEXP_LIKE(FILE_EXT ,'^js$','i')  ORDER BY file_path; 

SELECT * FROM files WHERE REGEXP_LIKE(FILE_EXT ,'\.dfm$','i') ORDER BY file_path; 
SELECT * FROM files WHERE REGEXP_LIKE(FILE_EXT ,'^dfm$|doc|pdf|ppt','i') ORDER BY file_path; 
SELECT * FROM FILES WHERE REGEXP_LIKE(file_path,'C:\\xFrame\\project\\DSI\\screen\\NTREE','i') AND REGEXP_LIKE(FILE_EXT ,'^XML$','i');
SELECT * FROM FILES WHERE REGEXP_LIKE(file_path,'C:\\xFrame\\project\\DSI\\screen\\NTREE','i') AND REGEXP_LIKE(FILE_EXT ,'^XML$','i');
SELECT * FROM -- XML 은 있는데, JS가 없는건 1개 Component_Button.xml
(SELECT * FROM FILES WHERE REGEXP_LIKE(file_path,'C:\\xFrame\\project\\DSI\\screen\\NTREE','i') AND REGEXP_LIKE(FILE_EXT ,'^XML$','i')) A
LEFT OUTER JOIN 
(SELECT * FROM FILES WHERE REGEXP_LIKE(file_path,'C:\\xFrame\\project\\DSI\\screen\\NTREE','i') AND REGEXP_LIKE(FILE_EXT ,'^JS$','i')) B
ON SUBSTR(A.FILE_PATH,1,INSTR(A.FILE_PATH,'.')-1) = SUBSTR(B.FILE_PATH,1,INSTR(B.FILE_PATH,'.')-1)
WHERE B.FILE_PATH IS NULL
;

SELECT * FROM -- target에 없는 파일 목록 (xml 기준 , 12개)
(SELECT  REPLACE(substr(file_path,36,instr(file_path,'.',-1)-36),'\\','\') new_file_path,file_path FROM FILES WHERE REGEXP_LIKE(file_path,'C:\\xFrame\\project\\DSI\\screen\\NTREE','i') AND REGEXP_LIKE(FILE_EXT ,'^XML$','i')) A
LEFT OUTER JOIN  
(SELECT pgm_path||'\'||substr(file_name,1,instr(file_name,'.')-1) new_file_path FROM targets ) B
ON A.new_FILE_PATH = B.new_FILE_PATH
WHERE B.new_FILE_PATH IS NULL
;

SELECT 'C:\Users\DBSB\Desktop\dfm2xml.exe '||file_path||' > '||substr(file_path,) FROM files WHERE REGEXP_LIKE(FILE_EXT ,'^dfm$','i') ORDER BY file_path; 

SELECT 'C:\Users\DBSB\Desktop\dfm2xml.exe '||file_path||' > '||file_name FROM files WHERE REGEXP_LIKE(FILE_EXT ,'^dfm$','i') ORDER BY file_path; 


SELECT * FROM files WHERE REGEXP_LIKE(FILE_PATH,'ntree','i') ORDER BY file_path; 
SELECT * FROM files WHERE REGEXP_LIKE(FILE_PATH,'ntree','i') AND REGEXP_LIKE(FILE_EXT,'css','i') ORDER BY file_path; 

DELETE FROM targets WHERE REGEXP_LIKE(file_name,'bdm001l','i'); 
DELETE FROM targets WHERE upper(substr(file_name,instr(file_name,'.')+1)) = 'JSP'; -- 제외대상 12개
DELETE FROM targets WHERE REGEXP_LIKE(file_name,'^bdm204l\.xfdl$','i'); -- 제외대상 1개
DELETE FROM targets WHERE REGEXP_LIKE(file_name,'^cmc314p\.xfdl$|^cmc365p\.xfdl$','i'); -- 제외대상 2개, 표준산업분류코드
DELETE FROM targets WHERE REGEXP_LIKE(file_name,'^bdm029l\.xfdl$|^bdm977l\.xfdl$|^bdm953l\.xfdl$','i'); -- 제외대상 3개 (6/3), 여신거래내역외
COMMIT;
insert into targets values('메뉴','채권관리','','','','bd','','','Y','','',1,'','Y','','','BDM001L.xfdl','장목비','','');

SELECT * FROM targets WHERE upper(substr(file_name,instr(file_name,'.')+1)) <> 'JSP';
SELECT upper(substr(file_name,instr(file_name,'.')+1)) FROM targets;

SELECT * FROM 
(SELECT substr(file_name,1,instr(file_name,'.')-1) filename FROM targets WHERE upper(substr(file_name,instr(file_name,'.')+1)) <> 'JSP') t1 
FULL OUTER JOIN 
(SELECT substr(file_name,1,instr(file_name,'.')-1) filename FROM files WHERE REGEXP_LIKE(file_path,'c:\\screen','i')  AND REGEXP_LIKE(FILE_EXT ,'^xml$','i') ) t2
ON t1.filename = t2.filename
WHERE t2.filename IS null
ORDER BY t1.filename,t2.filename;

-- 
SELECT 'echo F | xcopy "C:\Users\DBSB\Downloads\20240507_nTree_Source\'||pgm_path||'\'||file_name||'" "C:\CONV_TARGET\'||pgm_path||'\'||file_name||'" /Y' FROM TARGETS t WHERE manager IS NOT NULL ORDER BY 1 ;
SELECT * FROM files WHERE REGEXP_LIKE(file_path,'project.+DSI\\screen\\ntree','i') AND REGEXP_LIKE(file_ext,'xml','i') 
AND NOT REGEXP_LIKE(file_name,'_\d{4}\.xml$|_bk\.xml$|_old\.xml$|Component_Button\.xml','i') ; -- 전체 225개중, jsp (12개) 와 제외대상 (가상계좌 BDM204L) 1개를 제외한 212개의 파일이 포함되어 있다. (추가된 팝업 5개 포함하여 전체: 217개 ), 최종소스: 5/7일 받음 (), 6/3 3개 제외후 214개
SELECT file_name FROM TARGETS WHERE file_name NOT IN 
(SELECT REPLACE(file_name,'xml','xfdl') FROM files 
  WHERE REGEXP_LIKE(file_path,'project.+DSI\\screen\\ntree','i') AND REGEXP_LIKE(file_ext,'xml','i') AND NOT REGEXP_LIKE(file_name,'_\d{4}\.xml$|_bk\.xml$|_old\.xml$|Component_Button\.xml','i'))
GROUP BY file_name;
SELECT 'echo F | xcopy "C:\Users\DBSB\Downloads\20240507_nTree_Source\'||pgm_path||'\'||file_name||'" "C:\CONV_TARGET\'||pgm_path||'\'||file_name||'" /Y' FROM TARGETS t WHERE manager IS NOT NULL AND file_name NOT IN (SELECT file_name FROM files WHERE REGEXP_LIKE(file_path,'conv_target','i')) ;
SELECT file_name FROM targets GROUP BY file_name HAVING count(*) > 1;

SELECT script FROM (
SELECT 'echo F | xcopy "'||file_path||'" "C:\CONV_TARGET\'||substr(file_path,43)||'" /Y'  script FROM files WHERE REGEXP_LIKE(file_path,'xui','i') AND NOT REGEXP_LIKE(file_path,'convert','i') ORDER BY file_path ) t1 GROUP BY script ORDER BY script;
SELECT 'echo F | xcopy "'||substr(file_path,1,50)||'\'||file_name||'" "'||substr(file_path,1,50)||'\'||file_name||'" /Y' FROM files WHERE REGEXP_LIKE(file_path,'xui','i') ;
SELECT substr(file_path,43),file_path,file_name FROM TARGET_ELEMENTS te ;

SELECT * FROM elements WHERE REGEXP_LIKE(file_path,'bdm081l','i') ORDER BY file_path,element_id,attr_name ;
SELECT file_path,element_name,attr_name FROM elements WHERE REGEXP_LIKE(file_path,'bdm081l','i') GROUP BY file_path,element_name,attr_name ORDER BY file_path,element_name,attr_name;
SELECT element_name,attr_name,max(LENGTH(attr_value)) FROM elements GROUP BY element_name,attr_name ORDER BY element_name,attr_name;
-- 8,16,32,64,128,512 1:8, 2:16, 3:32, 4:32, 5:64: 6:64, 7:64, 8:64, 9:128, 10:128, 11:128, 12:128, 13:128, 14:128, 15:120, 16: 128
-- 1:16, 2:32, 3:64, 4:64, 5:128, 6:128, 7:128 
CREATE TABLE elements_flat (file_path varchar2(512));
SELECT * FROM XF_PUSHBUTTON ;
SELECT 'drop table '||table_name||';' FROM dba_tables WHERE table_name LIKE 'XF_%' ORDER BY table_name;
SELECT * FROM dba_tables WHERE table_name LIKE 'XF_%' ORDER BY table_name;
SELECT element_name,attr_name,max(LENGTH(attr_value)) FROM elements GROUP BY element_name,attr_name ORDER BY element_name,attr_name;
SELECT file_path,element_id,parent_id,element_name,attr_name,attr_value FROM elements ORDER BY file_path,element_id,parent_id,element_name,attr_name;
insert into xf_screen(element_id,parent_id,directory,last_update_date,on_beforetran,on_load,on_size,on_submitcomplete,on_trancomplete,screen_version,screenid,scriptcode,title,version,view_height,view_width,width) values(3,2,/NTREE/,2024-10-02 03:42:59,null,eventfunc:screen_on_load(),null,eventfunc:screen_on_submitcomplete(mapid, result, recv_userheader, recv_code, recv_msg),null,null,NCONFIG,java,NTREE 로컬 개발,2.0,0,0,1000);
SELECT file_path,element_id,attr_name,attr_value,LENGTH(attr_value) FROM elements WHERE REGEXP_LIKE(element_name,'radio','i') AND REGEXP_LIKE(attr_name,'UNSELECT_VALUE','i') ORDER BY attr_value;

into xf_combobox(element_id,parent_id,REPOSITION,RESIZE,auto_skip,autosize,button_backcolor,combobox_data,control_id,default_value,editable,height,ibFMLID,ibFMLOC,ibFormatName,ibFormats,ibOutputFormat,name,on_itemchange,picklist_ex,picklist_font,picklist_selstyle,picklist_showmaxcount,picklist_viewstyle,showselectbox_focusin,style,width,x,y) values(66,64,'0','0','0','0','00F0F0F0','del=':' pos='0' style='1' content=':* 전체'','3','0','0','26','null','0','null','null','3','ACCT_STA','eventfunc:ACCT_STA_on_itemchange(objInst, nprev_item, ncur_item)','null','굴림체,9,400,0,0,0','2','100','2','4','input_point_00','213','1410','6')

drop table XFDLS;
drop table XFDL_LIBS;
drop table XF_ACTIVEX;
drop table XF_CALENDAR_FIELD;
drop table XF_CAPTION;
drop table XF_CELL;
drop table XF_CHECKBOX;
drop table XF_COLUMN;
drop table XF_COMBOBOX;
drop table XF_DATA;
drop table XF_GRID;
drop table XF_HANGUL_FIELD;
drop table XF_HEADER;
drop table XF_HEADERMEGEINFO;
drop table XF_IMAGE;
drop table XF_IMAGEBOX;
drop table XF_LINE;
drop table XF_MULTILINE;
drop table XF_MULTILINEGRID;
drop table XF_NORMAL_FIELD;
drop table XF_NUMERICEX_FIELD;
drop table XF_PANEL;
drop table XF_PASSWORD_FIELD;
drop table XF_PUSHBUTTON;
drop table XF_RADIOBUTTON;
drop table XF_RECTANGLE;
drop table XF_SCREEN;
drop table XF_TAB;
drop table XF_TABLE;
drop table XF_TAB_ITEM;
drop table XF_TAB_ORDER;
drop table XF_TAGTEXT;
drop table XF_TEXT;
drop table XF_TIMER;
drop table XF_WEBBROWSER;
drop table XF_XLINKDATASET;
drop table XF_XLINKTRANMAP;
