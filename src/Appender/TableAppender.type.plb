prompt create or replace TYPE BODY TableAppender 

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


    INSERT INTO log_table (
        	logtimestamp ,
          loggername ,
          loglevel ,
          logmarker,
          loglocation,
          logmessage,
          loguser,
          logid,
          loggroup,
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
          substr(msg,1,4000) ,
          nvl2(cm, cm.get('os_user'), NULL),
          nvl2(cm, to_number(cm.get('LOG_ID')), NULL),
          nvl2(cm, cm.get('LOGGROUP'), NULL),
          nvl2(t, substr(t.errorstack,1,4000), NULL ) ,
          nvl2(t, substr(t.errorbacktrace,1,4000), NULL ) ,
          nvl2(t, substr(t.callstack,1,4000), NULL ) ,
          nvl2(cm, cm.tostring(), NULL)
    );
    
	COMMIT;
	END append;

END;
/
show errors


