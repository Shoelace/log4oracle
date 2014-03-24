--prompt create or replace package body LogImpl 
create or replace 
package body LogImpl as

k_appender appender;
k_appender2 appender;
k_layout layout;

	function isEnabled(self IN Logger, lvl LogLevel, mkr Marker) return BOOLEAN 
	IS
		rLog_level log_levels%rowtype;
	begin
		rLog_level := get_log_level(self.m_name);
		IF rLog_level.logger_name IS NULL THEN         
			rLog_level := get_log_level(logmanager.root_logger_name);        
			if rlog_level.logger_name is null then raise no_data_found; end if;
		END IF;

		--if mkr is not null then
			--return mkr = ENTRY_MARKER or mkr = EXIT_MARKER;
		--end if;
    --    return ll_INFO.intLevel() >= lvl.intLevel();
	return (CASE 
			WHEN lvl = ll_TRACE THEN rLog_level.trace != 0
			WHEN lvl = ll_DEBUG THEN rLog_level.debug != 0
			WHEN lvl = ll_INFO  THEN rLog_level.info != 0
			WHEN lvl = ll_WARN  THEN rLog_level.warn != 0
			WHEN lvl = ll_ERROR THEN rLog_level.error != 0
			WHEN lvl = ll_FATAL THEN rLog_level.fatal != 0
         --ELSE RAISE InvalidLogLevel;     
         ELSE true
    END );

	END;

	procedure log(marker Marker, fqcn varchar2, lvl LogLevel, msg Message, t GenericException default null)
	is
		loc LocationInfo := LocationInfo();
    
    A Appender;
    le LogEvent;
    m Message := msg;
	begin
		log4util.WHO_CALLED_ME( LOC.OWNER, LOC.name, LOC.LINENO, LOC.CALLER_TYPE  ,2);
    
    IF m IS NULL THEN 
    m := simplemessage('');
    end if;

--this is should now event dispatch to appenders via logger config
le := Log4oraclelogEvent('test logger',marker,fqcn,lvl,m,t, NULL,NULL,'mythreadname', StackTraceElement('a','b','c',4), systimestamp);

IF k_appender IS NOT NULL THEN
k_appender.APPEND(le);
end if;
IF k_appender2 IS NOT NULL THEN
k_appender2.APPEND(le);
end if;


	END;


BEGIN
	ll_TRACE := LogLevel.TRACE;
	ll_DEBUG := LogLevel.DEBUG;
	ll_INFO := LogLevel.INFO;
	ll_WARN := LogLevel.WARN;
	ll_ERROR := LogLevel.ERROR;
	ll_FATAL := LogLevel.FATAL;
	ll_ALL := LogLevel.ll_ALL;

  	FLOW_MARKER      := MARKERMANAGER.GETMARKER('FLOW');
	ENTRY_MARKER     := MarkerManager.getMarker('ENTRY',FLOW_MARKER);
	EXIT_MARKER      := MarkerManager.getMarker('EXIT',FLOW_MARKER);

	EXCEPTION_MARKER := MarkerManager.getMarker('EXCEPTION');
	CATCHING_MARKER  := MARKERMANAGER.GETMARKER('CATCHING',EXCEPTION_MARKER);
	THROWING_MARKER  := MarkerManager.getMarker('THROWING',EXCEPTION_MARKER);

--TODO this needs to move to loggercontext
--k_layout := PatternLayout('%date %-5level - %marker - %message%newline');
k_layout := PatternLayout('%r [%t] %-5p %l %x - %m%n');

k_layout.ActivateOptions;
k_appender := dbmsOutputAppender('dbmsoutput',null, k_layout, false);

k_appender2 := TableAppender('dbmsoutput2',NULL, k_layout, FALSE);

END;
/
show errors
