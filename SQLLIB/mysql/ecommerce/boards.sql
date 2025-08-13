-- DROP TABLE COM_CODE;

CREATE TABLE COM_CODE(
  CLASSNO 	INT(11),				-- 대분류
  CODECD 	VARCHAR(10),			-- 코드
  CODENM 	VARCHAR(30),			-- 코드명
  PRIMARY KEY (CLASSNO, CODECD)
) ;

-- DROP TABLE COM_DEPT;

CREATE TABLE COM_DEPT(
  DEPTNO 	INT(11),   				-- 부서 번호
  DEPTNM 	VARCHAR(20),            -- 부서명
  PARENTNO  INT(11),                -- 부모 부서
  DELETEFLAG CHAR(1),    	        -- 삭제 여부
  PRIMARY KEY (DEPTNO)
) ;


-- DROP TABLE COM_USER;

CREATE TABLE COM_USER(
  USERNO 	INT(11) NOT NULL AUTO_INCREMENT,	-- 사용자 번호
  USERID 	VARCHAR(20),                    	-- ID
  USERNM 	VARCHAR(20),                    	-- 이름
  USERPW 	VARCHAR(100),                    	-- 비밀번호
  USERROLE	CHAR(1),                    		-- 권한
  PHOTO 	VARCHAR(50),                   		-- 사진
  DEPTNO	INT,
  DELETEFLAG CHAR(1),    	                 	-- 삭제 여부
  PRIMARY KEY (USERNO)
) ;

/*------------------------------------------*/

-- DROP TABLE TBL_BOARD;

CREATE TABLE TBL_BOARD (
  BGNO INT(11),                             -- 게시판 그룹번호
  BRDNO INT(11) NOT NULL AUTO_INCREMENT,    -- 글 번호
  BRDTITLE VARCHAR(255),                    -- 글 제목
  USERNO 	INT,                    		-- 작성자
  BRDMEMO   MEDIUMTEXT,		                -- 글 내용
  BRDDATE   DATETIME,                       -- 작성일자
  BRDNOTICE VARCHAR(1),                     -- 공지사항여부
  LASTDATE  DATETIME, 
  LASTUSERNO  	INT, 
  BRDLIKE 		INT default 0,             	-- 좋아요
  BRDDELETEFLAG CHAR(1),                    -- 삭제 여부
  PRIMARY KEY (BRDNO)
) ;

-- DROP TABLE TBL_BOARDFILE;

CREATE TABLE TBL_BOARDFILE (
    FILENO INT(11)  NOT NULL AUTO_INCREMENT, -- 파일 번호
    BRDNO INT(11),                           -- 글번호
    FILENAME VARCHAR(100),                   -- 파일명
    REALNAME VARCHAR(30),                    -- 실제파일명
    FILESIZE INT,                            -- 파일 크기
    PRIMARY KEY (FILENO)
);

CREATE TABLE TBL_BOARDLIKE (
    BLNO INT(11)  NOT NULL AUTO_INCREMENT,  -- 번호
    BRDNO INT(11),                          -- 글번호
	USERNO 	INT,                    		-- 작성자
	BLDATE  DATETIME, 						-- 일자
    PRIMARY KEY (BLNO)
);

-- DROP TABLE TBL_BOARDREPLY;

CREATE TABLE TBL_BOARDREPLY (
    BRDNO INT(11) NOT NULL,                 -- 게시물 번호
    RENO INT(11) NOT NULL,                  -- 댓글 번호
	USERNO 	INT,                    		-- 작성자
    REMEMO VARCHAR(500) DEFAULT NULL,       -- 댓글내용
	REPARENT INT(11),						-- 부모 댓글
	REDEPTH INT,							-- 깊이
	REORDER INT,							-- 순서
    REDATE DATETIME DEFAULT NULL,           -- 작성일자
    REDELETEFLAG VARCHAR(1) NOT NULL,       -- 삭제여부
	LASTDATE  DATETIME, 
    LASTUSERNO  INT, 

    PRIMARY KEY (RENO)
);

-- DROP TABLE TBL_BOARDREAD;

CREATE TABLE TBL_BOARDREAD (
	BRDNO INT(11) NOT NULL,                 -- 게시물 번호
	USERNO 	INT,          			     	-- 작성자
	READDATE DATETIME,						-- 작성일자
	PRIMARY KEY (BRDNO, USERNO)
);


-- DROP TABLE TBL_BOARDGROUP;

CREATE TABLE TBL_BOARDGROUP (
  BGNO INT(11) NOT NULL AUTO_INCREMENT,     -- 게시판 그룹번호
  BGNAME VARCHAR(50),                       -- 게시판 그룹명
  BGPARENT INT(11),                         -- 게시판 그룹 부모
  BGDELETEFLAG CHAR(1),                     -- 삭제 여부
  BGUSED CHAR(1),                           -- 사용 여부
  BGREPLY CHAR(1),                          -- 댓글 사용여부
  BGREADONLY CHAR(1),                       -- 글쓰기 가능 여부
  BGNOTICE CHAR(1),                       	-- 공지 쓰기  가능 여부
  BGDATE DATETIME,                          -- 생성일자
  PRIMARY KEY (BGNO)
);

-- DROP TABLE COM_LOGINOUT;

CREATE TABLE COM_LOGINOUT (
  LNO 		INT(11) NOT NULL AUTO_INCREMENT,    -- 순번
  USERNO 	INT,                    			-- 로그인 사용자
  LTYPE 	CHAR(1),                       		-- in / out
  LDATE 	DATETIME,                          	-- 발생일자
  PRIMARY KEY (LNO)
);

CREATE TABLE TBL_CRUD(
  CRNO INT NOT NULL AUTO_INCREMENT,	-- 번호
  CRTITLE  	VARCHAR(255),     		-- 제목
  USERNO 	INT,            		-- 작성자
  CRMEMO   	MEDIUMTEXT,				-- 내용
  CRDATE   	DATETIME,        		-- 작성일자
  CRDELETEFLAG CHAR(1),     		-- 삭제 여부
  PRIMARY KEY (CRNO)
) ;
select concat('drop table ',table_name,';') from information_schema.tables where table_schema = 'shopmall' and upper(table_name) like upper('%%')
order by table_schema,table_name;
alter table addresses drop index  `UKqvn41cnrngbhp9qrx5ml39tl` ;
ALTER TABLE addresses DROP FOREIGN KEY FKhrpf5e8dwasvdc5cticysrt2k;
CREATE TABLE `addresses` (
  `addressId` bigint NOT NULL AUTO_INCREMENT,
  `addressName` varchar(255) NOT NULL,
  `country` varchar(255) DEFAULT NULL,
  `detailName` varchar(255) DEFAULT NULL,
  `zipCode` varchar(255) DEFAULT NULL,
  `customer_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`addressId`),
  UNIQUE KEY `UKqvn41cnrngbhp9qrx5ml39tl` (`customer_id`,`addressName`),
  CONSTRAINT `FKhrpf5e8dwasvdc5cticysrt2k` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customerId`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from customers;
select * from addresses;
delete from addresses where customer_id = 'yhgoh';
delete from customers where customerId = 'yhgoh';
delete from user_roles where user_id = 'admin';
delete from users ;
delete from permissions permission_id in (select permission_id from role_permissions where role_id ;
select * from cleaners;
select * from computers;
select * from product_details;
select * from cleaner_details;
select * from computer_details;
select * from users;
select * from user_roles;
select * from permissions;
select * from role_permissions;
select * from roles;
select * from members;
select * from messages;
delete from messages;
insert into messages (code,locale,message) values('label.name_ko','ko','이름');
insert into messages (code,locale,message) values('label.name','en','Name');
insert into messages (code,locale,message) values('label.name','ko','이름');
insert into messages (code,locale,message) values('label.email_ko','ko','이메일');
insert into messages (code,locale,message) values('label.email','en','Email');
insert into messages (code,locale,message) values('label.email','ko','이메일');
insert into messages (code,locale,message) values('label.role','en','Role');
insert into messages (code,locale,message) values('label.password','ko','패스워드');
insert into messages (code,locale,message) values('label.password','en','Password');
insert into messages (code,locale,message) values('label.role','ko','롤');
insert into messages (code,locale,message) values('label.addBook.form.title','ko','북 추가');
insert into messages (code,locale,message) values('label.addBook.form.title','en','Add Book');
insert into messages (code,locale,message) values('label.addBook.form.title','ko','북 추가');
delete from messages where code = 'label.addBook.form.title';
insert into messages (code,locale,message) values('label.addBook.form.title','ko','도서 등록');
insert into messages (code,locale,message) values('label.addBook.form.subtitle','ko','신규 도서 등록');
insert into messages (code,locale,message) values('label.addBook.form.bookId','ko','도서ID');
insert into messages (code,locale,message) values('label.addBook.form.name','ko','도서명');
insert into messages (code,locale,message) values('label.addBook.form.unitPrice','ko','가격');
insert into messages (code,locale,message) values('label.addBook.form.author','ko','저자');
insert into messages (code,locale,message) values('label.addBook.form.description','ko','상세정보');
insert into messages (code,locale,message) values('label.addBook.form.publisher','ko','출판사');
insert into messages (code,locale,message) values('label.addBook.form.category','ko','분류');
insert into messages (code,locale,message) values('label.addBook.form.unitsInStock','ko','재고수');
insert into messages (code,locale,message) values('label.addBook.form.releaseDate','ko','출판일'); 
insert into messages (code,locale,message) values('label.addBook.form.condition','ko','상태');
insert into messages (code,locale,message) values('label.addBook.form.fileName','ko','도서이미지');
insert into messages (code,locale,message) values('label.addBook.form.weight','ko','도서 무게');
insert into messages (code,locale,message) values('label.addBook.form.height','ko','도서 높이');
insert into messages (code,locale,message) values('label.addBook.form.button','ko','등록');
update members set role = 'ADMIN' where num =2;
delete from accounts where account_id = 23;
select * from accounts;
select * from account_account_roles;
select * from authors;
insert into authors (age,genre,name) values(24,'history','changnam go');
insert into authors (age,genre,name) values(24,'history','tara dunken');
select * from book;
drop table members;
drop table members_seq;
drop table carts;
delete from users;
select * from roles;
select * from user_roles;
select * from products;
select * from product_images;
select * from exception_messages;
select * from reviews;
select * from computers;
select * from cleaners;
select * from accounts;
select * from account_account_roles;
insert into account_account_roles values(10,1);
delete from addresses;
delete from customers;
drop table orderitem;
drop table orders;
drop table shipping;
drop table addresses;
drop table customers;
drop table address_seq;
drop table board;
drop table board_seq;
drop table book;
drop table cart;
drop table cartitem;
drop table computers;
drop table databasechangelog;
drop table databasechangeloglock;
drop table item;
drop table members;
drop table members_seq;
drop table orderitem_seq;
drop table orders_seq;
drop table persons;
drop table players;
drop table reviews;
drop table product_images;
drop table cleaner_details;
drop table computer_details;
drop table product_details;
drop table cartitems;
drop table cleaners;
drop table computers;
drop table products;
drop table teams;
drop table roles;
drop table users;
drop table authors;
drop table user_roles;
drop table role_permissions;
drop table permissions;
drop table roles;
create table Product (id bigint not null auto_increment, category varchar(255), condition varchar(255), name varchar(255), unitPrice decimal(38,2), unitsInStock integer, primary key (id)) engine=InnoDB);

-- DROP FUNCTION uf_datetime2string;books

DELIMITER $$

CREATE FUNCTION `uf_datetime2string`(dt_ Datetime) RETURNS varchar(10) CHARSET utf8
BEGIN
	DECLARE ti INTEGER ;
	DECLARE ret_ VARCHAR(10);

	SET ti :=  TIMESTAMPDIFF(MINUTE, dt_, NOW());

      IF ti < 1 THEN SET ret_:='방금';
      ELSEIF ti < 60 THEN SET ret_:= CONCAT(TRUNCATE(ti ,0), '분전');
      ELSEIF ti < 60*24 THEN 
            IF ( DATEDIFF(NOW(), dt_)=1) THEN 
                SET ret_:= '어제';
            ELSE
                SET ret_:= CONCAT(TRUNCATE(ti/60 ,0), '시간전');
            END IF;
      ELSEIF ti < 60*24*7 THEN SET ret_:= CONCAT(TRUNCATE(ti/60/24 ,0), '일전');
      ELSEIF ti < 60*24*7*4 THEN SET ret_:= CONCAT(TRUNCATE(ti/60/24/7 ,0), '주전');
      ELSEIF (TIMESTAMPDIFF (MONTH, dt_, NOW())=1) THEN SET ret_:= '지난달';
      ELSEIF (TIMESTAMPDIFF (MONTH, dt_, NOW())<13) THEN 
            IF ( TIMESTAMPDIFF (YEAR, dt_, NOW())=1) THEN 
                SET ret_:= '작년';
            ELSE
                SET ret_:= CONCAT(TRUNCATE(TIMESTAMPDIFF (MONTH, dt_, NOW()) ,0), '달전');
      ELSE SET ret_:= CONCAT(TIMESTAMPDIFF (YEAR, dt_, NOW()), '년전');
      END IF;
      
RETURN ret_;
END
