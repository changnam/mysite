select host, user from mysql.user;
-- 사용자 계정 추가하면서 권한 부여
grant all privileges on nsdb.* to 'nsuser'@'localhost' identified by '1qaz@wsx';
--*.* <-- 모든 데이터베이스와 모든 테이블에 접근/추가/수정/삭제 (보안상 주의 필요)
grant all privileges on nsdb.* to 'nsuser'@'%' identified by '1qaz@wsx';
--'nsuser'@'localhost' <-- localhost는 내부 접근 허용
--'nsuser'@'%' <-- %는 외부 접근을 가능하도록 허용

-- grant 사용하지 않고 사용자 생성 방법
create user 'nsuser2'@'localhost' identified by '1qaz@wsx';
create user 'nsuser2'@'%' identified by '1qaz@wsx';

-- 사용자 권한 확인
show grants for 'nsuser'@'localhost';
-- 사용자 권한 삭제
revoke all on nsdb.* from 'nsuser'@'localhost';
-- 사용자 삭제
drop user 'nsuser2'@'localhost';
drop user 'nsuser2'@'%';
