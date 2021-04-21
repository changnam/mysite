rollback;
alter session close database link shoppingnt;
drop database link shoppingnt;
CREATE DATABASE LINK shoppingnt CONNECT TO "shoppingnt" IDENTIFIED BY "Shoppingnt2021!@" USING 'dg4odbc';

select * from information_schema.tables@shoppingnt where table_schema = 'shoppingnt' order by table_name;

select * from pd_tbrand@shoppingnt;

select * from database_parameters where upper(name) like upper('%data%') order by name;

rollback;
