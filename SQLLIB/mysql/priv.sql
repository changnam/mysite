select * from information_schema.user_privileges;
select * from information_schema.user_privileges where grantee like "'root'%";
grant all privileges on *.* to 'root'@'%' identified by 'P@ssw0rd';

