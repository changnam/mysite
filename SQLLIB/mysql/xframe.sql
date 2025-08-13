 drop table elements;
 create table elements (file_path varchar(256),file_name varchar(128),depth int,element_name varchar(128),element_id int,parent_name varchar(128),parent_id int,attr_name varchar(128), attr_value varchar(4000),control_id varchar(8), in_index varchar(8), name_xf varchar(32), element_sub_id int, element_text varchar(4000));

truncate table elements;
 select * from elements order by file_path,depth,element_id,attr_name;
 select * from elements where depth = 2 order by file_path,element_name;
 select * from elements where element_name regexp 'data' order by file_path,element_id,attr_name;
 select * from elements where element_name = 'column' order by file_path,element_id,attr_name;
 select * from (select * from elements where element_name = 'data' and attr_name = 'data_type') a inner join (select * from elements where element_name = 'column') b on a.file_path = b.file_path and a.parent_id = b.element_id order by a.file_path,a.element_id,a.attr_name;
select * from elements where file_path regexp 'a7780010' 
-- and  element_name = 'column' 
order by file_path,element_id,attr_name;
truncate table elements;
select * From elements where file_path regexp 'sample' order by file_path,element_id,attr_name;
SELECT * FROM elements where file_path regexp 'xframesj'; -- 205,984개
select file_path,file_name,element_id,element_name,parent_id,parent_name,attr_name,attr_value 
  from elements 
where file_path regexp 'xframesj' and ltrim(rtrim(attr_name)) <> ''
group by file_path,file_name,element_id,element_name,parent_id,parent_name,attr_name,attr_value 
order by file_path,element_id,attr_name; -- 16,239개
-- create table all_attr_name as 
select attr_name,count(*),length(max(attr_value)) colsize from elements where ltrim(rtrim(attr_name)) <> '' group by attr_name order by colsize desc ; -- 458개
SELECT * FROM elements where file_path regexp 'xframesj' and attr_value regexp 'favorite';
select sum(colsize) From all_attr_name;
create table elements_bk as select * from elements;
delete from elements where file_path regexp 'sjrx';
commit;
create table elements_controlid as select file_path,element_id,attr_value from elements where attr_name = 'control_id';
update elements a inner join elements_controlid b
on a.file_path = b.file_path and a.element_id = b.element_id
set a.control_id = b.attr_value
where a.file_path regexp 'sjrx' and a.element_name not in ('map','map_list');
-- C:\xFrameSJ\project\SJRX\screen\DESIGN\A7780030.xml
-- C:\xFrameSJ\project\SJRX\screen\DESIGN\A7780030.xml
-- 0
-- 0
select * 
-- , case when a.file_path = b.file_path then 'ok' else 'notok' end as file_path
-- , case when a.control_id = b.control_id then 'ok' else 'notok' end as control_id
from elements_bk a left outer join elements b
--  from (select file_path,element_id,attr_name,control_id from elements_bk) a inner join (select file_path,element_id,attr_name,control_id from elements where file_path regexp 'a7780030'  and control_id in ('0') and element_id in (57)) b
on a.file_path = b.file_path 
and a.control_id = b.control_id  
and a.attr_name = b.attr_name 
and a.attr_value = b.attr_value
where a.file_path regexp '.*' 
and a.control_id is not null
-- and a.control_id in ('0','1') 
-- and a.element_id in (57)
and b.file_path is null
order by a.file_path,a.element_id,a.attr_name;
select * from elements_bk a left outer join elements b on a.file_path = b.file_path
and a.attr_name = b.attr_name
and a.attr_value = b.attr_value
where a.file_path regexp 'a7780030' and a.control_id is null
and a.element_name in ('screen')
and b.file_path is null
order by a.file_path,a.element_id,a.attr_name; 

select * from elements_bk where file_path regexp 'a7780030' and control_id = '0' order by file_path,element_id,attr_name;
select * from elements where file_path regexp 'a7780030' and control_id = '0' order by file_path,element_id,attr_name;
select * from 
(select * from elements_bk where file_path regexp 'a7780030' and control_id = '0' ) a
left outer join  
(select * from elements where file_path regexp 'a7780030' and control_id = '0' ) b
on a.file_path = b.file_path and a.control_id = b.control_id and a.attr_name = b.attr_name 
-- and a.attr_value = b.attr_value
order by a.file_path,a.element_id,a.attr_name;
select * from elements_bk a left outer join elements b on a.file_path = b.file_path and a.control_id and b.control_id and a.attr_name = b.attr_name and a.attr_value = b.attr_value
where a.file_path regexp 'a7780030' 
order by a.file_path,a.element_id,a.attr_name;

select * from elements where file_path regexp 'a7780030' and control_id is not null order by file_path,element_id,attr_name;
select * from elements_bk where file_path regexp 'a7780030' and control_id is not null order by file_path,element_id,attr_name;

select * from elements_bk where file_path regexp 'sjrx' order by file_path,element_id;
drop table elementshz;
create table filecontents (file_path varchar(512)
, file_name varchar(256)
, line_num int
, line_text text
, work_timestamp timestamp);

select * from filecontents where file_path regexp 'springframework' and line_text regexp 'enablecaching\.class' order by file_path,line_num;
select * from filecontents where file_path regexp 'springframework' and line_text regexp 'registerAnnotationConfigProcessors' order by file_path,line_num;
select * from filecontents where file_path regexp 'xframesj' and line_text regexp 'springApplicationArguments' order by file_path,line_num;
select * from filecontents where file_path regexp 'ccntran' and line_text regexp '.*send' order by file_path,line_num;
select * from filecontents where file_path regexp '.*' and line_text regexp 'httpcom' order by file_path,line_num;
select * from filecontents where file_path regexp 'sjrx' and line_text regexp 'favorite' order by file_path,line_num;
select * from filecontents where file_path regexp '.*' and line_text regexp '업무' order by file_path,line_num;
select element_name,attr_name,max(length(attr_value)) maxlen from elements group by element_name,attr_name order by 3 desc;
select attr_value,length(attr_value) from elements where element_name regexp '.*' and attr_name regexp 'OZPrintCommand$' order by 2 desc;
select * from hanadata ;
select * from hanadata where ltrim(rtrim(picklist)) <> '';
select * from 
(select * from hanadata where ltrim(rtrim(picklist)) <> '') a inner join hanaheader b on a.file_path = b.file_path and a.parent_id = b.parent_id 
order by a.file_path,a.element_id;

select * from hanacolumn where file_path regexp '7780010';
select * from hanaheader order by file_path,element_id;
select * from elements where file_path regexp '7780010' and element_id in (18,16) order by file_path,element_id,attr_name;
select * from elements where file_path regexp 'partmodule' and element_id in (7) order by file_path,element_id,attr_name;
select * from elements where file_path regexp '7780010' order by file_path,element_id,attr_name;

select file_path,file_name,element_name,element_id,parent_id from elements group by file_path,file_name,element_name,element_id,parent_id ;

select * from asbdata;
select * from asbnormal_field;

CREATE TABLE `jsons` (
  `file_path` varchar(256) DEFAULT NULL,
  `file_name` varchar(128) DEFAULT NULL,
  `depth` int DEFAULT NULL,
  `node_name` varchar(128) DEFAULT NULL,
  `parent_name` varchar(128) DEFAULT NULL,
  `attr_name` varchar(128) DEFAULT NULL,
  `attr_value` varchar(4000) DEFAULT NULL,
  `attr_kind` varchar(8) DEFAULT NULL,
  `attr_sub_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
drop table jsons;
truncate table jsons;

select * from jsons;
select * from jsons a inner join jsons b on a.node_name = b.parent_name order by a.file_path,a.node_name,b.attr_name;
select * from jsons where parent_name regexp 'root' order by file_path,depth,parent_name,attr_sub_id,attr_name;
select * from jsons where parent_name in (select node_name from jsons where parent_name regexp 'root') order by file_path,depth,parent_name,attr_sub_id,attr_name;
select * from jsons where parent_name regexp 'nNoxhngL' order by attr_name;
select attr_kind,count(*) from jsons group by attr_kind;
select * from jsons where attr_kind regexp 'number';
select * from jsons where node_name in (select parent_name from jsons where node_name in (select parent_name from jsons where attr_kind regexp 'number'));
select * from jsons where attr_name regexp 'cars';
select * From jsons where attr_value is not null order by file_path,depth,parent_name,attr_sub_id,node_name;