SELECT * FROM dba_objects WHERE REGEXP_LIKE(object_name,'dba_ind','i') ORDER BY owner,object_name; 
SELECT * FROM dba_tables WHERE REGEXP_LIKE(table_name,'table','i') ORDER BY owner,table_name; 
SELECT * FROM dba_tab_columns WHERE rownum < 10;
SELECT * FROM dba_tab_columns WHERE REGEXP_LIKE(column_name,'user_id','i') ORDER BY owner,table_name,column_name; 
SELECT * FROM dba_tab_columns WHERE REGEXP_LIKE(table_name,'CMU030TH','i') ORDER BY owner,table_name,column_name; 

SELECT * FROM dba_tab_comments;
SELECT * FROM dba_tab_comments WHERE REGEXP_LIKE(table_name,'ACA017TM','i') AND REGEXP_LIKE(comments,'.*','i') ORDER BY owner,table_name; 

-- 컬럼 코멘트
SELECT * FROM dba_tab_comments a INNER JOIN dba_col_comments b ON a.owner = b.owner AND a.table_name = b.table_name 
WHERE REGEXP_LIKE(a.table_name,'.*','i') AND REGEXP_LIKE(a.comments,'.*','i') AND REGEXP_LIKE(b.COLUMN_NAME,'.*','i') AND REGEXP_LIKE(b.COMMENTS,'계좌번호','i')
ORDER BY a.owner,a.table_name,b.COLUMN_NAME ;

SELECT * FROM dba_tab_comments a INNER JOIN dba_col_comments b ON a.owner = b.owner AND a.table_name = b.table_name 
WHERE REGEXP_LIKE(a.table_name,'.*','i') AND REGEXP_LIKE(a.comments,'.*','i') AND REGEXP_LIKE(b.COLUMN_NAME,'EDMS_FILE_ID','i') AND REGEXP_LIKE(b.COMMENTS,'.*','i')
ORDER BY a.owner,a.table_name,b.COLUMN_NAME ;

SELECT * FROM dba_constraints WHERE REGEXP_LIKE(table_name,'cmc018tm','i') ORDER BY owner,table_name,constraint_name;
SELECT * FROM DBA_INDEXES a INNER JOIN dba_constraints b ON a.owner = b.owner AND a.table_name = b.table_name AND a.INDEX_NAME = b.CONSTRAINT_NAME 
WHERE REGEXP_LIKE(b.table_name,'cmc018tm','i') AND b.CONSTRAINT_TYPE = 'P' ;
SELECT * FROM dba_ind_columns WHERE REGEXP_LIKE(table_name,'cmc018tm','i') ORDER BY table_owner,TABLE_name,index_owner,index_name,column_position ;
-- cmc018tm
SELECT * FROM dba_sequences WHERE REGEXP_LIKE(SEQUENCE_NAME,'SEQ_CMC018TM','i') ;

SELECT * FROM LNC005TH WHERE CRT_DTM > '20240101000000' AND EDMS_FILE_ID IS NOT null ; --신청심사원장이력
SELECT * FROM LNC001TM a INNER JOIN LNC005TH b ON a.insp_no = b.INSP_NO 
-- WHERE (FSB_LOAN_NO IN (SELECT LOAN_NO FROM ACA017TM) OR MO_LOAN_NO IN (SELECT LOAN_NO FROM ACA017TM))
WHERE fsb_cust_no IN (SELECT cust_no FROM ACA017TM)
  -- AND a.REQ_DTM > '20240101000000' AND b.EDMS_FILE_ID IS NOT NULL 
ORDER BY a.insp_no; -- 신청심사원장  (fsb_cust_no : 고객번호) ()
SELECT * FROM ACA018TH ; -- 완납증명서 (0건)
SELECT * FROM ACA017TM ; -- 부채증명서/금융거래확인서 (8건)
SELECT * FROM ACA019TM ; -- 상환확인서 (54건) -- PRINT_NO :발급번호 
SELECT * FROM ACA020TM ; -- 미연체확인서 (40건)-- PRINT_NO :발급번호 , LOAN_NO : 대출번호

SELECT * FROM cmc018tm ORDER BY SEQ_NO DESC;
