select * from information_schema.tables where upper(table_name) like upper('%bkup') order by table_name;

select count(*) from DP_TCATEGORY_BKUP;
ALTER TABLE DP_TCATEGORY RENAME TO DP_TCATEGORY_BK;
alter table DP_TCATEGORY_BKUP RENAME TO DP_TCATEGORY;
select count(*) from DP_TCATEGORY;

select count(*) from PD_TGOODS_BKUP;
ALTER TABLE PD_TGOODS RENAME TO PD_TGOODS_BK;
ALTER TABLE PD_TGOODS_BK DROP foreign key FK_PD_TBRAND_TO_PD_TGOODS;
ALTER TABLE PD_TGOODS_BKUP RENAME TO PD_TGOODS;
ALTER TABLE PD_TGOODS DROP foreign key FK_PD_TBRAND_TO_PD_TGOODSA;
ALTER TABLE PD_TGOODS ADD CONSTRAINT FK_PD_TBRAND_TO_PD_TGOODS FOREIGN KEY (`BRAND_CODE`) REFERENCES PD_TBRAND(`BRAND_CODE`);
select count(*) from PD_TGOODS;

select count(*) from PD_TGOODSDT_BKUP;
alter table PD_TGOODSDT rename to PD_TGOODSDT_BK;
alter table PD_TGOODSDT_BKUP rename to PD_TGOODSDT;
select count(*) from PD_TGOODSDT;

select count(*) from PD_TOFFER_BKUP;
alter table PD_TOFFER rename to PD_TOFFER_BK;
alter table PD_TOFFER_BKUP rename to PD_TOFFER;
select count(*) from PD_TOFFER;

