-- shoppingnt.IF_LOTTERYPROMOCUST definition

CREATE TABLE `IF_LOTTERYPROMOCUST_BKUP` (
  `IF_REG_DT` varchar(8) NOT NULL COMMENT 'IF�������',
  `IF_SEQ` varchar(6) NOT NULL COMMENT 'IFSEQ',
  `IF_SEQ_NO` varchar(6) NOT NULL DEFAULT '1' COMMENT 'IFSEQNO',  
  `IF_TYPE` varchar(2) NOT NULL COMMENT 'IFDML����',
  `SEQ` varchar(16) NOT NULL COMMENT '�Ϸù�ȣ',
  `LOTTERY_PROMO_NO` varchar(12) NOT NULL COMMENT '��÷�������θ�ǹ�ȣ',
  `CUST_NO` varchar(12) NOT NULL COMMENT '����ȣ',
  `ORDER_NO` varchar(14) DEFAULT NULL COMMENT '�ֹ���ȣ',
  `PROMO_NO` varchar(12) DEFAULT NULL COMMENT '���θ�ǹ�ȣ',
  `CANCEL_YN` varchar(1) NOT NULL COMMENT '��ҿ���',
  `CANCEL_DATE` datetime DEFAULT NULL COMMENT '����Ͻ�',
  `CANCEL_ID` varchar(10) DEFAULT NULL COMMENT '�����ID',
  `REMARK` varchar(300) DEFAULT NULL COMMENT '���',
  `REG_ID` varchar(10) NOT NULL COMMENT '���ID',
  `REG_DT` datetime NOT NULL COMMENT '����Ͻ�',
  `IF_FLAG` varchar(1) NOT NULL DEFAULT 'R' COMMENT 'IF����',
  `IF_MSG` varchar(600) COMMENT 'IF�޽���',
  `IF_DTM` datetime  COMMENT 'IF�Ͻ�',
  `IF_REG_ID` varchar(10) NOT NULL COMMENT 'IF�����',
  `IF_REG_DTM` datetime NOT NULL COMMENT 'IF����Ͻ�',
  `IF_UPD_ID` varchar(10) NOT NULL COMMENT 'IF������',
  `IF_UPD_DTM` datetime NOT NULL COMMENT 'IF�����Ͻ�',
  PRIMARY KEY (`IF_REG_DT`,`IF_SEQ`,`IF_SEQ_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='IF_��÷���θ������';


select * from IF_LOTTERYPROMOCUST_BKUP;
alter table IF_LOTTERYPROMOCUST rename to IF_LOTTERYPROMOCUST_BK;
alter table IF_LOTTERYPROMOCUST_BKUP rename to IF_LOTTERYPROMOCUST;
select * from IF_LOTTERYPROMOCUST;


select concat('alter table ',substr(table_name,1,length(table_name) - 5),' rename to ',substr(table_name,1,length(table_name) - 2),';') from information_schema.tables where table_name like 'IF%BKUP' order by table_name;
select concat('alter table ',table_name,' rename to ',substr(table_name,1,length(table_name) - 5),';') from information_schema.tables where table_name like 'IF%BKUP' order by table_name;
