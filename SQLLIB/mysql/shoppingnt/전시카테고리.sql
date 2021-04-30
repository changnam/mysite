SELECT * FROM shoppingnt.DP_TCATEGORY;
select category_code,count(*) from shoppingnt.DP_TCATEGORY group by category_code order by category_code;
select p_category_code,count(*) from shoppingnt.DP_TCATEGORY group by P_CATEGORY_CODE order by p_category_code;
select * from CM_TCODE where CODE_LGROUP = 'B108'; -- 카테고리구분코드 (TCATEGORY 의 category_level)
select * from CM_TCODE where CODE_LGROUP = 'B139'; -- 영역구분코드 (TAREA 의 AREA_TYPE)
select * from CM_TCODE where CODE_LGROUP in ('B140','B141','B142') order by code_lgroup,code_mgroup; -- 배너유형, 배너분류, 배너진행상태 코드 (TBANNER )
