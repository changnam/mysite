TRUNCATE TABLE filecontents;
SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_PATH ,'report','i')  ORDER BY file_path,line_num;
CREATE TABLE attrmap AS 
SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_PATH ,'report_0510','i')  AND REGEXP_LIKE(LINE_TEXT,'속성 변환','i')  ORDER BY file_path,line_num;

CREATE TABLE attrmap_comp AS 
SELECT file_path,file_name,line_num,line_text,REGEXP_SUBSTR(line_text,'\[SCR\] ''(.*?)( 노드에 대해 )(.*?)( 속성)',1,1,'i',1) ctype,REGEXP_SUBSTR(line_text,'\[SCR\] ''(.*?)( 노드에 대해 )(.*?)( 속성)',1,1,'i',3) cattr  FROM attrmap;

CREATE TABLE attr_check (file_path varchar2(512), file_name varchar2(128), line_num NUMBER, line_text varchar2(4000), ctype varchar2(32), cattr varchar2(64));
INSERT INTO attr_check SELECT * FROM attrmap_comp;
COMMIT;

SELECT * FROM attr_check WHERE REGEXP_LIKE(ctype,'popupdiv','i') AND REGEXP_LIKE(cattr,'^scrollbars','i') ;
SELECT ctype,cattr,count(*) FROM attr_check GROUP BY ctype,cattr ORDER BY ctype,cattr;

SELECT FILE_PATH ,file_name FROM filecontents WHERE REGEXP_LIKE(FILE_NAME ,'ibos','i')  GROUP BY FILE_PATH ,file_name ORDER BY FILE_PATH ,file_name;

SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_NAME ,'delphi','i')  AND REGEXP_LIKE(LINE_TEXT,'messagebox','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;

SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_NAME ,'IBOSMain','i')  AND REGEXP_LIKE(LINE_TEXT,'ActionList1','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;
SELECT * FROM filecontents WHERE REGEXP_LIKE(LINE_TEXT,'(function|procedure).*(DirectoryExists)','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;

SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_NAME,'yecawin','i')  AND REGEXP_LIKE(LINE_TEXT,'GetCode1','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;

SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_NAME ,'bkck2682','i')  AND REGEXP_LIKE(LINE_TEXT,'^[[:blank:]]','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ; -- blank 로 시작하는 라인 [] 는 그중의 하나의 의미
SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_NAME ,'bkck2682','i')  AND REGEXP_LIKE(LINE_TEXT,'^[[:blank:]]*helptype','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ; -- blank 가 있거나 없이 helptype으로 시작

SELECT * FROM filecontents WHERE REGEXP_LIKE(LINE_TEXT,'http:\/\/','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;
SELECT * FROM filecontents WHERE REGEXP_LIKE(LINE_TEXT,'^[[:blank:]]*helpfile','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ; -- space와 탭 (oracle 은 posix 기반)

SELECT * FROM filecontents WHERE REGEXP_LIKE(LINE_TEXT,'(\{\$R).*(RES)','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;
SELECT * FROM filecontents WHERE REGEXP_LIKE(LINE_TEXT,'Lines\.clear\(.*\)','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;

SELECT * FROM filecontents WHERE REGEXP_LIKE(LINE_TEXT,'cmc304p','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;
SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_PATH,'.*','i')  AND REGEXP_LIKE(LINE_TEXT,'\.print|[[:blank:]]+print','i') AND REGEXP_LIKE(FILE_EXT,'pas','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;
CREATE TABLE filecontents_fn AS 
SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_PATH,'ntree.*','i')  AND REGEXP_LIKE(LINE_TEXT,'function.+','i') AND REGEXP_LIKE(FILE_EXT,'.*','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;
SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_PATH,'.*','i')  AND REGEXP_LIKE(LINE_TEXT,'function.+gfn_multiComboPop','i') AND REGEXP_LIKE(FILE_EXT,'.*','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;
SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_PATH,'.*','i')  AND REGEXP_LIKE(LINE_TEXT,'e\.preindex','i') AND REGEXP_LIKE(FILE_EXT,'.*','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;
SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_PATH,'ntree.*bdm103u','i')  AND REGEXP_LIKE(LINE_TEXT,'div.+\.div.+','i') AND REGEXP_LIKE(FILE_EXT,'.*','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;
SELECT * FROM filecontents_fn WHERE REGEXP_LIKE(FILE_PATH,'ntree.*','i')  AND REGEXP_LIKE(LINE_TEXT,'function.+/NTREE/bd/CPA007L','i') AND REGEXP_LIKE(FILE_EXT,'.*','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;


SELECT * FROM target_filecontents WHERE REGEXP_LIKE(FILE_PATH,'ntree.*','i')  AND REGEXP_LIKE(LINE_TEXT,'function.+setAllDiv','i') AND REGEXP_LIKE(FILE_EXT,'.*','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;
SELECT * FROM target_filecontents WHERE REGEXP_LIKE(FILE_PATH,'ntree.*bdm103u','i')  AND REGEXP_LIKE(LINE_TEXT,'Div01\.Div07\..+text','i') AND REGEXP_LIKE(FILE_EXT,'.*','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;
SELECT * FROM target_filecontents WHERE REGEXP_LIKE(FILE_PATH,'ntree.*','i')  AND REGEXP_LIKE(LINE_TEXT,'LNC002U_TSub09','i') AND REGEXP_LIKE(FILE_EXT,'.*','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;
SELECT * FROM target_filecontents WHERE REGEXP_LIKE(FILE_PATH,'ntree.*','i')  AND REGEXP_LIKE(LINE_TEXT,'var strInputDs','i') AND NOT REGEXP_LIKE(LINE_TEXT,'strInputDs.+dsParam','i') AND REGEXP_LIKE(FILE_EXT,'.*','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;

SELECT * FROM target_filecontents WHERE REGEXP_LIKE(FILE_PATH,'ntree.*','i')  AND REGEXP_LIKE(LINE_TEXT,'strFnCallback.+=.+fn_callBack";','i') AND REGEXP_LIKE(FILE_EXT,'.*','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;
SELECT * FROM target_filecontents WHERE REGEXP_LIKE(FILE_PATH,'ntree.*','i')  AND REGEXP_LIKE(LINE_TEXT,'strFnCallback.+=";','i') AND NOT REGEXP_LIKE(LINE_TEXT,'strFnCallback.+=.+fn_callBack";','i') AND REGEXP_LIKE(FILE_EXT,'.*','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;

SELECT * FROM targets WHERE PGM_NAME IS NOT null;
DROP TABLE target_mappings;
-- CREATE TABLE target_mappings AS 
SELECT * FROM TARGET_MAPPINGS WHERE REGEXP_LIKE(file_path,'lnc002u','i') AND REGEXP_LIKE(line_text,'^Div02','i') ORDER BY file_path,line_num ; 
SELECT * FROM TARGET_MAPPINGS WHERE REGEXP_LIKE(file_path,'lnc002u_tsub01','i') ORDER BY file_path,line_num; 
-- dfm 에서 선언된 object 
SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_NAME,'.*','i') AND REGEXP_LIKE(file_ext,'dfm','i') AND REGEXP_LIKE(LINE_TEXT,'(object).*(tradiogroup)','i') ORDER BY FILE_PATH ,FILE_NAME ,LINE_NUM ;
SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_NAME,'.*','i') AND REGEXP_LIKE(file_ext,'dfm','i') 
AND ( REGEXP_LIKE(LINE_TEXT,'(object).*(shape)','i') AND NOT REGEXP_LIKE(LINE_TEXT,'tqrshape','i'))  ORDER BY FILE_PATH ,FILE_NAME ,LINE_NUM ;

-- dfm 파일 text 버전
SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_NAME,'.*','i') AND REGEXP_LIKE(file_ext,'dfm','i') AND REGEXP_LIKE(LINE_TEXT,'helptype|(object).*(tabsheet)','i') ORDER BY FILE_PATH ,FILE_NAME ,LINE_NUM ;  

-- dfm 에서 선언되 이벤트함수
SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_NAME,'insa','i') AND REGEXP_LIKE(file_ext,'dfm','i') AND REGEXP_LIKE(LINE_TEXT,'mStrongPntKeyPress','i') ORDER BY FILE_PATH ,FILE_NAME ,LINE_NUM ;

-- 메소드 확인
SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_NAME,'.*','i') AND REGEXP_LIKE(file_ext,'pas','i') AND REGEXP_LIKE(LINE_TEXT,'lines\.clear','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;

--
DELETE FROM FILECONTENTS f WHERE REGEXP_LIKE(file_path,'sys_2024.*\.log','i');
COMMIT;
DROP TABLE SYS_202411204;
CREATE TABLE SYS_20241204 AS 
SELECT * FROM filecontents WHERE REGEXP_LIKE(file_path,'sys_20241204\.log','i') ORDER BY FILE_PATH ,file_name, LINE_NUM;
SELECT * FROM SYS_20241128 s ;
DELETE FROM SYS_20241128 WHERE REGEXP_LIKE(line_text,'tuxedo','i'); 
DROP TABLE SYS_20241204_logtagev;
CREATE TABLE SYS_20241204_logtagev AS 
SELECT id,line_num,SUBSTR(line_text,42) logtag_text FROM SYS_20241204 s WHERE REGEXP_LIKE(line_text,'logtag  ev','i') ;
SELECT * FROM SYS_20241128_logtagev ORDER BY line_num;
SELECT * FROM SYS_20241128_logtagev a FULL OUTER JOIN SYS_20241129_logtagev b ON a.line_num = b.line_num ORDER BY a.line_num;
SELECT substr(line_text,42) FROM SYS_20241129 WHERE line_num BETWEEN 1 AND 50000 AND REGEXP_LIKE(line_text,'logtag','i') AND NOT REGEXP_LIKE(line_text,'StrToIntEX|CheckMenuItem|Check_SubMenu','i') ORDER BY line_num; 
SELECT substr(line_text,42) FROM SYS_20241204 WHERE REGEXP_LIKE(line_text,'logtag','i') AND REGEXP_LIKE(line_text,'lnc002u|bdm103u','i') ORDER BY line_num;
SELECT substr(line_text,42) FROM SYS_20241128 WHERE REGEXP_LIKE(line_text,'started|ended','i')  AND REGEXP_LIKE(line_text,'lnc002u|bdm103u','i') ORDER BY line_num;
SELECT substr(line_text,42) FROM SYS_20241129 WHERE REGEXP_LIKE(line_text,'logtag','i') AND REGEXP_LIKE(line_text,'lnc002u|bdm103u','i') ORDER BY line_num;
SELECT substr(line_text,42) FROM SYS_20241129 WHERE REGEXP_LIKE(line_text,'started|ended','i')  AND REGEXP_LIKE(line_text,'lnc002u|bdm103u','i') ORDER BY line_num;
--
SELECT * FROM filecontents WHERE REGEXP_LIKE(LINE_TEXT,'function.+encodeURIComponent','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;
SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_PATH,'ntree.*','i')  AND REGEXP_LIKE(LINE_TEXT,'\.print|[[:blank:]]+print','i') AND REGEXP_LIKE(FILE_EXT,'pas','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;
CREATE TABLE funclist AS 
SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_PATH,'ntree.+','i')  AND REGEXP_LIKE(LINE_TEXT,'function.+e:','i') AND REGEXP_LIKE(FILE_EXT,'.*','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;

SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_PATH,'ntree.+','i')  AND REGEXP_LIKE(LINE_TEXT,'application\.','i') AND REGEXP_LIKE(FILE_EXT,'xfdl','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;

SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_PATH,'ntree.*','i')  AND REGEXP_LIKE(LINE_TEXT,'LND013U','i') AND REGEXP_LIKE(FILE_EXT,'.*','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;
SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_PATH,'.*','i')  AND REGEXP_LIKE(LINE_TEXT,'타점권종','i') AND REGEXP_LIKE(FILE_EXT,'xfdl','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;
SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_PATH,'data','i')  AND REGEXP_LIKE(LINE_TEXT,'타점','i') AND REGEXP_LIKE(FILE_EXT,'.*','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;

SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_PATH,'ntree.*','i')  AND REGEXP_LIKE(LINE_TEXT,'Combe_Ds_Set','i') AND NOT REGEXP_LIKE(FILE_EXT,'xfdl','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;

SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_PATH,'ntree.*','i')  AND REGEXP_LIKE(LINE_TEXT,'.*BDM086P','i') AND REGEXP_LIKE(FILE_EXT,'.*','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;

DELETE FROM filecontents WHERE REGEXP_LIKE(FILE_PATH,'ntree.+','i');

COMMIT;

CREATE TABLE target_filecontents AS SELECT GUBUN,
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
COMMENTS,b.* FROM targets a INNER JOIN filecontents_t b ON a.pgm_path = b.pgm_path AND a.file_name = b.file_name;

CREATE TABLE filecontents_t AS SELECT substr(file_path,instr(file_path,'\',-1)-2,2) pgm_path,t.* FROM filecontents t WHERE REGEXP_LIKE(file_path,'ntreeworks','i') ;


