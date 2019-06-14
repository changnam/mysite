--Creating a common user account.
create user c##shop1 identified by shop1 container=all;
grant connect,resource to c##shop1;

--Creating a Local User
alter session set container=icapdb1;
	
create user scott identified by tiger quota 50M on users;
grant connect,resource to scott;
