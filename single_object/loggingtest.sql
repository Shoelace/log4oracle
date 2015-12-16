declare
--L_LOG LOG4_LOGGER := LOG4MANAGER.GETLOGGER();
L_LOG LOGGER := LOGMANAGER.GETLOGGER();

V_START_TIME timestamp;
v_end_time timestamp;

begin
V_START_TIME := systimestamp;

logmanager.ll_trace_enabled := true;
logmanager.ll_debug_enabled := true;
logmanager.ll_info_enabled := TRUE;
logmanager.ll_warn_enabled := TRUE;
logmanager.ll_error_enabled := TRUE;

L_LOG.entry;
L_LOG.trace('hello world');
L_LOG.debug('hello world');
L_LOG.debug('hello','world');
L_LOG.info('hello world');
L_LOG.info('hello','world');
L_LOG.warn('hello world warn');
L_LOG.error('hello world error');
L_LOG.fatal('hello world fatal');
--L_LOG.log(LogLevel(999),'hello world');

--L_LOG.debug('about to trace all objects');
--for X in (select * from USER_OBJECTS , hemis_students order by OBJECT_NAME, OBJECT_TYPE) LOOP
--dbms_output.put_line('object_name:'||x.object_name||' '||x.object_type);
--end loop;

--for I in 1 .. C LOOP
--L_LOG.trace('object_name:'||I);
--end loop;

L_LOG.exit;

V_end_TIME := systimestamp;
dbms_output.put_line('elapsed:'||(v_end_time-v_start_time) );

END;
/
