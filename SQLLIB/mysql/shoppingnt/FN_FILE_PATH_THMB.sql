CREATE DEFINER=`root`@`localhost` FUNCTION `FN_FILE_PATH_THMB`(
P_ATCH_FILE_ID  BIGINT  -- 첨부파일ID
) RETURNS int
BEGIN
   DECLARE R_VAL VARCHAR(500);



    SELECT INSERT(FILE_PATH, INSTR(FILE_PATH, '.'), 0, '_thmb') INTO R_VAL FROM SY_ATCH_FILE WHERE ATCH_FILE_ID = P_ATCH_FILE_ID;



    RETURN R_VAL;

END