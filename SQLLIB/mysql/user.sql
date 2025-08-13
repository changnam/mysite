select host, user from mysql.user;
-- 사용자 계정 추가하면서 권한 부여
grant all privileges on nsdb.* to 'nsuser'@'localhost' ;
-- *.* <-- 모든 데이터베이스와 모든 테이블에 접근/추가/수정/삭제 (보안상 주의 필요)
grant all privileges on nsdb.* to 'nsuser'@'%' ;
-- 'nsuser'@'localhost' <-- localhost는 내부 접근 허용
-- 'nsuser'@'%' <-- %는 외부 접근을 가능하도록 허용

-- grant 사용하지 않고 사용자 생성 방법
create user 'nsuser2'@'localhost' identified by '1qaz@wsx';
create user 'nsuser2'@'%' identified by '1qaz@wsx';

-- 사용자 권한 확인
show grants for 'nsuser'@'localhost';
-- 사용자 권한 삭제
revoke all privileges on nsdb.* from 'nsuser'@'localhsot';
-- 사용자 삭제
drop user 'nsuser2'@'localhost';
drop user 'nsuser2'@'%';

-- current user 조회
select user() from dual;
-- current database 조회
select database() from dual;


drop table user;
create table users (username varchar(32), password varchar(512), enabled boolean);
create table authorities (username varchar(32), authority varchar(32));

truncate table users;
select * From users;
insert into users values('user','$2a$10$h3vXJ4sWHeAhGppQDgwWfulW4X3kdRVGdXo0PSktubfplTusM5gkG','1');
insert into users values('global','$2a$10$h3vXJ4sWHeAhGppQDgwWfulW4X3kdRVGdXo0PSktubfplTusM5gkG','1');

select * from authorities;
truncate table authorities;
insert into authorities values ('user','ROLE_USER');
insert into authorities values ('global','ROLE_ADMIN');