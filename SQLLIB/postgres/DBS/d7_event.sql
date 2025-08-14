SELECT * FROM d7_event;
SELECT * FROM d7_event WHERE REGEXP_LIKE(name,'image|img','i') ORDER BY name,cevent;
CREATE SEQUENCE authorities_seq START WITH 1;
DROP TABLE AUTHORITIES ;
create table authorities (id NUMBER NOT NULL PRIMARY key, created_by varchar2(255), created_date timestamp not null, last_modified_by varchar2(255), last_modified_date timestamp, authority varchar2(255), user_name varchar2(255));

