CREATE OR REPLACE TYPE BODY system_info 
AS
--sys_context returns varchar2(256)
  constructor function system_info return self as result as
  begin
        instance := SYS_CONTEXT('USERENV', 'INSTANCE');

        instance_name := SYS_CONTEXT('USERENV', 'INSTANCE_NAME');
        db_domain := SYS_CONTEXT('USERENV', 'DB_DOMAIN');
        db_name := SYS_CONTEXT('USERENV', 'DB_NAME');
        db_role := SYS_CONTEXT('USERENV', 'DATABASE_ROLE');
		server_host :=	SYS_CONTEXT ('USERENV', 'SERVER_HOST');
		service_name :=	SYS_CONTEXT ('USERENV', 'SERVICE_NAME');

		return;
	end;
end;
/
show errors


