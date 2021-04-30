-- shoppingnt.IF_LOTTERYPROMOCUST definition

CREATE TABLE `IF_LOTTERYPROMOCUST_BKUP` (
  `IF_REG_DT` varchar(8) NOT NULL COMMENT 'IF등록일자',
  `IF_SEQ` varchar(6) NOT NULL COMMENT 'IFSEQ',
  `IF_SEQ_NO` varchar(6) NOT NULL DEFAULT '1' COMMENT 'IFSEQNO',  
  `IF_TYPE` varchar(2) NOT NULL COMMENT 'IFDML구분',
  `SEQ` varchar(16) NOT NULL COMMENT '일련번호',
  `LOTTERY_PROMO_NO` varchar(12) NOT NULL COMMENT '추첨응모프로모션번호',
  `CUST_NO` varchar(12) NOT NULL COMMENT '고객번호',
  `ORDER_NO` varchar(14) DEFAULT NULL COMMENT '주문번호',
  `PROMO_NO` varchar(12) DEFAULT NULL COMMENT '프로모션번호',
  `CANCEL_YN` varchar(1) NOT NULL COMMENT '취소여부',
  `CANCEL_DATE` datetime DEFAULT NULL COMMENT '취소일시',
  `CANCEL_ID` varchar(10) DEFAULT NULL COMMENT '취소자ID',
  `REMARK` varchar(300) DEFAULT NULL COMMENT '비고',
  `REG_ID` varchar(10) NOT NULL COMMENT '등록ID',
  `REG_DT` datetime NOT NULL COMMENT '등록일시',
  `IF_FLAG` varchar(1) NOT NULL DEFAULT 'R' COMMENT 'IF상태',
  `IF_MSG` varchar(600) COMMENT 'IF메시지',
  `IF_DTM` datetime  COMMENT 'IF일시',
  `IF_REG_ID` varchar(10) NOT NULL COMMENT 'IF등록자',
  `IF_REG_DTM` datetime NOT NULL COMMENT 'IF등록일시',
  `IF_UPD_ID` varchar(10) NOT NULL COMMENT 'IF수정자',
  `IF_UPD_DTM` datetime NOT NULL COMMENT 'IF수정일시',
  PRIMARY KEY (`IF_REG_DT`,`IF_SEQ`,`IF_SEQ_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='IF_추첨프로모션응모';


select * from IF_LOTTERYPROMOCUST_BKUP;
alter table IF_LOTTERYPROMOCUST rename to IF_LOTTERYPROMOCUST_BK;
alter table IF_LOTTERYPROMOCUST_BKUP rename to IF_LOTTERYPROMOCUST;
select * from IF_LOTTERYPROMOCUST;


select concat('alter table ',substr(table_name,1,length(table_name) - 5),' rename to ',substr(table_name,1,length(table_name) - 2),';') from information_schema.tables where table_name like 'IF%BKUP' order by table_name;
select concat('alter table ',table_name,' rename to ',substr(table_name,1,length(table_name) - 5),';') from information_schema.tables where table_name like 'IF%BKUP' order by table_name;
