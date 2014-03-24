create or replace
TYPE TableAppender 
under Appender
(
 --constructor function Appender(name VARCHAR2, filter Filter, layout Layout,ignoreExceptions boolean ) return self as result,
 constructor function TableAppender(name VARCHAR2, filter varchar2, layout Layout,ignoreExceptions boolean ) return self as result

	,overriding member procedure append(event LogEvent) 


)
final instantiable ;
/
show errors


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
BEGIN

    INSERT INTO log_table (
        	logtimestamp ,
	loggername ,
	loglevel ,
	logmarker,
	loglocation,
	logmessage,
	logthrowable ,
	logstacktrace 
	--logcontext 
    ) VALUES (
    event.getTimestamp(),
    'fqcn',
        ll.m_name,
		event.getMarker().toString(),
    'loc.toString()',
    --msg,
    event.getmessage().getFormattedMessage() ,
		--throwable.toString()
    '', --throwable.errorstack || throwable.errorbacktrace 
	''--,throwable.callstack
		--session_info(), --mostly static?
		--system_info(), --can be static
    ); 
    
	commit;
	END;

end;

/
show errors


