CREATE OR REPLACE 
package ut_LoggerContext 
AUTHID DEFINER
as

   PROCEDURE ut_setup;
   PROCEDURE ut_teardown;
 
   PROCEDURE ut_loggerContext_1;

end ut_LoggerContext;
/
show errors


create or replace 
package body ut_LoggerContext as

   PROCEDURE ut_setup
	is
	BEGIN
  ut_teardown;
  

		NULL;
	--exception when others then null;
	end;
  
	PROCEDURE ut_teardown
	IS
	BEGIN
		NULL;
	END;
 
	--test logmanager
   PROCEDURE ut_loggerContext_1
	IS
		lc LoggerContext;
    l Logger;
	BEGIN
    lc := NEW SimpleLoggerContext();
    
		utassert.this('loggercontext returned', lc IS NOT NULL);

		utassert.this('loggercontext has no root', NOT lc.haslogger('.'));

		l := lc.getLogger('.');
		utassert.this('loggercontext now has root', lc.haslogger('.'));

		l := lc.getLogger('LOG4.UT_LOGGERCONTEXT');
		utassert.this('loggercontext now has local', lc.haslogger('LOG4.UT_LOGGERCONTEXT'));
    

		--utassert.eq('name test', l.getname(), 'test');

		--utassert.this('root logger returned', l IS NOT NULL);
		--utassert.isnull('rootlogger name test', l.getname() );

--		l := LogManager.getLogger();
--$if dbms_db_version.ver_le_10 $then
--		utassert.eq('default name test', l.getname(), USER||'.'||$$PLSQL_UNIT);
--$elsif dbms_db_version.ver_le_11 $then
--		utassert.eq('default name test', l.getname(), USER||'.'||$$PLSQL_UNIT);
--$else
--		utassert.eq('default name test', l.getname(), USER||'.'||$$PLSQL_UNIT||'.UT_LOGGER_1');
--$end
         
exception
	when others then
			
dbms_output.put_line($$PLSQL_UNIT ||':errorstack:'||dbms_utility.format_error_backtrace);
raise;
	end;


end ut_LoggerContext;
/
show errors

