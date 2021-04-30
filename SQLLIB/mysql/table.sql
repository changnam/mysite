select concat(concat(concat(concat('alter table ',table_name),' rename to '),substr(table_name,1,length(table_name)-5)),';') from information_schema.tables where table_name like upper('DP%BKUP') order by table_name;
select concat(concat('drop  table ',table_name),';') 
  from information_schema.tables where table_name like upper('%_BK') order by table_name;

create table CM_TCARDDT_BKUP like CM_TCARDDT;

select * from information_schema.tables where upper(table_name) like upper('%tmd%') order by table_schema,table_name;
 
select * from (select * from information_schema.tables where table_name like '%BK') a inner join information_schema.tables b
on substr(a.table_name,1,length(a.table_name)-3) = b.table_name ;

select table_schema as database_name,
    table_name
from information_schema.tables
where table_type = 'BASE TABLE'
        and table_schema = 'shoppingnt' -- enter your database name here
order by database_name, table_name;

select * from information_schema.columns
where table_schema = 'shoppingnt'
  and upper(table_name) like upper('%pd_tgoods%')
order by table_name,ordinal_position;

select table_schema,table_name,column_name,ordinal_position,column_type,column_comment from information_schema.columns
where table_schema = 'shoppingnt'
  and upper(table_name) like upper('%pd_tgoods%')
order by table_name,ordinal_position;

select * from information_schema.tables where table_schema = 'saeki' and upper(table_name) like upper('%pd_%')
order by table_schema,table_name;

select * from information_schema.tables where table_schema = 'shoppingnt' and upper(table_name) like upper('%pd_%')
order by table_schema,table_name;


alter table PD_TBRAND modify column DISABLE_YN varchar(1) NOT NULL default 0 COMMENT '사용안함여부';
alter table PD_TBRAND modify column  `PA_NAVR_NO_ENTRY_YN` varchar(1) NOT NULL default 0 COMMENT '네이버입점불가여부';

drop table PD_TBRAND_BKUP;
alter table `CM_TCARDCODE` modify column   `REST_RATE` decimal(5,2) DEFAULT 0 NULL;
alter table `CM_TCARDCODE` modify column     `NOREST_NO` varchar(14) DEFAULT 0 NULL;
alter table `CM_TCARDCODE` modify column     `CARD_POINT_YN` varchar(1) DEFAULT '0' NULL;
alter table `CM_TCARDCODE` modify column     `USE_YN` varchar(1) DEFAULT '1' NULL;
alter  TABLE `CM_TCARDCODE` modify column   `NOREST_RATE` decimal(5,2) DEFAULT 0 NULL;
alter table `CM_TCARDDT`  modify column `MONTH` decimal(2,0)default 0 NOT NULL COMMENT 'N(2)';
alter table  `CM_TCARDDT` modify column `NOREST_RATE` decimal(5,2) default 0 NOT NULL COMMENT '무이자수수료율';

alter TABLE `DP_TCATEGORY` modify column   `DISPLAY_YN` varchar(1) DEFAULT '1' NULL COMMENT '전시여부';
alter TABLE `DP_TCATEGORY` modify column    `DISPLAY_PRIORITY` decimal(5,0) DEFAULT 1 NULL COMMENT '전시우선순위';

alter TABLE `DP_TCATEGORYGOODS` modify column   `DISPLAY_YN` varchar(1) DEFAULT '1' NULL COMMENT '전시여부';
alter TABLE `DP_TCATEGORYGOODS` modify column   `DISPLAY_PRIORITY` decimal(5,0) DEFAULT 1 NULL COMMENT '전시우선순위';

alter TABLE `CM_TCODE` modify column   `USE_YN` varchar(1) default '1' NOT NULL COMMENT '사용여부';

alter TABLE `PD_TDESCRIBECODE` modify column  `BROAD_SHOW` varchar(1) default  '0' NOT NULL COMMENT '방송노출여부';
alter TABLE `PD_TDESCRIBECODE` modify column    `BROAD_USE` varchar(1) default  '0' NOT NULL COMMENT '방송필수여부';
alter TABLE `PD_TDESCRIBECODE` modify column    `SNT_SHOW` varchar(1) default  '0' NOT NULL COMMENT '쇼핑엔딜노출여부';
alter TABLE `PD_TDESCRIBECODE` modify column    `SNT_USE` varchar(1) default  '0' NOT NULL COMMENT '쇼핑엔딜방송필수여부';
alter TABLE `PD_TDESCRIBECODE` modify column    `MOBILE_SHOW` varchar(1) default  '0' NOT NULL COMMENT '모바일노출여부';
alter TABLE `PD_TDESCRIBECODE` modify column    `MOBILE_USE` varchar(1) default  '0' NOT NULL COMMENT '모바일필수여부';
alter TABLE `PD_TDESCRIBECODE` modify column    `USE_YN` varchar(1) DEFAULT '1' NULL COMMENT '사용여부';

alter TABLE `VD_TENTERPRISE` modify column   `ENTP_GUBUN` varchar(1) default '1' NOT NULL COMMENT '업체구분[B001]';
alter TABLE `VD_TENTERPRISE` modify column     `ROAD_ADDR_YN` varchar(1) default '0' NOT NULL COMMENT '도로명주소여부';
alter TABLE `VD_TENTERPRISE` modify column     `ACCOUNT_GB` varchar(4) DEFAULT '0030' NULL COMMENT '결재주기[B075]';
alter TABLE `VD_TENTERPRISE` modify column     `DIRECT_DELY_GB` varchar(2) DEFAULT '11' NULL COMMENT '직택배배송구분';
alter TABLE `VD_TENTERPRISE` modify column     `DISHONOR_YN` varchar(1) DEFAULT '0' NULL COMMENT '거래구분[B135]';
alter TABLE `VD_TENTERPRISE` modify column     `FOREIGN_YN` varchar(1) DEFAULT '1' NULL COMMENT '외자여부';
alter TABLE `VD_TENTERPRISE` modify column     `SHIP_FEE_BASE_AMT` decimal(10,2) DEFAULT 0 NULL COMMENT '기본배송비';
alter TABLE `VD_TENTERPRISE` modify column     `SHIP_FEE` decimal(8,2) DEFAULT 0 NULL COMMENT '주문배송비';
alter TABLE `VD_TENTERPRISE` modify column     `SECURITYINVOICE_YN` varchar(1) DEFAULT '1' NULL COMMENT '보안송장사용여부';
alter TABLE `VD_TENTERPRISE` modify column     `SECURITYINVOICE_TRANS_YN` varchar(1) DEFAULT '0' NULL COMMENT '보안송장전송여부';
alter TABLE `VD_TENTERPRISE` modify column     `ENTP_SIZE` varchar(2) DEFAULT '01' NULL COMMENT '업체규모[B136]';
alter TABLE `VD_TENTERPRISE` modify column     `SAT_WORK_YN` varchar(1) DEFAULT '0' NULL COMMENT '토요근무여부';
alter TABLE `VD_TENTERPRISE` modify column     `NOT_INSURANCE_YN` varchar(1) DEFAULT '0' NULL COMMENT '이행보증보험가입면제여부';
alter TABLE `VD_TENTERPRISE` modify column     `ENTP_SIZE_FILE_YN` varchar(1) DEFAULT '0' NULL COMMENT '중소기업증빙자료유무';

alter table VD_TENTPUSER modify column ENTP_MAN_GB varchar(2) default 	'10' 	NOT NULL COMMENT '담당자구분[B120]';
alter table VD_TENTPUSER modify column ROAD_ADDR_YN varchar(1) default 	'0'  NOT NULL COMMENT '도로명주소여부'	;
alter table VD_TENTPUSER modify column DEFAULT_YN varchar(1) default 	'0'   NULL COMMENT '기본여부'	;
alter table VD_TENTPUSER modify column SECURITYINVOICE_TRANS_YN varchar(1) default 	'0'	  NULL COMMENT '보안송장 전송여부';
alter table VD_TENTPUSER modify column TRANS_STATUS varchar(1) default 	'0'	 NULL COMMENT '출고지/회수지전송상태';

alter table PD_TGOODSADDINFO modify column DELIVERY_COST decimal(15,2) DEFAULT 	"0 "  NULL COMMENT 'DELIVERY_COST'	;
alter table PD_TGOODSDT modify column SALE_GB varchar(2) default 	'00'  NOT NULL COMMENT '판매구분'	;
alter table PD_TGOODSINFODT modify column USE_YN varchar(1) default 	'1'	 NULL COMMENT '사용여부';

alter table PD_TGOODSINFOIMAGE modify column INFO_IMAGE_TYPE varchar(2) DEFAULT	'10'	 NULL COMMENT '상세이미지유형[F103]';
alter table PD_TGOODSINFOIMAGE modify column DISPLAY_PRIORITY decimal(3,0) default 	0 	 NOT NULL COMMENT '우선순위';

alter table PD_TGOODSINFOM modify column USE_YN varchar(1) DEFAULT 	'1'	  NULL COMMENT '사용여부';

alter  TABLE `PD_TGOODSKINDS` modify column   `LGROUP` varchar(2) NOT NULL  comment  '대분류' ;
alter  TABLE `PD_TGOODSKINDS` modify column     `MGROUP` varchar(2) NOT NULL comment  '중분류' ;
alter  TABLE `PD_TGOODSKINDS` modify column     `SGROUP` varchar(2) NOT NULL comment  '소분류' ;
alter  TABLE `PD_TGOODSKINDS` modify column     `DGROUP` varchar(2) NOT NULL comment  '세분류' ;
alter  TABLE `PD_TGOODSKINDS` modify column     `LGROUP_NAME` varchar(60) NOT NULL comment  '대분류명' ;
alter  TABLE `PD_TGOODSKINDS` modify column     `MGROUP_NAME` varchar(60) NOT NULL comment  '중분류명' ;
alter  TABLE `PD_TGOODSKINDS` modify column     `SGROUP_NAME` varchar(60) NOT NULL comment  '소분류명' ;
alter  TABLE `PD_TGOODSKINDS` modify column     `DGROUP_NAME` varchar(60) NOT NULL comment  '세분류명' ;
alter  TABLE `PD_TGOODSKINDS` modify column     `LMSD_CODE` varchar(10) DEFAULT NULL comment  '상품분류코드' ;
alter  TABLE `PD_TGOODSKINDS` modify column     `QC_LGROUP` varchar(2) DEFAULT NULL comment  '미사용' ;
alter  TABLE `PD_TGOODSKINDS` modify column     `QC_MGROUP` varchar(2) DEFAULT NULL comment  '미사용' ;
alter  TABLE `PD_TGOODSKINDS` modify column     `DEF_VAT_RATE` decimal(5,2) NOT NULL DEFAULT '0.00'	 comment  '기본부가세율' ;
alter  TABLE `PD_TGOODSKINDS` modify column     `AVG_DELY_LEADTIME` decimal(3,0) DEFAULT '0' comment  '평균배송소요일' ;
alter  TABLE `PD_TGOODSKINDS` modify column     `THIRD_PARTY_REQ_YN` varchar(1) DEFAULT '0' comment  '제3자제공동의 필수여부' ;
alter  TABLE `PD_TGOODSKINDS` modify column     `CTRL_PAY_METHOD_YN` varchar(1) DEFAULT '0' comment  '결제수단제어여부';
alter  TABLE `PD_TGOODSKINDS` modify column     `REG_ID` varchar(10) NOT NULL COMMENT '등록ID';
alter  TABLE `PD_TGOODSKINDS` modify column     `REG_DT` datetime NOT NULL COMMENT '등록일시';
alter  TABLE `PD_TGOODSKINDS` modify column     `MOD_ID` varchar(10) NOT NULL COMMENT '수정ID';
alter  TABLE `PD_TGOODSKINDS` modify column     `MOD_DT` datetime NOT NULL COMMENT '수정일시';

alter table PD_TGOODSPRICE modify column BUY_COST 	decimal(12,2)  default 	0 NOT NULL COMMENT '입출고원가';
alter table PD_TGOODSPRICE modify column BUY_VAT 	decimal(12,2) default 	0  NOT NULL COMMENT '입출고부가세';
alter table PD_TGOODSPRICE modify column BUY_PRICE decimal(12,2) default 	0  NOT NULL COMMENT '매입가'	;
alter table PD_TGOODSPRICE modify column BUY_VAT_RATE decimal(5,2) DEFAULT 0 NULL COMMENT '매입부가세율'	;
alter table PD_TGOODSPRICE modify column SALE_PRICE decimal(12,2) default 0 NOT NULL COMMENT '판매가' 	;
alter table PD_TGOODSPRICE modify column SALE_VAT 	decimal(12,2) default 0 NOT NULL COMMENT '판매부가세';
alter table PD_TGOODSPRICE modify column SALE_VAT_RATE decimal(5,2) DEFAULT 	0	 NULL COMMENT '판매부가세율';
alter table PD_TGOODSPRICE modify column CUST_PRICE 	decimal(12,2) default 	0  NOT NULL COMMENT '시중판매가';
alter table PD_TGOODSPRICE modify column SAVEAMT_RATE  decimal(5,2) default 	0 	 NOT NULL COMMENT '적립급비율';
alter table PD_TGOODSPRICE modify column SAVEAMT decimal(12,2) default 	0   NOT NULL COMMENT '적립금'	;
alter table PD_TGOODSPRICE modify column ARS_DC_AMT 	decimal(13,2) default 	0  NOT NULL COMMENT 'ars할인금액';
alter table PD_TGOODSPRICE modify column ARS_OWN_DC_AMT decimal(13,2) default 	0 	 NOT NULL COMMENT 'ars당사부담금액';
alter table PD_TGOODSPRICE modify column ARS_ENTP_DC_AMT decimal(13,2)  default 	0 	NOT NULL COMMENT 'ars업체부담금액';
alter table PD_TGOODSPRICE modify column ANALYSIS_SALE_PRICE decimal(10,0) DEFAULT  	0	NULL COMMENT '무형상품 매출판매가';
alter table PD_TGOODSPRICE modify column ANALYSIS_SALE_VAT decimal(10,0) DEFAULT  	0	NULL COMMENT '무형상품매출판매 부가세';
alter table PD_TGOODSPRICE modify column ANALYSIS_COMSN decimal(10,0) DEFAULT 	0	 NULL COMMENT '무형상품수수료';
alter table PD_TGOODSPRICE modify column CALL_COST decimal(10,0) DEFAULT 	0	 NULL COMMENT '콜수수료단가';
alter table PD_TGOODSPRICE modify column GIFT_OWN_COST decimal(5,2) DEFAULT 	100	 NULL COMMENT '사은품 당사부담비율';
alter table PD_TGOODSPRICE modify column PA_DC_TRANS_YN varchar(1) DEFAULT  	'0' NULL COMMENT '제휴가격할인전송여부'	;

alter table PD_TGOODSSHARE modify column SHARE_FLAG  varchar(2) DEFAULT  	'00'NULL COMMENT '기술서공유구분[B134]'	;

alter table PD_TGOODSSIGN modify column BUY_COST decimal(12,2) default 	0 	 NOT NULL COMMENT '입출고원가';
alter table PD_TGOODSSIGN modify column BUY_VAT decimal(12,2) default 	0 	 NOT NULL COMMENT '입출고부가세';
alter table PD_TGOODSSIGN modify column BUY_PRICE decimal(12,2) default 	0 	 NOT NULL COMMENT '매입가';
alter table PD_TGOODSSIGN modify column SALE_PRICE  	decimal(12,2) default 	0 NOT NULL COMMENT '판매가';
alter table PD_TGOODSSIGN modify column SALE_VAT 	decimal(12,2) default 	0  NOT NULL COMMENT '판매부가세';
alter table PD_TGOODSSIGN modify column CUST_PRICE 	decimal(12,2) default 	0  NOT NULL COMMENT '시중판매가';
alter table PD_TGOODSSIGN modify column SAVEAMT_RATE decimal(5,2) default 	0  NOT NULL COMMENT '적립급비율'	;
alter table PD_TGOODSSIGN modify column SAVEAMT decimal(12,2) default 	0 	 NOT NULL COMMENT '적립금';
alter table PD_TGOODSSIGN modify column ARS_DC_AMT 	decimal(13,2)  default 	0 NOT NULL COMMENT 'ars할인금액';
alter table PD_TGOODSSIGN modify column ARS_OWN_DC_AMT decimal(13,2)  default 	0 NOT NULL COMMENT 'ars당사부담금액'	;
alter table PD_TGOODSSIGN modify column ARS_ENTP_DC_AMT decimal(13,2) default 	0  NOT NULL COMMENT 'ars업체부담금액'	;
alter table PD_TGOODSSIGN modify column SIGN_GB varchar(12) default 	'00'    NULL COMMENT '결재구분'	;
alter table PD_TGOODSSIGN modify column ANALYSIS_SALE_PRICE decimal(10,0) default 	0	  NULL COMMENT '무형상품 매출판매가';
alter table PD_TGOODSSIGN modify column ANALYSIS_SALE_VAT decimal(10,0) DEFAULT 	0	 NULL COMMENT '무형상품매출판매 부가세';
alter table PD_TGOODSSIGN modify column ANALYSIS_COMSN decimal(10,0) DEFAULT 	0  NULL COMMENT '무형상품수수료'	;
alter table PD_TGOODSSIGN modify column CALL_COST decimal(10,0) DEFAULT 	0	 NULL COMMENT '콜수수료단가';
alter table PD_TGOODSSIGN modify column GIFT_OWN_COST 	decimal(5,2) DEFAULT 	100 NULL COMMENT '사은품 당사부담비율';
alter table PD_TGOODSSIGN modify column NOREST_ALLOT_MONTHS varchar(36) DEFAULT 	'100000000000000000000000000000000000'	 NULL COMMENT '무이자할부가능개월수';
alter table PD_TGOODSSIGN modify column NOREST_OWN_RATE decimal(5,2) DEFAULT 	100	 NULL COMMENT '무이자할부수수료당사부담비율';
alter table PD_TGOODSSIGN modify column PA_DC_TRANS_YN varchar(1) DEFAULT  	'0'	NULL COMMENT '제휴가격할인전송여부';

alter table PD_TGOODSVOD modify column DISPLAY_PRIORITY decimal(3,0) default 	0  NOT NULL COMMENT '우선순위'	;

alter table PD_TINPLANQTY modify column GOODS_CODE varchar(10) default 	'0' 	 NOT NULL COMMENT '상품코드';
alter table PD_TINPLANQTY modify column GOODSDT_CODE varchar(3) default 	'0'  NOT NULL COMMENT '단품코드'	;
alter table PD_TINPLANQTY modify column SEQ varchar(5) default 	'0' 	  NOT NULL COMMENT '순번';
alter table PD_TINPLANQTY modify column LEAD_TIME decimal(3,0) default 	0  NOT NULL COMMENT 'LEAD_TIME'	;
alter table PD_TINPLANQTY modify column DAILY_CAPA_QTY decimal(7,0) default 	0 	  NOT NULL COMMENT '일입고수량';
alter table PD_TINPLANQTY modify column MAX_SALE_QTY decimal(7,0) default 	0 	 NOT NULL COMMENT '실최대판매가능수량';

alter table MK_TLOTTERYPROMOCUST modify column CANCEL_YN varchar(1) default 	'0' 	 NOT NULL COMMENT '취소여부';

alter table MK_TLOTTERYPROMOM modify column DO_TYPE  varchar(2) default 	'10' NOT NULL COMMENT '혜택구분[B007]'	;
alter table MK_TLOTTERYPROMOM modify column LIMIT_YN  varchar(1) DEFAULT  	'0'	NULL COMMENT '한정여부';
alter table MK_TLOTTERYPROMOM modify column LIMIT_QTY decimal(10,0) DEFAULT  	0	NULL COMMENT '한정수량';
alter table MK_TLOTTERYPROMOM modify column CONFIRM_CNT decimal(5,0) default 	0  NOT NULL COMMENT '확정인원수'	;
alter table MK_TLOTTERYPROMOM modify column PROVIDE_CNT decimal(5,0) default 	0 	 NOT NULL COMMENT '추첨인원수';
alter table MK_TLOTTERYPROMOM modify column USE_CODE varchar(2) default 	'00' 	 NOT NULL COMMENT '프로모션진행상태[B064]';
alter table MK_TLOTTERYPROMOM modify column END_YN varchar(1) DEFAULT  	'0'	NULL COMMENT '추첨완료여부';
alter table MK_TLOTTERYPROMOM modify column APPLY_YN  varchar(1) DEFAULT  	'0'NULL COMMENT '당첨자적용여부'	;

alter table MK_TLOTTERYPROMOPRIZE modify column CANCEL_YN varchar(1) default 	'0'   NOT NULL COMMENT '취소여부'	;
alter table MK_TLOTTERYPROMOPRIZE modify column NOT_APPLY_YN varchar(1) DEFAULT 	'0'	 NULL COMMENT '당첨자적용제외여부';

alter table VD_TMAKECOMP modify column ROAD_ADDR_YN 	varchar(1) default 	'0'  NOT NULL COMMENT '도로명주소여부';
alter table VD_TMAKECOMP modify column QUICK_YN varchar(1) default 	'0' 	 NOT NULL COMMENT '긴급편성여부';

alter table SA_TMD modify column USE_YN varchar(1) DEFAULT 	'1'	 NULL COMMENT '사용여부';
alter table SA_TMD modify column TV_ICON_YN  varchar(1) DEFAULT 	'0' NULL COMMENT 'TV쇼핑노출여부';
alter table SA_TMD modify column SAVEAMT_ICON_YN varchar(1) DEFAULT  	'0'	 NULL COMMENT '적립금노출';
alter table SA_TMD modify column PA_CODE_GB varchar(1) DEFAULT 	'2'	 NULL COMMENT '제휴등록계정';
alter table SA_TMD modify column RETURN_YN varchar(1) DEFAULT  	'0'	NULL COMMENT '상담원 반품/교환만 가능';

alter table SA_TMDKINDS modify column USE_YN varchar(1) DEFAULT 	'1'	 NULL COMMENT '사용여부';
alter table SA_TMDLINK modify column MAIN_YN varchar(1) DEFAULT 	'0'	 NULL COMMENT '메인여부';
alter table SA_TMDLINK modify column USE_YN varchar(1) DEFAULT 	'1'	 NULL COMMENT '사용여부';

alter table CM_TMEDIA modify column USE_YN varchar(1) DEFAULT 	'1'	 NULL COMMENT '사용여부';
alter table CM_TMEDIA modify column CATALOG_PAGE  decimal(5,0) DEFAULT 	0	 NULL COMMENT '카타로그페이지';
alter table CM_TMEDIA modify column WEIGHT decimal(5,2) DEFAULT  	0	NULL COMMENT '중량';
alter table CM_TMEDIA modify column GOODS_CNT decimal(5,0) DEFAULT  	0	NULL COMMENT '상품게제수';
alter table CM_TMEDIA modify column PRODUCT_CNT decimal(7,0) DEFAULT 	0	 NULL COMMENT '제작부수';
alter table CM_TMEDIA modify column PLATFORM_GB varchar(2) DEFAULT  	'00'	NULL COMMENT '플랫폼구분[B012]';
alter table CM_TMEDIA modify column ORGANIZATION_GB 	varchar(3) DEFAULT  	'00' NULL COMMENT '편성구분[B013]';

alter table PD_TOFFER modify column USE_YN varchar(1) default 	'1'  NOT NULL COMMENT '사용여부'	;
alter table PD_TOFFERCODE modify column SORT_SEQ decimal(5,0) default 	1 	  NOT NULL;
alter table PD_TOFFERCODE modify column USE_YN varchar(1) default 	'1' 	 NOT NULL;

alter table MK_TPROMOGIFT modify column GIFT_QTY decimal(7,0) default 	1  NOT NULL COMMENT '사은품수량'	;

alter table MK_TPROMOM modify column FIRST_ORDER_YN varchar(1)  default 	'0' NOT NULL COMMENT '첫주문혜택여부'	;
alter table MK_TPROMOM modify column COUPON_YN  varchar(1) default 	'0' 	 NOT NULL COMMENT '쿠폰여부';
alter table MK_TPROMOM modify column MEMB_GB_ALL_YN 	varchar(1) default 	'1'  NOT NULL COMMENT '전체회원등급여부';
alter table MK_TPROMOM modify column ORDER_MEDIA_ALL_YN varchar(1) default 	'1' 	 NOT NULL COMMENT '전체주문매체';
alter table MK_TPROMOM modify column ARS_YN varchar(1) DEFAULT  	'0'	NULL COMMENT 'ARS프로모션여부';
alter table MK_TPROMOM modify column MEDIA_CODE_ALL_YN varchar(1) default 	'1' 	 NOT NULL COMMENT '전체광고매체';
alter table MK_TPROMOM modify column LIMIT_YN 	varchar(1) default 	'0'  NOT NULL COMMENT '한정여부';
alter table MK_TPROMOM modify column LIMIT_QTY decimal(7,0) default 	0 	 NOT NULL COMMENT '한정수량';
alter table MK_TPROMOM modify column GOODS_ALL_YN 	varchar(1) default 	'0'  NOT NULL COMMENT '전체상품대상여부';
alter table MK_TPROMOM modify column GROSS_NET_FLAG 	varchar(1) DEFAULT  	'1' NULL COMMENT '판매가할인가구분';
alter table MK_TPROMOM modify column AMT_RATE_FLAG  varchar(1) default 	'1' 	 NOT NULL COMMENT '금액비율구분';
alter table MK_TPROMOM modify column DO_RATE decimal(5,2) default 	0 	 NOT NULL COMMENT '혜택비율';
alter table MK_TPROMOM modify column DO_AMT 	decimal(12,2) default 	0  NOT NULL COMMENT '혜택금액';
alter table MK_TPROMOM modify column SELECT_YN varchar(1) default 	'0' 	 NOT NULL COMMENT '사은품선택여부';
alter table MK_TPROMOM modify column SELECT_QTY decimal(7,0)  default 	0 	NOT NULL COMMENT '사은품선택수량';
alter table MK_TPROMOM modify column USE_CODE 	varchar(2) DEFAULT 	'00'  NULL COMMENT '프로모션진행상태[B064]';
alter table MK_TPROMOM modify column LIMIT_AMT decimal(15,2) DEFAULT 	0	 NULL COMMENT '제한금액';
alter table MK_TPROMOM modify column MIN_PRICE decimal(15,2) DEFAULT  	0	NULL COMMENT '프로모션적용최소금액';
alter table MK_TPROMOM modify column DELY_SEPAR_YN varchar(1) DEFAULT  	'0'	NULL COMMENT '별도배송용여부(추가구성상품)';
alter table MK_TPROMOM modify column COUPON_SMS_YN 	varchar(1) DEFAULT 	'0' NULL COMMENT '쿠폰소멸알림여부';

alter table MK_TPROMOREFEAT modify column STOP_YN varchar(1) DEFAULT 	'0'	 NULL COMMENT '중단여부';
alter table MK_TPROMOTARGET modify column GIFT_AMT  decimal(13,2) default 	0 	 NOT NULL COMMENT '적립금/할인금액';
alter table MK_TPROMOTARGET modify column TARGET_GB varchar(2) DEFAULT  	'00'	NULL COMMENT '그룹대상[B015]';

alter table VD_TSHIPCOSTDT modify column SHIP_WEIGHT decimal(3,0) default 	0 	 NOT NULL COMMENT '배송무게';
alter table VD_TSHIPCOSTDT modify column APPLY_DATE datetime default 	current_timestamp 	 NOT NULL COMMENT '적용일시';
alter table VD_TSHIPCOSTDT modify column ORD_COST_AMT decimal(15,2) default 	0 	NOT NULL COMMENT '주문배송비';
alter table VD_TSHIPCOSTDT modify column RET_COST_AMT decimal(15,2) default 	0 	 NOT NULL COMMENT '반품배송비';
alter table VD_TSHIPCOSTDT modify column EXCH_COST_AMT decimal(15,2)  default 	0 	NOT NULL COMMENT '교환배송비';

alter table VD_TSHIPCOSTM modify column SHIP_COST_CODE varchar(5) default 	'FR001' 	 NOT NULL COMMENT '배송비정책코드';
alter table VD_TSHIPCOSTM modify column SHIP_COST_BASE_AMT decimal(10,2)  default 	0 	NOT NULL COMMENT '배송비기준금액';
alter table VD_TSHIPCOSTM modify column SHIP_COST_RECEIPT varchar(1)  default 	'1' 	NOT NULL COMMENT '배송비수령방법[B605]';
alter table VD_TSHIPCOSTM modify column USE_YN varchar(1) default 	'1' 	 NOT NULL COMMENT '사용여부';

alter table MK_TPROMOM modify column REFEAT_YN varchar(1) DEFAULT 	'0'	 NULL COMMENT '프로모션반복여부';
alter table MK_TPROMOM modify column DUP_COUPON_YN varchar(1) DEFAULT  	'0'	NULL COMMENT '중복쿠폰발급여부';
alter table MK_TPROMOM modify column ENTP_COST decimal(15,2) DEFAULT 	0  NULL COMMENT '업체부담율'	;
alter table MK_TPROMOM modify column MIN_GOODS_RATE decimal(5,2) DEFAULT 	0	 NULL COMMENT '최소상품마진율';
alter table MK_TPROMOM modify column GROUP_GB varchar(2) DEFAULT 	'00'	 NULL COMMENT '프로모션구분[00: 일반, 10: 그룹]';

select * from information_schema.tables where table_schema = 'shoppingnt' and upper(table_name) like upper('%BKUP');

