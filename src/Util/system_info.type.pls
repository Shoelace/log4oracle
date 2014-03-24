CREATE OR REPLACE
TYPE system_info
AUTHID DEFINER
AS OBJECT
(
	instance VARCHAR2(30),
	instance_name VARCHAR2(30),
	db_domain VARCHAR2(30),
	db_name VARCHAR2(30),
	db_role VARCHAR2(30),
	server_host VARCHAR2(30),
	service_name VARCHAR2(30)

  ,constructor function system_info return self as result
);
/
show errors
