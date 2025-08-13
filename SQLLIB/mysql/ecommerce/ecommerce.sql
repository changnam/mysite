create database ecommerce_v2;
create database shopmall;
create database login_system;
create user 'shopmalladmin'@'localhost' identified by 'pass';
create user 'shopmalladmin'@'%' identified by 'pass';

select * from users;
select * from roles;

grant all privileges on shopmall.* to 'shopmalladmin'@'%';
select * from databasechangelog where id regexp '.*';
delete from databasechangelog where  id  = 2;
truncate table databasechangelog;
drop table authors;
drop table book;
drop table products;
CREATE TABLE CHALLENGE_LOG (
  ACTION bigint NOT NULL
);
alter table CHALLENGE_LOG modify ACTION bigint not null comment '0=Send OTP, 1=Verify OTP';
select * from authors;
select * from book;
delete from book where author_id = 6;
delete from authors where id = 6;
drop table authors;
drop table book;
alter table book drop column e_author;
-- changeset yourname:insert-books
DELETE FROM book;
INSERT INTO book VALUES
('ISBN1234', '자바스크립트 입문', 30000,'조현영', '자바스크립트의 기초부터 심화까지 핵심 문법을 학습한 후 12가지 프로그램을 만들며 학습한 내용을 확인할 수 있습니다. 문법 학습과 실습이 적절히 섞여 있어 프로그램을 만드는 방법을 재미있게 익힐 수 있습니다.','길벗','IT전문서', 1000,'2024/02/20','new','ISBN1234.jpg'),
('ISBN1235', '파이썬의 정석', 29800, '조용주,임좌상', '4차 산업혁명의 핵심인 머신러닝, 사물 인터넷(IoT), 데이터 분석 등 다양한 분야에 활용되는 직관적이고 간결한 문법의 파이썬 프로그래밍 언어를 최신 트렌드에 맞게 예제 중심으로 학습할 수 있습니다.','길벗','IT교육교재',1000, '2023/01/10','new', 'ISBN1235.jpg'), 
('ISBN1236', '안드로이드 프로그래밍', 25000, '송미영', '안드로이드의 기본 개념을 체계적으로 익히고, 이를 실습 예제를 통해 익힙니다. 기본 개념과 사용법을 스스로 실전에 적용하는 방법을 학습한 다음 실습 예제와 응용 예제를 통해 실전 프로젝트 응용력을 키웁니다.', '길벗', 'IT교육교재', 1000, '2023/06/30', 'new','ISBN1236.jpg');

select * from messages;
insert into messages (code,locale,message) values ('typeMismatch.java.lang.Integer','en','input number only');
insert into messages (code,locale,message) values ('typeMismatch.java.lang.Integer','ko','숫자를 입력하세요');
select * from book;
delete  from book where b_unitPrice is null;
select * from accounts;
select * from account_roles;
select * from account_account_roles;
insert into account_roles (roleName,erole) values ('admin','ROLE_ADMIN');
select * from members;
select * from roles;
select * from member_roles;
delete from users;
delete from users where userId = 'cngoh1';
insert into user_roles (role_id,user_id) values ('admin','admin');
insert into roles values ('user','ROLE_USER');
delete from roles where roleId = 'user';
select * from users;
select * from user_roles;
insert into user_roles (role_id,user_id) values ('admin','admin');
insert into user_roles (role_id,user_id,createdAt,createdDate) values ('user','cngoh1',current_timestamp(),current_date());
insert into user_roles (role_id,user_id,createdAt,createdDate) values ('staff','cngoh1',current_timestamp(),current_date());
delete from user_roles where user_id = 'cngoh1' and role_id = 'admin';
select * from roles;
select * from role_permissions;
select * from messages;
select * from permissions;

insert into permissions values("GET","VIEW_ROLE","/api/v1/roles/**","view_role");
insert into permissions values("GET","VIEW_USER","/api/v1/users/**","view_user");
insert into permissions values("PUT","UPDATE_USER","/api/v1/users/**","update_user");
insert into messages (code,locale,message) values ('label.addUser.form.title','en','User registration');
insert into messages (code,locale,message) values ('label.addUser.form.title','ko','사용자 등록');
insert into messages (code,locale,message) values ('label.editUser.form.title','en','User update');
insert into messages (code,locale,message) values ('label.editUser.form.title','ko','사용자 수정');
delete from roles where roleId = 'staff';
insert into roles value ('user','ROLE_USER');
select * from role_permissions;
select * from students;
select * from courseregistration;
select * from courses;
insert into courses (description,title) values ('blabla','test');
drop table courseregistration;
drop table courses;
drop table students;
drop table user_roles;
drop table role_permissions;
drop table user_role_assignments;
drop table user_role_assignment_histories;
drop table user_role_histories;
drop table user_role_histories_seq;
drop table users;
drop table roles;
drop table permissions;
-- changeset yourname:add-eauthor-column
ALTER TABLE book ADD COLUMN author_id int(11);
drop table account_account_roles;
drop table accounts;
drop table account_roles;
-- changeset yourname:add-isbn-column
ALTER TABLE book ADD COLUMN b_isbn varchar(255);

select * from users;
-- select * from user_roles;
select * from roles;
select * from users;
delete from users where userid = 'admin';
select * from roles;
select * from user_role_assignments;
delete from user_role_assignments where user_userid = 'admin';
select * from user_role_assignment_histories;
select * from products;
select * from computers;
select * from reviews;
select * from cart_items;
select * from carts;
delete from user_role_assignment_histories;
drop table user_role_assignment_histories;
drop table user_role_assignments;
drop table user_role_assignment_histories;
drop table user_role_histories;
drop table user_roles;
drop table cart_items;
drop table carts;
drop table users;
drop table role_permissions;
drop table roles;
drop table cleaner_details;
drop table computer_details;
drop table product_details;
drop table cleaners;
drop table computers;
drop table product_images;
drop table reviews;
drop table products;

drop table books;
drop table book;
select * from books;
select * from computers;
-- changeset yourname:add-title-column
ALTER TABLE book ADD COLUMN b_title varchar(255);
select * from filecontents where line_text regexp 'authenticationfilter' and line_text not regexp '@Configuration\\(proxyBeanMethods = false\\)' order by file_path, line_num;
select * from filecontents where file_path regexp 'asb' and line_text regexp 'webfile';
select * from filecontents where line_text regexp '\\\screatebean\\(';
select * from filecontents where line_text regexp 'extends.*abstractbeanfactory';
select substr(file_path,1,90), count(*) cnt from filecontents group by substr(file_path,1,90) ;

create database project9;
create user 'project9user'@'localhbost' identified by 'gujc1234';
create user 'project9user'@'%' identified by 'gujc1234';

select * from boards;

select * from files where file_path regexp '^c:\\\\' and file_size > 100000000 order by file_size desc;
select * from filecontents where file_path regexp 'hydrogen';
delete from filecontents where  file_path regexp '^d:\\\\nodeproj\\\\hydrogen';
create table quickstart as select * from filecontents where file_path regexp 'd:\\\\nodeproj\\\\hydrogen-quickstart';
create table headless as select * from filecontents where file_path regexp 'd:\\\\nodeproj\\\\hydrogen-headless';
select * from (select distinct substr(file_path,33) file_path from quickstart ) a left outer join (select distinct substr(file_path,31) file_path from headless) b
on a.file_path = b.file_path
order by a.file_path;

create table quick as select substr(file_path,33) file_path,file_name,line_num,line_text from quickstart;
drop table head;
create table headl as select substr(file_path,31) file_path,file_name,line_num,line_text from headless;

select * from quick  a left outer join headl b on a.file_path = b.file_path and a.line_text = b.line_text 
where a.file_path regexp 'root\.jsx'
and b.file_path is null order by a.file_path,a.line_num;

select * from quick  a left outer join headl b on a.file_path = b.file_path and a.line_text = b.line_text 
where a.file_path regexp '.env' and b.file_path is null and a.file_path not regexp 'components|graphql|routes'
order by a.file_path,a.line_num;

select concat('node runBabelTransform.js ',file_path,' >> trans.out 2 > &1  ') from files where regexp_like(file_path,'d:\\\\nodeproj\\\\hydrogen-headless') and not regexp_like(file_path,'d:\\\\nodeproj\\\\hydrogen-headless\\\\\\.+') 
and not regexp_like(file_path,'d:\\\\nodeproj\\\\hydrogen-headless\\\\node_modules') and regexp_like(file_ext,'jsx|js|ts|tsx') order by file_path;

create database shadow_quickguide;
grant all privileges on 