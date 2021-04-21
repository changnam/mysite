SELECT * FROM shoppingnt.DP_TCATEGORY;
select category_code,count(*) from shoppingnt.DP_TCATEGORY group by category_code order by category_code;
select p_category_code,count(*) from shoppingnt.DP_TCATEGORY group by P_CATEGORY_CODE order by p_category_code;
select * from 