CREATE DEFINER=`root`@`localhost` FUNCTION `FN_CD_ADDVAL1`(
P_CD    VARCHAR(10) -- 코드
) RETURNS varchar(500) CHARSET utf8
    COMMENT '코드추가값1 조회'
BEGIN
DECLARE R_VAL VARCHAR(500);



SELECT 
    ADD_VAL_1
INTO R_VAL FROM
    CM_CD
WHERE
    CD = P_CD;



    RETURN R_VAL;

END