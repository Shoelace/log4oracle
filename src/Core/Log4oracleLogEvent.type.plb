
prompt create or replace TYPE Log4oracleLogEvent 

create or replace
TYPE BODY Log4oracleLogEvent 
AS

constructor function Log4oracleLogEvent(ts timestamp with time zone)  return self as result
is
begin
return;
end;

--constructor function Log4oracleLogEvent(loggerName VARCHAR2, mkr Marker, fqcn VARCHAR2, lvl loglevel, msg Message, List<Property> properties, Throwable t) return self as result,
constructor function Log4oracleLogEvent(loggerName VARCHAR2, mkr Marker, fqcn VARCHAR2, lvl loglevel, msg Message, t GenericException) return self as result
is
begin
	self.m_marker := mkr;
	self.m_message := msg;
	self.m_level := lvl;
	self.m_timestamp := systimestamp;
return;
end;

--constructor function Log4oracleLogEvent(loggerName VARCHAR2, mkr Marker, fqcn VARCHAR2, lvl loglevel, msg Message, t GenericException, Map<String,String> mdc, org.apache.logging.log4j.ThreadContext.ContextStack ndc, String threadName, StackTraceElement location, ts timestamp with time zone) return self as result

	overriding member function toString return varchar2
is
begin
return 'not impletemnted';
end;
	overriding member function getMarker return Marker
is
begin
return m_marker;
end;
	overriding member function getMessage return Message
is
begin
return m_message;
end;
	overriding member function getTimestamp return timestamp with time zone
is
begin
return m_timestamp;
end;

	overriding member function getLevel return LogLevel
is
begin
return m_level;
end;

END;
/
show errors


