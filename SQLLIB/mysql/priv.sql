select * from information_schema.user_privileges;
select * from information_schema.user_privileges where grantee like "'root'%";
grant all privileges on *.* to 'root'@'%';
grant all privileges on keycloak.* to 'keycloak'@'%';

