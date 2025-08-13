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
select * from board;
select * from board_seq;
select * from book;
select * from products;
select * from product_details;
select * from persons;
select * from members;
select * from players;
select * from teams;
select * from orders;
select * from orderitem;
select * from members;
select * from members_seq;
select * from shippboard_seqboard_seqboardboarding;
select * from customer;
select * from address;
select * from cart;
select * from databasechangelog;
select *  from databasechangelog where filename regexp "board\\.";
delete from databasechangelog where filename regexp "board\\.";
select * from databasechangeloglock;
drop table databasechangelog;
drop table databasechangeloglock;
drop table students;
delete from databasechangelog;
drop table board;
drop table board_seq;
drop table book;
drop table products;
drop table members;
drop table members_seq;
drop table person;
drop table orders;
drop table orders_seq;
drop table address;
drop table customer;
drop table shipping;
drop table address_seq;
drop table cartitem;
drop table cart;
drop table item;
drop table persons;
drop table orderitem;
drop table orderitem_seq;
delete from databasechangelog;
select count(*) from persons;

drop table books;
drop table products;
drop table product;
drop table computers;
drop table users;
drop table files;
drop table cartitems;
drop table cart;
select * from files where file_name regexp 'entitylistener' and file_ext regexp 'java' order by file_path;
select * from filecontents where line_text regexp 'baseentity' order by file_path;
CREATE TABLE files (id bigint auto_increment
, file_path varchar(512)
, file_name varchar(512)
, file_size bigint
, file_ext varchar(512)
, last_mod_time timestamp
, last_access_time timestamp
, creation_time timestamp
, runjob_time timestamp
, runjob_id int
, primary key (id));


-- USE BOOKMARKETDB;

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

select * from files where file_name regexp 'resum' and file_ext regexp 'doc|docx' ;
truncate table files;
select * from authors;
select * from book;
delete from book;
alter table book add foreign key 
select
        b1_0.b_bookId,
        b1_0.b_author,
        b1_0.b_category,
        b1_0.b_condition,
        b1_0.b_description,
        b1_0.author_id,
        b1_0.b_fileName,
        b1_0.b_isbn,
        b1_0.b_name,
        b1_0.b_publisher,
        b1_0.b_releaseDate,
        b1_0.b_title,
        b1_0.b_unitPrice,
        b1_0.b_unitsInStock 
    from
        Book b1_0 
    join
        authors e1_0 
            on e1_0.id=b1_0.author_id 
    where
        e1_0.name='Joana Nimar' 
    order by
        b1_0.b_title 
    limit
        2;
        
        
        select
        count(b1_0.b_bookId) 
    from
        Book b1_0 
    join
        authors e1_0 
            on e1_0.id=b1_0.author_id 
    where
        e1_0.name='Joana Nimar';
        
        select * from book;
        
        select
        b1_0.author_id,
        b1_0.b_bookId,
        b1_0.b_author,
        b1_0.b_category,
        b1_0.b_condition,
        b1_0.b_description,
        b1_0.b_fileName,
        b1_0.b_isbn,
        b1_0.b_name,
        b1_0.b_publisher,
        b1_0.b_releaseDate,
        b1_0.b_title,
        b1_0.b_unitPrice,
        b1_0.b_unitsInStock 
    fromme
        Book b1_0 
    where
        b1_0.author_id=1;
        select * from members;
        INSERT INTO book VALUES
('ISBN1234', '자바스크립트 입문', 30000,'조현영', '자바스크립트의 기초부터 심화까지 핵심 문법을 학습한 후 12가지 프로그램을 만들며 학습한 내용을 확인할 수 있습니다. 문법 학습과 실습이 적절히 섞여 있어 프로그램을 만드는 방법을 재미있게 익힐 수 있습니다.','길벗','IT전문서', 1000,'2024/02/20','new','ISBN1234.jpg',2,'ISBN1234','자바스크립트'),
('ISBN1235', '파이썬의 정석', 29800, '조용주,임좌상', '4차 산업혁명의 핵심인 머신러닝, 사물 인터넷(IoT), 데이터 분석 등 다양한 분야에 활용되는 직관적이고 간결한 문법의 파이썬 프로그래밍 언어를 최신 트렌드에 맞게 예제 중심으로 학습할 수 있습니다.','길벗','IT교육교재',1000, '2023/01/10','new', 'ISBN1235.jpg',1,'ISBN1234','파이선'), 
('ISBN1236', '안드로이드 프로그래밍', 25000, '송미영', '안드로이드의 기본 개념을 체계적으로 익히고, 이를 실습 예제를 통해 익힙니다. 기본 개념과 사용법을 스스로 실전에 적용하는 방법을 학습한 다음 실습 예제와 응용 예제를 통해 실전 프로젝트 응용력을 키웁니다.', '길벗', 'IT교육교재', 1000, '2023/06/30', 'new','ISBN1236.jpg',1,'ISBN1236','프로그래밍');
select * from products;
select * from computers;
select * from book;
select * from members;
select * from accounts;
select * from account_account_roles;
update account_account_roles set role_id = 2 where account_id = 10;
select * from account_roles;
select * from biz_exception_messages;
insert into biz_exception_messages values('EMAIL_ALREADY_EXIST','en','There are email already exists');
insert into biz_exception_messages values('EMAIL_ALREADY_EXIST','ko','동일한 이메일이 이미 존재합니다');
insert into account_roles (erole) values('ROLE_USER');
insert into account_roles (erole) values('ROLE_ADMIN');
delete from account_account_roles where account_id = 11;
delete from account_roles;
delete from accounts where account_id = 11;
drop table account_acount_roles;
drop table accountrole;
drop table account_roles;
drop table accounts;
select * from products;
select * from authors;
select * from users;
select * from account_roles;
select * from accountrole;
select * from accounts;
drop table bizexceptioncodes;
select * from biz_exception_messages;
update biz_exception_messages set locale = "ko" where locale = "kr";
INSERT INTO biz_exception_messages (code, locale,message) VALUES 
('REVIEW_NOT_FOUND', 'en','Review not found.'),
('REVIEW_PRODUCT_NOT_FOUND', 'en','Product not found for review.'),
('REVIEW_NOT_REGISTERED', 'en','Review not registered.');

INSERT INTO biz_exception_messages (code, locale,message) VALUES 
('PRODUCT_NOT_FOUND', 'en','There are no product which you will delete');

INSERT INTO biz_exception_messages (code, locale,message) VALUES 
('PRODUCT_NOT_FOUND', 'kr','삭제하려는 상품이 없습니다');

