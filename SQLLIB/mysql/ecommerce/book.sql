select * from filecontents where file_path regexp 'epic-next-course' and line_text regexp 'api';
delete from filecontents where file_path regexp 'epic-next';
commit;

CREATE DATABASE broadleaf;
CREATE USER 'broadleaf'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON broadleaf.* TO 'broadleaf'@'localhost';
FLUSH PRIVILEGES;


select * from files where file_path regexp 'broadleaf.*test';
select count(*) from files where file_path regexp 'broadleaf.*test';
create table v619 as select * from files where file_path regexp 'broadleaf';
delete from files where file_path regexp 'broadleaf';
commit;
select * from v619;
create table v703 as select * from files where file_path regexp 'broadleaf';
select * from v703;
select * from v619 a left outer join v703 b on a.file_path = b.file_path and a.file_size = b.file_size
where a.file_ext = 'java' and b.file_path is null;

delete from filecontents where file_path regexp 'broadleaf';
commit;
select count(*) from filecontents where file_path regexp 'broadleaf';
create table v619 as select * from filecontents where file_path regexp 'broadleaf';
select * from v619;
create table v703 as select * from filecontents where file_path regexp 'broadleaf';
select * from v703;
select * from v619 a left outer join v703 b on a.file_path = b.file_path and a.line_num = b.line_num 
-- and a.line_text = b.line_text
where b.file_path is null;

drop table book;
CREATE TABLE IF NOT EXISTS book(
	b_bookId VARCHAR(10) NOT NULL,
	b_name VARCHAR(30),
	b_unitPrice  INTEGER,
	b_author VARCHAR(50),
	b_description TEXT,
	b_publisher VARCHAR(20),
	b_category VARCHAR(20),
	b_unitsInStock LONG,	
	b_releaseDate VARCHAR(20),
	b_condition VARCHAR(20),
	b_fileName  VARCHAR(20),
	PRIMARY KEY (b_bookId)
);

DELETE FROM book;
INSERT INTO book VALUES('ISBN1234', '자바스크립트 입문', 30000,'조현영', '자바스크립트의 기초부터 심화까지 핵심 문법을 학습한 후 12가지 프로그램을 만들며 학습한 내용을 확인할 수 있습니다. 문법 학습과 실습이 적절히 섞여 있어 프로그램을 만드는 방법을 재미있게 익힐 수 있습니다.','길벗','IT전문서', 1000,'2024/02/20','new','ISBN1234.jpg');
INSERT INTO book VALUES('ISBN1235', '파이썬의 정석', 29800, '조용주,임좌상', '4차 산업혁명의 핵심인 머신러닝, 사물 인터넷(IoT), 데이터 분석 등 다양한 분야에 활용되는 직관적이고 간결한 문법의 파이썬 프로그래밍 언어를 최신 트렌드에 맞게 예제 중심으로 학습할 수 있습니다.','길벗','IT교육교재',1000, '2023/01/10','new', 'ISBN1235.jpg'); 
INSERT INTO book VALUES('ISBN1236', '안드로이드 프로그래밍', 25000, '송미영', '안드로이드의 기본 개념을 체계적으로 익히고, 이를 실습 예제를 통해 익힙니다. 기본 개념과 사용법을 스스로 실전에 적용하는 방법을 학습한 다음 실습 예제와 응용 예제를 통해 실전 프로젝트 응용력을 키웁니다.', '길벗', 'IT교육교재', 1000, '2023/06/30', 'new','ISBN1236.jpg');

