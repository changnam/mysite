select * from pg_database;
create database keycloak;
create user keycloak identified by 'keycloak';
select current_schema;
create table testtab (id int);
insert into testtab values(30);

select current_database();
select current_schema;
select current_user;
SELECT SESSION_USER;