truncate table filecontents;
select * from filecontents;

CREATE TABLE `filecontents` (
  `file_path` varchar(512) DEFAULT NULL,
  `file_name` varchar(256) DEFAULT NULL,
  `line_num` int DEFAULT NULL,
  `line_text` text,
  `work_timestamp` timestamp NULL DEFAULT NULL
) ;

create table fileencodings (file_path varchar(512), file_name varchar(256), line_num int);

truncate table filecontents;
select * from filecontents;
select * from filecontents where line_text regexp 'customauthentication' and file_name regexp 'java$' order by file_path,line_num;
select * from filecontents where line_text regexp 'started' and file_name regexp '.*' order by file_path,line_num;
select * from fileencodings;
select substr(file_path,1,35), count(*) from filecontents group by substr(file_path,1,35) ;
select * from files;
select * from files limit 100;
select * from files where file_size > 1000000000;
select * from files where file_ext regexp 'SQL' order by file_path;
select * from files where file_ext regexp '^SQL$' and file_path not regexp '^C:\\\\oraclexe'  and file_path not regexp '^C:\\\\program files'  and file_path not regexp '^C:\\\\programdata' 
and file_path not regexp '^d:\\\\oraclexe' and file_path not regexp '^C:\\\\windows' and file_path not regexp '^d:\\\\temp' 
and file_path not regexp '^d:\\\\워크플로우' and file_path not regexp '^C:\\\\users' order by file_path;
select * from files where file_name regexp '_prisma_migrations' and file_ext regexp 'sql';
select count(*) from files;
SELECT substr(file_path, 1, 12), SUM(file_size) / 1024 
FROM files
GROUP BY substr(file_path, 1, 12)
ORDER BY 2 DESC;

select * from files where file_path regexp '^c:\\\\' limit 100;
select * from files where file_path regexp '^c:\\\\' and last_mod_time between '2025-01-01 00:00:00' and '2025-02-28 00:00:00' order by last_mod_time;
select * from files where file_path regexp '^c:\\\\' and file_ext regexp 'zip|7z' and last_mod_time between '2025-01-01 00:00:00' and '2025-02-28 00:00:00' order by last_mod_time;
delete from files where file_path regexp '^c:\\\\';
commit;


