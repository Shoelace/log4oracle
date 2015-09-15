create or replace 
package ut_Logger 
AUTHID DEFINER
as

   PROCEDURE ut_setup;
   PROCEDURE ut_teardown;
 
   PROCEDURE ut_logger_1;
   PROCEDURE ut_logger_2;
      PROCEDURE ut_logger_3;

end ut_Logger;
/
show errors


create or replace 
package body ut_Logger as

   PROCEDURE ut_setup
	is
	BEGIN
  ut_teardown;
  
insert into log_levels values( USER||'.'||$$PLSQL_UNIT||'.UT_LOGGER_2',1,1,1,1,1,1);
--		l := LogManager.getLogger('test');

		NULL;
	--exception when others then null;
	end;
  
	PROCEDURE ut_teardown
	IS
	BEGIN
delete from  log_levels where logger_name = USER||'.'||$$PLSQL_UNIT||'.UT_LOGGER_2';
		NULL;
	END;
 
	--test logmanager
   PROCEDURE ut_logger_1
	is
		l Logger;
	begin
		l := LogManager.getLogger('test');
		utassert.this('logger returned', l IS NOT NULL);

		utassert.eq('name test', l.getname(), 'test');

		--l := LogManager.getRootLogger();
		--utassert.this('root logger returned', l IS NOT NULL);
		--utassert.isnull('rootlogger name test', l.getname() );

		l := LogManager.getLogger();
$if dbms_db_version.ver_le_10 $then
		utassert.eq('default name test', l.getname(), USER||'.'||$$PLSQL_UNIT);
$elsif dbms_db_version.ver_le_11 $then
		utassert.eq('default name test', l.getname(), USER||'.'||$$PLSQL_UNIT);
$else
		utassert.eq('default name test', l.getname(), USER||'.'||$$PLSQL_UNIT||'.UT_LOGGER_1');
$end
         
exception
	when others then
			
dbms_output.put_line($$PLSQL_UNIT ||':errorstack:'||dbms_utility.format_error_backtrace);
raise;
	end;

	--test logger itself
	PROCEDURE ut_logger_2
	IS
		l Logger;
		o VARCHAR2(32000);
	begin
		l := LogManager.getLogger();
    
		utoutput.save;
		utoutput.extract;
		
    l.log(loglevel.FATAL, NULL,'test message');
		
    o := utoutput.nextline(FALSE);
		utassert.this('message logged "'||o||'"', o like '%test message%');
		utoutput.replace;

		utoutput.save;
		utoutput.extract;
		
    l.entry;
		
    o := utoutput.nextline(FALSE);
		utassert.this('Entry Marker message logged', o like '%ENTRY%');
		utoutput.REPLACE;
		
    utoutput.save;
		utoutput.extract;
		
    l.exit;
		
    o := utoutput.nextline(FALSE);
		utassert.this('Exit Marker message logged', o LIKE '%EXIT%');
		utoutput.REPLACE;
    

	END;
  
     PROCEDURE ut_logger_3
	is
		l Logger;
    n NUMBER;
    v VARCHAR2(20);
    b BOOLEAN;
    d DATE;
    ts TIMESTAMP;
    tsz TIMESTAMP WITH TIME ZONE;
	BEGIN
  	l := LogManager.getLogger();
    
    n := 5.23422342;
    	utassert.eq('exit(number)', l.exit(n), n );

    v := 'my return value';
    	utassert.eq('exit(varchar2)', l.exit(v), v );

    d := SYSDATE;
    	utassert.eq('exit(date)', l.exit(d), d );

    b := false;
    	utassert.eq('exit(boolean)', l.exit(b), b );

    ts := SYSTIMESTAMP;
    	utassert.eq('exit(timestamp)', to_char(l.exit(ts)), to_char(ts) );

    tsz := SYSTIMESTAMP;
    utassert.eq('exit(timstamp tz)', to_char(l.exit(tsz)), to_char(tsz) );
    
  end;

end ut_logger;
/
show errors

