select * from information_schema.user_privileges;
select * from information_schema.user_privileges where grantee like "'root'%";
grant all privileges on *.* to 'root'@'%';
grant all privileges on keycloak.* to 'keycloak'@'%';

select * from information_schema.schema_privileges where upper(grantee) like upper('%shoppingnt%') order by grantee,table_schema,privilege_type;


GRANT SELECT ON shoppingnt.PD_TBRAND_BKUP TO joe@localhost IDENTIFIED BY 'pass';