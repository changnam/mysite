DROP TABLE jsfiles;
CREATE TABLE jsfiles (file_path varchar2(512),parent_function varchar2(1024),member_name varchar2(512),callee_name varchar2(1024),arguments_length number,line_num number,arguments_value varchar2(4000));
DELETE FROM jsfiles WHERE REGEXP_LIKE(file_path,'C:\\xFrame\\project\\DSI\\screen\\common_module','i');
SELECT * FROM jsfiles;

DROP TABLE jsfunctions;
CREATE TABLE jsfunctions (file_path varchar2(512),function_name varchar2(1024),parent_function varchar2(1024),params_length number,line_num number);
DELETE FROM jsfunctions WHERE REGEXP_LIKE(file_path,'C:\\xFrame\\project\\DSI\\screen\\common_module','i');

DROP TABLE jsvariables;
CREATE TABLE jsvariables (file_path varchar2(512),variable_name varchar2(1024),parent_function varchar2(1024),variable_value varchar2(1024),line_num number);
SELECT * FROM jsvariables WHERE REGEXP_LIKE(file_path,'lnc002u_tsub21','i') ORDER BY line_num;
DELETE FROM jsvariables WHERE REGEXP_LIKE(file_path,'lnc002u_tsub21','i');
COMMIT;
TRUNCATE TABLE jsfiles;
TRUNCATE TABLE jsfunctions;
TRUNCATE TABLE jsvariables;

SELECT count(*) FROM jsfiles;
SELECT count(*) FROM jsfunctions;
SELECT count(*) FROM jsvariables;

SELECT * FROM jsvariables ORDER BY file_path,line_num;
DROP TABLE trands;
CREATE TABLE trands AS SELECT file_path,variable_name,variable_value
  -- ,REGEXP_SUBSTR(variable_value,'(.*?)(=)(.*?)',1,1,'i',1) dsname 
  ,REGEXP_SUBSTR(REGEXP_SUBSTR(variable_value,'[^[:blank:]]+',1,1), '[^=]+',1,1) dsname1 
  ,REGEXP_SUBSTR(REGEXP_SUBSTR(variable_value,'[^[:blank:]]+',1,1), '[^=]+',1,2) dsname1_1 
  ,REGEXP_SUBSTR(REGEXP_SUBSTR(variable_value,'[^[:blank:]]+',1,2) , '[^=]+',1,1) dsname2 
  ,REGEXP_SUBSTR(REGEXP_SUBSTR(variable_value,'[^[:blank:]]+',1,2) , '[^=]+',1,2) dsname2_1 
  ,REGEXP_SUBSTR(REGEXP_SUBSTR(variable_value,'[^[:blank:]]+',1,3) , '[^=]+',1,1) dsname3 
  ,REGEXP_SUBSTR(REGEXP_SUBSTR(variable_value,'[^[:blank:]]+',1,3) , '[^=]+',1,2) dsname3_1   
  ,REGEXP_SUBSTR(REGEXP_SUBSTR(variable_value,'[^[:blank:]]+',1,4) , '[^=]+',1,1) dsname4 
  ,REGEXP_SUBSTR(REGEXP_SUBSTR(variable_value,'[^[:blank:]]+',1,4) , '[^=]+',1,2) dsname4_1   
  ,REGEXP_SUBSTR(REGEXP_SUBSTR(variable_value,'[^[:blank:]]+',1,5) , '[^=]+',1,1) dsname5 
  ,REGEXP_SUBSTR(REGEXP_SUBSTR(variable_value,'[^[:blank:]]+',1,5) , '[^=]+',1,2) dsname5_1 
  ,REGEXP_SUBSTR(REGEXP_SUBSTR(variable_value,'[^[:blank:]]+',1,6) , '[^=]+',1,1) dsname6 
  ,REGEXP_SUBSTR(REGEXP_SUBSTR(variable_value,'[^[:blank:]]+',1,6) , '[^=]+',1,2) dsname6_1   
  ,REGEXP_SUBSTR(REGEXP_SUBSTR(variable_value,'[^[:blank:]]+',1,7) , '[^=]+',1,1) dsname7 
  ,REGEXP_SUBSTR(REGEXP_SUBSTR(variable_value,'[^[:blank:]]+',1,7) , '[^=]+',1,2) dsname7_1   
  ,REGEXP_SUBSTR(REGEXP_SUBSTR(variable_value,'[^[:blank:]]+',1,8) , '[^=]+',1,1) dsname8 
  ,REGEXP_SUBSTR(REGEXP_SUBSTR(variable_value,'[^[:blank:]]+',1,8) , '[^=]+',1,2) dsname8_1   
  ,REGEXP_SUBSTR(REGEXP_SUBSTR(variable_value,'[^[:blank:]]+',1,9) , '[^=]+',1,1) dsname9 
  ,REGEXP_SUBSTR(REGEXP_SUBSTR(variable_value,'[^[:blank:]]+',1,9) , '[^=]+',1,2) dsname9_1   
  ,REGEXP_SUBSTR(REGEXP_SUBSTR(variable_value,'[^[:blank:]]+',1,10), '[^=]+',1,1)  dsname10 
  ,REGEXP_SUBSTR(REGEXP_SUBSTR(variable_value,'[^[:blank:]]+',1,10), '[^=]+',1,2)  dsname10_1
  ,line_num
  FROM jsvariables WHERE REGEXP_LIKE(variable_name,'stroutputds|strinputds','i') ORDER BY file_path,line_num;
SELECT max(file_path),max(variable_name),max(dsname1),max(dsname1_1),max(line_num)
FROM (
SELECT file_path,variable_name,dsname1,'' dsname1_1,'' dsname2,'' dsname2_1,'' dsname3,'' dsname3_1,'' dsname4,'' dsname4_1,'' dsname5,'' dsname5_1,'' dsname6,'' dsname6_1,'' dsname7,'' dsname7_1,'' dsname8,'' dsname8_1,'' dsname9,'' dsname9_1,'' dsname10,'' dsname10_1 ,line_num FROM trands
UNION ALL
SELECT file_path,variable_name,'' dsname1,dsname1_1,'' dsname2,'' dsname2_1,'' dsname3,'' dsname3_1,'' dsname4,'' dsname4_1,'' dsname5,'' dsname5_1,'' dsname6,'' dsname6_1,'' dsname7,'' dsname7_1,'' dsname8,'' dsname8_1,'' dsname9,'' dsname9_1,'' dsname10,'' dsname10_1 ,line_num FROM trands
UNION ALL
SELECT file_path,variable_name,'' dsname1,'' dsname1_1,dsname2,'' dsname2_1,'' dsname3,'' dsname3_1,'' dsname4,'' dsname4_1,'' dsname5,'' dsname5_1,'' dsname6,'' dsname6_1,'' dsname7,'' dsname7_1,'' dsname8,'' dsname8_1,'' dsname9,'' dsname9_1,'' dsname10,'' dsname10_1 ,line_num FROM trands
UNION ALL
SELECT file_path,variable_name,'' dsname1,'' dsname1_1,'' dsname2,dsname2_1,'' dsname3,'' dsname3_1,'' dsname4,'' dsname4_1,'' dsname5,'' dsname5_1,'' dsname6,'' dsname6_1,'' dsname7,'' dsname7_1,'' dsname8,'' dsname8_1,'' dsname9,'' dsname9_1,'' dsname10,'' dsname10_1 ,line_num FROM trands
UNION ALL
SELECT file_path,variable_name,'' dsname1,'' dsname1_1,'' dsname2,'' dsname2_1,dsname3,'' dsname3_1,'' dsname4,'' dsname4_1,'' dsname5,'' dsname5_1,'' dsname6,'' dsname6_1,'' dsname7,'' dsname7_1,'' dsname8,'' dsname8_1,'' dsname9,'' dsname9_1,'' dsname10,'' dsname10_1 ,line_num FROM trands
UNION ALL                                  
SELECT file_path,variable_name,'' dsname1,'' dsname1_1,'' dsname2,'' dsname2_1,'' dsname3,dsname3_1,'' dsname4,'' dsname4_1,'' dsname5,'' dsname5_1,'' dsname6,'' dsname6_1,'' dsname7,'' dsname7_1,'' dsname8,'' dsname8_1,'' dsname9,'' dsname9_1,'' dsname10,'' dsname10_1 ,line_num FROM trands
UNION ALL                                  
SELECT file_path,variable_name,'' dsname1,'' dsname1_1,'' dsname2,'' dsname2_1,'' dsname3,'' dsname3_1,dsname4,'' dsname4_1,'' dsname5,'' dsname5_1,'' dsname6,'' dsname6_1,'' dsname7,'' dsname7_1,'' dsname8,'' dsname8_1,'' dsname9,'' dsname9_1,'' dsname10,'' dsname10_1 ,line_num FROM trands
UNION ALL                                  
SELECT file_path,variable_name,'' dsname1,'' dsname1_1,'' dsname2,'' dsname2_1,'' dsname3,'' dsname3_1,'' dsname4,dsname4_1,'' dsname5,'' dsname5_1,'' dsname6,'' dsname6_1,'' dsname7,'' dsname7_1,'' dsname8,'' dsname8_1,'' dsname9,'' dsname9_1,'' dsname10,'' dsname10_1 ,line_num FROM trands
UNION ALL                                  
SELECT file_path,variable_name,'' dsname1,'' dsname1_1,'' dsname2,'' dsname2_1,'' dsname3,'' dsname3_1,'' dsname4,'' dsname4_1,dsname5,'' dsname5_1,'' dsname6,'' dsname6_1,'' dsname7,'' dsname7_1,'' dsname8,'' dsname8_1,'' dsname9,'' dsname9_1,'' dsname10,'' dsname10_1 ,line_num FROM trands
UNION ALL                                  
SELECT file_path,variable_name,'' dsname1,'' dsname1_1,'' dsname2,'' dsname2_1,'' dsname3,'' dsname3_1,'' dsname4,'' dsname4_1,'' dsname5,dsname5_1,'' dsname6,'' dsname6_1,'' dsname7,'' dsname7_1,'' dsname8,'' dsname8_1,'' dsname9,'' dsname9_1,'' dsname10,'' dsname10_1 ,line_num FROM trands
UNION ALL                                  
SELECT file_path,variable_name,'' dsname1,'' dsname1_1,'' dsname2,'' dsname2_1,'' dsname3,'' dsname3_1,'' dsname4,'' dsname4_1,'' dsname5,'' dsname5_1,dsname6,'' dsname6_1,'' dsname7,'' dsname7_1,'' dsname8,'' dsname8_1,'' dsname9,'' dsname9_1,'' dsname10,'' dsname10_1 ,line_num FROM trands
UNION ALL                                  
SELECT file_path,variable_name,'' dsname1,'' dsname1_1,'' dsname2,'' dsname2_1,'' dsname3,'' dsname3_1,'' dsname4,'' dsname4_1,'' dsname5,'' dsname5_1,'' dsname6,dsname6_1,'' dsname7,'' dsname7_1,'' dsname8,'' dsname8_1,'' dsname9,'' dsname9_1,'' dsname10,'' dsname10_1 ,line_num FROM trands
UNION ALL                                  
SELECT file_path,variable_name,'' dsname1,'' dsname1_1,'' dsname2,'' dsname2_1,'' dsname3,'' dsname3_1,'' dsname4,'' dsname4_1,'' dsname5,'' dsname5_1,'' dsname6,'' dsname6_1,dsname7,'' dsname7_1,'' dsname8,'' dsname8_1,'' dsname9,'' dsname9_1,'' dsname10,'' dsname10_1 ,line_num FROM trands
UNION ALL                                  
SELECT file_path,variable_name,'' dsname1,'' dsname1_1,'' dsname2,'' dsname2_1,'' dsname3,'' dsname3_1,'' dsname4,'' dsname4_1,'' dsname5,'' dsname5_1,'' dsname6,'' dsname6_1,'' dsname7,dsname7_1,'' dsname8,'' dsname8_1,'' dsname9,'' dsname9_1,'' dsname10,'' dsname10_1 ,line_num FROM trands
UNION ALL                                  
SELECT file_path,variable_name,'' dsname1,'' dsname1_1,'' dsname2,'' dsname2_1,'' dsname3,'' dsname3_1,'' dsname4,'' dsname4_1,'' dsname5,'' dsname5_1,'' dsname6,'' dsname6_1,'' dsname7,'' dsname7_1,dsname8,'' dsname8_1,'' dsname9,'' dsname9_1,'' dsname10,'' dsname10_1 ,line_num FROM trands
UNION ALL                                  
SELECT file_path,variable_name,'' dsname1,'' dsname1_1,'' dsname2,'' dsname2_1,'' dsname3,'' dsname3_1,'' dsname4,'' dsname4_1,'' dsname5,'' dsname5_1,'' dsname6,'' dsname6_1,'' dsname7,'' dsname7_1,'' dsname8,dsname8_1,'' dsname9,'' dsname9_1,'' dsname10,'' dsname10_1 ,line_num FROM trands
UNION ALL                                  
SELECT file_path,variable_name,'' dsname1,'' dsname1_1,'' dsname2,'' dsname2_1,'' dsname3,'' dsname3_1,'' dsname4,'' dsname4_1,'' dsname5,'' dsname5_1,'' dsname6,'' dsname6_1,'' dsname7,'' dsname7_1,'' dsname8,'' dsname8_1,dsname9,'' dsname9_1,'' dsname10,'' dsname10_1 ,line_num FROM trands
UNION ALL                                  
SELECT file_path,variable_name,'' dsname1,'' dsname1_1,'' dsname2,'' dsname2_1,'' dsname3,'' dsname3_1,'' dsname4,'' dsname4_1,'' dsname5,'' dsname5_1,'' dsname6,'' dsname6_1,'' dsname7,'' dsname7_1,'' dsname8,'' dsname8_1,'' dsname9,dsname9_1,'' dsname10,'' dsname10_1 ,line_num FROM trands
UNION ALL                                  
SELECT file_path,variable_name,'' dsname1,'' dsname1_1,'' dsname2,'' dsname2_1,'' dsname3,'' dsname3_1,'' dsname4,'' dsname4_1,'' dsname5,'' dsname5_1,'' dsname6,'' dsname6_1,'' dsname7,'' dsname7_1,'' dsname8,'' dsname8_1,'' dsname9,'' dsname9_1,dsname10,'' dsname10_1 ,line_num FROM trands
UNION ALL                                  
SELECT file_path,variable_name,'' dsname1,'' dsname1_1,'' dsname2,'' dsname2_1,'' dsname3,'' dsname3_1,'' dsname4,'' dsname4_1,'' dsname5,'' dsname5_1,'' dsname6,'' dsname6_1,'' dsname7,'' dsname7_1,'' dsname8,'' dsname8_1,'' dsname9,'' dsname9_1,'' dsname10,dsname10_1 ,line_num FROM trands
) tg
GROUP BY file_path,variable_name,dsname1,dsname1_1,dsname2,dsname2_1,dsname3,dsname3_1,dsname4,dsname4_1,dsname5,dsname5_1,dsname6,dsname6_1,dsname7,dsname7_1,dsname8,dsname8_1,dsname9,dsname9_1,dsname10,dsname10_1,line_num
ORDER BY file_path,variable_name,line_num;
-- 
DROP TABLE trandslast;
CREATE TABLE trandslast AS SELECT * FROM (
SELECT file_path,variable_name,dsname FROM (
SELECT file_path,variable_name,line_num,dsname1 dsname FROM trands 
UNION ALL
SELECT file_path,variable_name,line_num,dsname1_1 dsname FROM trands 
UNION ALL
SELECT file_path,variable_name,line_num,dsname2 dsname FROM trands
UNION ALL
SELECT file_path,variable_name,line_num,dsname2_1 dsname FROM trands
) Tg 
GROUP BY file_path,variable_name,dsname ) tglast
 WHERE dsname IS NOT null
ORDER BY file_path,variable_name,dsname
;
SELECT substr(file_path,1,instr(file_path,'.')-1) file_path,dsname FROM trandslast GROUP BY file_path,dsname;
SELECT REPLACE(substr(file_path,1,instr(file_path,'.')-1),'\','\\') file_path,attr_value dsname FROM elements WHERE REGEXP_LIKE(element_name,'dataset','i') AND REGEXP_LIKE(attr_name,'id','i') ;
-- 부모와 데이터셋을 공유하여 거래하는 경우
SELECT * FROM (
SELECT substr(file_path,1,instr(file_path,'.')-1) file_path,REGEXP_SUBSTR(dsname,'[^:]+',1,1) dsname FROM trandslast ) t1
LEFT OUTER JOIN 
(SELECT REPLACE(substr(file_path,1,instr(file_path,'.')-1),'\','\\') file_path,attr_value dsname FROM elements WHERE REGEXP_LIKE(element_name,'dataset','i') AND REGEXP_LIKE(attr_name,'id','i') ) t2
ON t1.file_path = t2.file_path AND t1.dsname = t2.dsname
WHERE t2.dsname IS null;

DROP TABLE TARGET_JSFILES ;
CREATE TABLE target_jsfiles AS SELECT REPLACE(substr(file_path,42,instr(file_path,'.',-1)-42),'\\','\') new_file_path,file_path,parent_function,member_name,callee_name,arguments_length,line_num,arguments_value FROM jsfiles WHERE REGEXP_LIKE(file_path,'project.+DSI','i') ;
SELECT * FROM target_jsfiles;
DELETE FROM target_jsfiles WHERE REGEXP_LIKE(file_path,'project.+DSI.+bdm029l|project.+DSI.+bdm977l|project.+DSI.+bdm953l','i');

DROP TABLE GLOBAL_JSFILES ;
CREATE TABLE GLOBAL_JSFILES AS SELECT REPLACE(substr(file_path,42,instr(file_path,'.',-1)-42),'\\','\') new_file_path,file_path,parent_function,member_name,callee_name,arguments_length,line_num,arguments_value FROM jsfiles WHERE REGEXP_LIKE(file_path,'project.+DSI.+common_module','i') ;
SELECT * FROM GLOBAL_JSFILES;
DELETE FROM GLOBAL_JSFILES WHERE REGEXP_LIKE(file_path,'project.+DSI.+bdm029l|project.+DSI.+bdm977l|project.+DSI.+bdm953l','i');


DROP TABLE target_jsfunctions;
CREATE TABLE target_jsfunctions AS SELECT REPLACE(substr(file_path,42,instr(file_path,'.',-1)-42),'\\','\') new_file_path,file_path,function_name,parent_function,params_length,line_num FROM jsfunctions WHERE REGEXP_LIKE(file_path,'project.+DSI','i') ;
SELECT * FROM jsfunctions WHERE REGEXP_LIKE(FILE_PATH,'ntreeutil','i') ORDER BY function_name;
SELECT * FROM target_jsfunctions;
DELETE FROM target_jsfunctions WHERE REGEXP_LIKE(file_path,'project.+DSI.+bdm029l|project.+DSI.+bdm977l|project.+DSI.+bdm953l','i');
COMMIT;

DROP TABLE global_jsfunctions;
CREATE TABLE global_jsfunctions AS SELECT REPLACE(substr(file_path,42,instr(file_path,'.',-1)-42),'\\','\') new_file_path,file_path,function_name,parent_function,params_length,line_num FROM jsfunctions WHERE REGEXP_LIKE(file_path,'project.+DSI.+common_module','i') ;
SELECT * FROM global_jsfunctions WHERE REGEXP_LIKE(FILE_PATH,'.*','i') AND REGEXP_LIKE(function_name,'ref','i') ORDER BY function_name;
SELECT * FROM global_jsfunctions;

SELECT * FROM global_jsfunctions WHERE REGEXP_LIKE(function_name,'date','i') AND REGEXP_LIKE(function_name,'cal','i')  ORDER BY file_path,function_name;
SELECT callee_name,count(*) FROM (SELECT * FROM target_jsfiles WHERE REGEXP_LIKE(member_name,'^ds_','i') ) t GROUP BY callee_name ORDER BY callee_name;
SELECT * FROM target_jsfiles WHERE REGEXP_LIKE(member_name,'^ds_.+delete','i') ORDER BY new_file_path;
SELECT * FROM target_jsfiles WHERE REGEXP_LIKE(file_path,'bdm001l','i') AND REGEXP_LIKE(member_name,'nTreeUtil','i')  AND REGEXP_LIKE(callee_name,'.*','i') ORDER BY new_file_path,member_name,callee_name;
SELECT * FROM target_jsfiles WHERE REGEXP_LIKE(member_name,'nTreeUtil','i')  AND REGEXP_LIKE(callee_name,'^astraMakeCall','i') AND REGEXP_LIKE(arguments_value,'.*','i') ORDER BY new_file_path, line_num;
SELECT * FROM target_jsfiles WHERE REGEXP_LIKE(member_name,'nTreeUtil','i')  AND REGEXP_LIKE(callee_name,'^set_url','i')  AND REGEXP_LIKE(ARGUMENTS_VALUE ,'BDM103U_TSub01C','i') ORDER BY new_file_path;
SELECT * FROM target_jsfiles WHERE REGEXP_LIKE(member_name,'.*','i') AND REGEXP_LIKE(callee_name,'gfn_OpenPop','i')  AND REGEXP_LIKE(ARGUMENTS_VALUE ,'CPA301P','i') ORDER BY new_file_path; -- 팝업호출
SELECT * FROM target_jsfiles WHERE REGEXP_LIKE(member_name,'.*','i') AND REGEXP_LIKE(callee_name,'countTotalLTG','i')  AND REGEXP_LIKE(ARGUMENTS_VALUE ,'.*','i') ORDER BY new_file_path; -- 화면링크
DROP TABLE ntree_popup;
-- CREATE TABLE ntree_popup as
SELECT new_file_path,arguments_value,line_num,REGEXP_SUBSTR(arguments_value,'(NTREE/)(.*?)(/)(.*?)(!-!)',1,1,'i',2) pgm_path ,REGEXP_SUBSTR(arguments_value,'(NTREE/)(.*?)(/)(.*?)(!-!)',1,1,'i',4) file_name  FROM target_jsfiles WHERE REGEXP_LIKE(member_name,'.*','i') AND REGEXP_LIKE(callee_name,'gfn_OpenPop','i')  AND REGEXP_LIKE(ARGUMENTS_VALUE ,'.*','i') ORDER BY new_file_path;
SELECT * FROM targets a FULL OUTER JOIN ntree_popup b ON a.pgm_path = b.pgm_path AND substr(a.file_name,1,instr(a.file_name,'.')-1) = b.file_name ORDER BY a.pgm_path,a.file_name;
SELECT * FROM targets a FULL OUTER JOIN ntree_popup b ON a.pgm_path = b.pgm_path AND substr(a.file_name,1,instr(a.file_name,'.')-1) = b.file_name WHERE a.file_name IS NULL ORDER BY a.pgm_path,a.file_name,b.pgm_path,b.file_name;
-- 스크립트상에서 .filter 를 안쓰는 화면
SELECT * FROM targets a LEFT OUTER JOIN (SELECT * FROM target_jsfiles WHERE REGEXP_LIKE(member_name,'ntreeutil','i')  AND REGEXP_LIKE(callee_name,'filter','i') ) b 
ON a.PGM_PATH = SUBSTR(b.NEW_FILE_PATH,1,instr(b.new_file_path,'\')-1) AND substr(a.file_name,1,instr(a.file_name,'.')-1) = substr(b.new_file_path,instr(b.new_file_path,'\')+1)
WHERE b.new_file_path IS NULL ORDER BY a.pgm_path,a.file_name;
SELECT * FROM targets;
SELECT * FROM target_jsfiles WHERE REGEXP_LIKE(member_name,'^nTreeUtil\.','i') AND REGEXP_LIKE(callee_name,'CMU101P','i') ORDER BY new_file_path;

SELECT * FROM TARGET_JSFUNCTIONS tj WHERE REGEXP_LIKE(function_name,'^reset','i') ORDER BY file_path;
SELECT * FROM jsfunctions WHERE REGEXP_LIKE(file_path,'common.+ntreeutil','i') AND REGEXP_LIKE(function_name,'comm_trace2','i') ; 
SELECT file_path,FUNCTION_NAME,count(*) FROM (SELECT file_path,upper(FUNCTION_NAME) function_name FROM jsfunctions ) t GROUP BY file_path,FUNCTION_NAME HAVING count(*) > 1 ORDER BY file_path,FUNCTION_NAME ; 
 
-- nTreeUtil에 정의되지 않은 함수명
SELECT a.new_file_path,a.parent_function,a.member_name,a.callee_name,a.line_num,a.arguments_value,b.function_name ntree_function FROM 
--SELECT callee_name,count(*) FROM 
 (SELECT * FROM target_jsfiles WHERE REGEXP_LIKE(member_name,'^nTreeUtil\.','i') AND REGEXP_LIKE(callee_name,'.*','i') ) a
 LEFT OUTER JOIN 
 (SELECT * FROM jsfunctions WHERE REGEXP_LIKE(file_path,'common.+ntreeutil','i')) b 
 ON a.callee_name = b.function_name
-- WHERE b.function_name IS NULL
--GROUP BY a.callee_name 
ORDER BY a.callee_name;

SELECT callee_name,ntree_function,count(*) FROM (
SELECT a.new_file_path,a.parent_function,a.member_name,a.callee_name,a.line_num,a.arguments_value,b.function_name ntree_function FROM 
--SELECT callee_name,count(*) FROM 
 (SELECT * FROM target_jsfiles WHERE REGEXP_LIKE(member_name,'^nTreeUtil\.','i') AND REGEXP_LIKE(callee_name,'.*','i') ) a
 LEFT OUTER JOIN 
 (SELECT * FROM jsfunctions WHERE REGEXP_LIKE(file_path,'common.+ntreeutil','i')) b 
 ON a.callee_name = b.function_name ) t 
-- WHERE b.function_name IS NULL ) t
GROUP BY callee_name,ntree_function  HAVING count(*) > 1
ORDER BY callee_name,ntree_function;

SELECT * FROM target_jsfiles WHERE REGEXP_LIKE(member_name,'^nTreeUtil\.','i') AND REGEXP_LIKE(callee_name,'get_CMS_ACCT_STA_NM','i') ;
DELETE FROM TARGET_ELEMENTS WHERE REGEXP_LIKE(file_path,'project.+DSI.+bdm029l|project.+DSI.+bdm977l|project.+DSI.+bdm953l','i');
SELECT * FROM target_elements WHERE regexp_like(new_file_path,'.*','i') AND REGEXP_LIKE(attr_name,'.*','i') AND REGEXP_LIKE(attr_value,'ds_param','i')  ;
SELECT * FROM target_elements WHERE regexp_like(new_file_path,'bdm175l','i') AND REGEXP_LIKE(element_name,'data','i') AND REGEXP_LIKE(attr_name,'.*','i') AND REGEXP_LIKE(attr_value,'.*','i')  ;
SELECT * FROM target_jsfiles a INNER JOIN (SELECT * FROM target_elements WHERE attr_name = 'name') b ON a.new_file_path = b.new_file_path AND substr(a.member_name,1,instr(a.member_name,'.')-1 ) = b.attr_value;
SELECT a.new_file_path,b.element_name,a.parent_function,a.member_name,a.callee_name FROM target_jsfiles a INNER JOIN (SELECT * FROM target_elements WHERE attr_name = 'name') b ON a.new_file_path = b.new_file_path AND substr(a.member_name,1,instr(a.member_name,'.')-1 ) = b.attr_value;
SELECT element_name,callee_name,count(*) FROM (SELECT a.new_file_path,b.element_name,a.parent_function,a.member_name,a.callee_name FROM target_jsfiles a INNER JOIN (SELECT * FROM target_elements WHERE attr_name = 'name') b ON a.new_file_path = b.new_file_path AND substr(a.member_name,1,instr(a.member_name,'.')-1 ) = b.attr_value ) t GROUP BY element_name,callee_name ORDER BY element_name,callee_name;

DELETE FROM jsfunctions WHERE REGEXP_LIKE(file_path,'dsi.+common','i');
DELETE FROM jsfiles WHERE REGEXP_LIKE(file_path,'dsi.+common','i');
COMMIT;
SELECT * FROM jsfunctions WHERE REGEXP_LIKE(file_path,'.*','i') AND REGEXP_LIKE(function_name,'.*astraAnswerCall','i') ORDER BY file_path,function_name;
SELECT * FROM jsfunctions WHERE REGEXP_LIKE(file_path,'.*','i') AND REGEXP_LIKE(function_name,'^nTreeUtil\.','i') ORDER BY file_path,function_name;
SELECT * FROM jsfunctions;

SELECT * FROM jsfiles WHERE REGEXP_LIKE(file_path,'.*','i') AND REGEXP_LIKE(callee_name,'.*settimer','i')  ORDER BY file_path,parent_function,callee_name;
SELECT * FROM jsfiles WHERE REGEXP_LIKE(file_path,'conv.*','i') AND REGEXP_LIKE(callee_name,'\.*getCurFormatString','i') AND REGEXP_LIKE(arguments_value,'.*','i') ORDER BY file_path,parent_function,callee_name,arguments_value;
SELECT * FROM jsfiles WHERE REGEXP_LIKE(file_path,'conv','i') AND REGEXP_LIKE(function_name,'^gfn_OpenPop','i') ORDER BY file_path,function_name;
SELECT * FROM jsfiles WHERE REGEXP_LIKE(file_path,'conv.*bdm','i') AND REGEXP_LIKE(callee_name,'.*','i') ORDER BY file_path,member_name;
SELECT * FROM jsfiles WHERE REGEXP_LIKE(file_path,'conv.*','i') AND REGEXP_LIKE(callee_name,'getCurFormatString','i') ORDER BY file_path,member_name;
SELECT * FROM jsfiles WHERE REGEXP_LIKE(file_path,'.*','i') AND REGEXP_LIKE(member_name,'^nTreeUtil\.get_TOTAL_HAESSAL_MM_AMT','i') ORDER BY file_path,member_name;
SELECT MEMBER_NAME ,count(*) FROM jsfiles WHERE REGEXP_LIKE(file_path,'conv.*','i') AND REGEXP_LIKE(member_name,'^nTreeUtil\.','i') GROUP BY member_name ORDER BY member_name;
SELECT * FROM jsfiles WHERE REGEXP_LIKE(file_path,'conv.*','i') AND REGEXP_LIKE(member_name,'^nTreeUtil\.','i') ORDER BY member_name, file_path,line_num;
SELECT * FROM jsfiles WHERE REGEXP_LIKE(file_path,'conv.*','i') AND REGEXP_LIKE(member_name,'^ds_.+\.','i') ORDER BY member_name, file_path,line_num;

SELECT attr_value FROM TARGET_elements  WHERE upper(element_name) = 'DATASET' AND upper(attr_name) = 'ID';


SELECT callee_name,count(*) FROM (
SELECT * FROM jsfiles WHERE REGEXP_LIKE(file_path,'conv.*','i') AND substr(member_name,1,instr(member_name,'.')-1 ) IN (SELECT attr_value FROM TARGET_elements  WHERE upper(element_name) = 'DATASET' AND upper(attr_name) = 'ID') ) t GROUP BY callee_name ORDER BY callee_name ;

SELECT callee_name,count(*) FROM (
SELECT * FROM jsfiles WHERE REGEXP_LIKE(file_path,'conv.*','i') AND substr(member_name,1,instr(member_name,'.')-1 ) IN (SELECT attr_value FROM TARGET_elements  WHERE upper(element_name) = '' AND upper(attr_name) = 'ID') ) t GROUP BY callee_name ORDER BY callee_name ;
SELECT * FROM target_jsfiles WHERE (new_file_path,substr(member_name,1,instr(member_name,'.')-1 )) IN (SELECT new_file_path,attr_value FROM target_elements WHERE attr_name = 'name');
SELECT * FROM target_jsfiles a INNER JOIN (SELECT * FROM target_elements WHERE attr_name = 'name') b ON a.new_file_path = b.new_file_path AND substr(a.member_name,1,instr(a.member_name,'.')-1 ) = b.attr_value;
SELECT * FROM TARGET_ELEMENTS te WHERE REGEXP_LIKE(attr_name,'name','i');
SELECT * FROM jsfiles a inner JOIN target_elements b ON REPLACE(substr(a.file_path,1,instr(a.file_path,'.',-1)-1),'\\','\')  = substr(b.file_path,1,instr(b.file_path,'.',-1)-1)   ;
SELECT * FROM jsfiles WHERE (REPLACE(substr(file_path,1,instr(file_path,'.',-1)-1),'\\','\'),substr(member_name,1,instr(member_name,'.')-1 ))  IN (SELECT substr(file_path,1,instr(file_path,'.',-1)-1),attr_value FROM target_elements WHERE attr_name = 'id')   ;
CREATE TABLE elements_id AS SELECT file_path,element_name,attr_value id FROM TARGET_elements  WHERE  upper(attr_name) = 'ID';
SELECT substr(file_path,1,instr(file_path,'.',-1)-1) FROM target_elements ;
SELECT REPLACE(substr(file_path,1,instr(file_path,'.',-1)-1),'\\','\') FROM jsfiles ;

SELECT MEMBER_NAME ,count(*) FROM jsfiles WHERE REGEXP_LIKE(file_path,'conv.*','i') AND REGEXP_LIKE(member_name,'^obj\.','i') GROUP BY member_name ORDER BY member_name;
SELECT * FROM jsfiles WHERE REGEXP_LIKE(file_path,'conv.*','i') AND REGEXP_LIKE(member_name,'^obj\.','i') ORDER BY member_name, file_path,line_num;
SELECT * FROM jsfiles WHERE  REGEXP_LIKE(member_name,'^nTreeUtil\.gfn_transaction','i') AND ARGUMENTS_LENGTH = 9  ORDER BY file_path,line_num;
SELECT * FROM jsfiles WHERE  REGEXP_LIKE(member_name,'^nTreeUtil\.gfn_transaction','i') AND ARGUMENTS_LENGTH = 8 AND NOT REGEXP_LIKE(ARGUMENTS_VALUE,'strFnCallback$','i') ORDER BY file_path,line_num;

SELECT * FROM jsfiles WHERE  REGEXP_LIKE(file_path,'.*','i');
DELETE FROM FILECONTENTS WHERE REGEXP_LIKE(file_path,'project.+DSI.+bdm029l|project.+DSI.+bdm977l|project.+DSI.+bdm953l','i');
SELECT * FROM filecontents WHERE REGEXP_LIKE(LINE_TEXT,'function.+Combe_Ds_Set','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;
SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_PATH,'ntree.*','i')  AND REGEXP_LIKE(LINE_TEXT,'function.+Combe_Ds_Set','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;
SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_PATH,'.*','i')  AND REGEXP_LIKE(LINE_TEXT,'\.print|[[:blank:]]+print','i') AND REGEXP_LIKE(FILE_EXT,'pas','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;
SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_PATH,'ntree.*','i')  AND REGEXP_LIKE(LINE_TEXT,'책임자','i') AND REGEXP_LIKE(FILE_EXT,'.*','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;

CREATE TABLE menus (sort NUMBER,pgm_path varchar2(8), sort1 number, sort2 NUMBER, menu_cd varchar2(32), up_menu_cd varchar2(32), menu_nm varchar2(512), menu_lvl NUMBER, pgm_id varchar2(512), expand varchar2(1), logdb_yn varchar2(1), prg_help varchar2(32));
-- insert into menus (sort,pgm_path,sort1,sort2,menu_cd,up_menu_cd,menu_nm,menu_lvl,pgm_id,expand,logdb_yn,prg_help) values (1,'hm',0,1,'hm','hm','HOME',1,'','','N','');
-- TRUNCATE TABLE menus;

SELECT * FROM 
-- nTree 메뉴 목록
SELECT * FROM menus WHERE REGEXP_LIKE(menu_nm,'.*','i')  AND REGEXP_LIKE(pgm_id,'.*','i') ORDER BY sort,sort1,sort2;
SELECT * FROM menus WHERE menu_lvl IN (1)  ORDER BY sort,sort1,sort2;
SELECT * FROM menus WHERE REGEXP_LIKE(menu_nm,'수신명','i')  ORDER BY sort,sort1,sort2;
SELECT a.sort,a.pgm_path,a.sort1,a.sort2,a.menu_cd,a.up_menu_cd,a.menu_nm,a.menu_lvl,b.sort2,b.menu_cd,b.menu_nm FROM menus a LEFT OUTER JOIN menus b ON a.menu_cd = b.up_menu_cd ORDER BY a.sort;

-- 화면중 include "lib::commLib.xjs"; 가 없는 화면이 있는지? 있음
CREATE TABLE xfdls AS SELECT * FROM files WHERE REGEXP_LIKE(FILE_PATH,'ntree.*','i') AND REGEXP_LIKE(FILE_EXT,'^xfdl$','i');
create TABLE xfdl_libs AS SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_PATH,'ntree.*','i') AND REGEXP_LIKE(line_text,'lib::commLib','i') AND REGEXP_LIKE(FILE_EXT,'^xfdl$','i');
SELECT * FROM xfdls a LEFT OUTER JOIN xfdl_libs b ON a.file_path = b.file_path AND a.file_name = b.file_name WHERE b.file_path IS NULL ORDER BY a.file_path;

SELECT * FROM files WHERE REGEXP_LIKE(FILE_PATH,'ntree.*','i') AND REGEXP_LIKE(FILE_EXT,'^xfdl$','i') ;

SELECT * FROM filecontents WHERE REGEXP_LIKE(FILE_PATH,'ntree.*','i') AND REGEXP_LIKE(line_text,'lib::commLib','i') AND REGEXP_LIKE(FILE_EXT,'^xfdl$','i') ORDER BY FILE_PATH ,file_name, LINE_NUM ;
