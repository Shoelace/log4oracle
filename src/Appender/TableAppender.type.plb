--prompt create or replace TYPE BODY TableAppender 

create or replace
TYPE BODY TableAppender 
AS

  constructor function TableAppender(name VARCHAR2, filter Filter, layout Layout,ignoreExceptions boolean ) return self as result
	IS
	BEGIN
		self.m_name := name;
		self.m_layout := layout;
		NULL;
		return;
	END;

	overriding member procedure append(event LogEvent) 
	IS
    PRAGMA AUTONOMOUS_TRANSACTION; 
    
    ll    LogLevel := event.getLevel();
    t     GenericException := event.getthrown();
    m     Message := event.GetMessage();
    msg   log_table.logmessage%TYPE := m.getformattedmessage();
    cm    ThreadContextContextMap := event.getContextMap();
  BEGIN

--dbms_output.put_line('USER:'||sys_context('USERENV','CURRENT_USER'));
--dbms_output.put_line('SESSION_USER:'||sys_context('USERENV','SESSION_USER'));


    INSERT INTO log_table (
        	logtimestamp ,
          loggername ,
          loglevel ,
          logmarker,
          loglocation,
          logmessage,
          loguser,
          logid,
          logthrowable ,
          logstacktrace ,
          logcallstack ,
          logcontext 
    ) VALUES (
          event.getTimestamp(),
          event.getLoggerName(),
          ll.m_name,
          event.getMarker().toString(),
          event.getSource().toString(),
          msg ,
        nvl2(cm, cm.get('os_user'), NULL),
        nvl2(cm, to_number(cm.get('LOG_ID')), NULL),
        nvl2(t, t.errorstack, NULL ) ,
        nvl2(t, t.errorbacktrace, NULL ) ,
        nvl2(t, t.callstack, NULL ) ,
	nvl2(cm, cm.tostring(), NULL)
    ); 
    
	COMMIT;
	END append;

END;
/
show errors


