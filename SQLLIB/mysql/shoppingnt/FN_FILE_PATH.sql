CREATE DEFINER=`root`@`localhost` FUNCTION `FN_FILE_PATH`(
 P_ATCH_FILE_ID  BIGINT  -- 첨부파일ID
 ) RETURNS varchar(500) CHARSET utf8
    COMMENT '파일경로 조회'
BEGIN
 DECLARE R_VAL VARCHAR(500);



    SELECT FILE_PATH INTO R_VAL FROM SY_ATCH_FILE WHERE ATCH_FILE_ID = P_ATCH_FILE_ID;



    RETURN R_VAL;


END