create or replace
TYPE BODY TableAppender 
as
	
 --constructor function Appender(name VARCHAR2, filter Filter, layout Layout,ignoreExceptions boolean ) return self as result,
 constructor function TableAppender(name VARCHAR2, filter varchar2, layout Layout,ignoreExceptions boolean ) return self as result
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
ll LogLevel := event.getLevel();
 t GenericException := event.getthrown();
BEGIN

    INSERT INTO log_table (
        	logtimestamp ,
	loggername ,
	loglevel ,
	logmarker,
	loglocation,
	logmessage,
	logthrowable ,
	logstacktrace ,
	logcontext 
    ) VALUES (
    event.getTimestamp(),
    event.getLoggerName(),
    ll.m_name,
		event.getMarker().toString(),
    event.getSource().toString(),
    event.getmessage().getFormattedMessage() ,
		--throwable.toString()
    nvl2(t, t.errorstack, NULL ) ,
    nvl2(t, t.errorbacktrace, NULL ) ,
		nvl2(event.getContextMap(), event.getContextMap().tostring(), NULL)
		--system_info(), --can be static
    ); 
    
	commit;
	END;

end;

/
show errors


