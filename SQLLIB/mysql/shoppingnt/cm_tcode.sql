SELECT * FROM shoppingnt.CM_TCODE where code_lgroup = '0000' and upper(code_name) like upper('%상품%분류%') order by code_lgroup,code_mgroup,code_name;
select * from shoppingnt.CM_TCODE where code_lgroup = 'B053' order by code_lgroup,code_mgroup,code_name; -- 상품대분류코드
select * from shoppingnt.CM_TCODE where upper(code_name) like upper('%방송%') and upper(code_lgroup) like upper('j%') order by code_lgroup,code_mgroup,code_name;
-- 상품 중분류는 TGOODSKINDS 에서 관리
select * from shoppingnt.PD_TGOODSKINDS ;
select lgroup from shoppingnt.PD_TGOODSKINDS group by lgroup order by lgroup;
select * from shoppingnt.PD_TGOODSKINDS where lgroup not in (select code_mgroup from shoppingnt.CM_TCODE where code_lgroup = 'B053');
select * from shoppingnt.PD_TGOODSKINDS where lgroup = '15' order by lgroup,mgroup,sgroup;
select * from shoppingnt.CM_TCODE where code_lgroup = 'J009';  -- 소싱매체 구분코드
