CREATE OR REPLACE
TYPE session_info
AUTHID DEFINER
AS object 
(

	client_ip varchar2(20),
	session_id VARCHAR2(30),
	os_user VARCHAR2(200),
	host VARCHAR2(100),
	module VARCHAR2(48), --v$session.module%type
	action VARCHAR2(32), --v$session.action%type
	client_info VARCHAR2(64), --v$session.client_info%type
	client_identifier VARCHAR2(64), 
	session_user VARCHAR2(100),
	terminal VARCHAR2(100),
	fg_job_id VARCHAR2(100),
	bg_job_id VARCHAR2(100),
	cgi_vars VARCHAR2(4000)

	,	constructor function session_info return self as result

);
/
show errors
