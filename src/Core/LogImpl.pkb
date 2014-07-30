--prompt create or replace package body LogImpl 
create or replace 
package body LogImpl as

TYPE appender_table IS TABLE OF appender;

k_appenders appender_table := appender_table();

k_layout layout;

	function isEnabled(self IN Logger, lvl LogLevel, mkr Marker) return BOOLEAN 
	IS
		rLog_level log_levels%rowtype;
	begin
		rLog_level := get_log_level(self.m_name);
		IF rLog_level.logger_name IS NULL THEN         
			--rLog_level := get_log_level(logmanager.root_logger_name);        
			rLog_level := get_log_level('.');        
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
    le LogEvent;
    m Message := msg;
    ctxmap ThreadContextContextMap := THREADCONTEXT.CLONEMAP();
	begin
    

--this is should now event dispatch to appenders via logger config
IF k_appenders.count > 0 THEN
    IF m IS NULL THEN 
    m := simplemessage('');
    END IF;
    
    --these user env option can change during a session so need to save at time of call.
    ctxmap.put('module'     , SYS_CONTEXT('USERENV', 'MODULE'));
    ctxmap.put('action'     , SYS_CONTEXT('USERENV', 'ACTION'));
    ctxmap.put('client_info', SYS_CONTEXT('USERENV', 'CLIENT_INFO'));

  <<debug_web_variables>>
   BEGIN
      FOR i IN 1 .. OWA.num_cgi_vars
      LOOP
       ctxmap.put(OWA.cgi_var_name (i),OWA.cgi_var_val (i));
      END LOOP;
   EXCEPTION
      WHEN VALUE_ERROR
      THEN
         NULL;
   END debug_web_variables;      
    

   le := Log4oraclelogEvent('test logger',marker,fqcn,lvl,m,t, ctxmap ,THREADCONTEXT.CLONESTACK(),'mythreadname', StackTraceElement(2), SYSTIMESTAMP);
ELSE
   return; --no appenders
END IF;

FOR i IN k_appenders.FIRST .. k_appenders.LAST LOOP
 k_appenders(i).APPEND(le);

end loop;

	END;


BEGIN
	ll_TRACE := LogLevel.TRACE;
	ll_DEBUG := LogLevel.DEBUG;
	ll_INFO  := LogLevel.INFO;
	ll_WARN  := LogLevel.WARN;
	ll_ERROR := LogLevel.ERROR;
	ll_FATAL := LogLevel.FATAL;
	ll_ALL   := LogLevel.ll_ALL;

 	FLOW_MARKER      := MarkerManager.getMarker('FLOW');
	ENTRY_MARKER     := MarkerManager.getMarker('ENTRY',FLOW_MARKER);
	EXIT_MARKER      := MarkerManager.getMarker('EXIT' ,FLOW_MARKER);

	EXCEPTION_MARKER := MarkerManager.getMarker('EXCEPTION');
	CATCHING_MARKER  := MarkerManager.getMarker('CATCHING',EXCEPTION_MARKER);
	THROWING_MARKER  := MarkerManager.getMarker('THROWING',EXCEPTION_MARKER);

--TODO this needs to move to loggercontext
--k_layout := PatternLayout('%date %5level %logger - %marker - %l - %X - %X{batch_id} - %m %ex%n');
k_layout := PatternLayout('%date %5level %logger - %marker - %l - %m %ex%n');
--k_layout := PatternLayout('%date - %5level - %marker - %l - %message %ex');
--k_layout := PatternLayout('%message%newline');
--k_layout := PatternLayout('%r [%t] %-5p %l %x - %m%n');

k_layout.ActivateOptions;

k_appenders.EXTEND;
k_appenders(k_appenders.last) := dbmsOutputAppender('dbmsoutput',null, k_layout, false);

k_appenders.EXTEND;
k_appenders(k_appenders.LAST) := TableAppender('tableoutput',NULL, NULL, FALSE);

--k_appenders.EXTEND;
--k_appenders(k_appenders.LAST) := SMTPAppender('SMTPoutput',ThresholdFilter(LogLevel.ERROR,null,null), k_layout, FALSE);


END;
/
show errors
