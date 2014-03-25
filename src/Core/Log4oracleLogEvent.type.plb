--prompt create or replace TYPE Log4oracleLogEvent 

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
	self.m_fqcn := fqcn;
	self.m_marker := mkr;
	self.m_message := msg;
	self.m_level := lvl;
	self.m_timestamp := systimestamp;
return;
end;

constructor FUNCTION Log4oracleLogEvent(loggerName VARCHAR2, mkr Marker, fqcn VARCHAR2, lvl loglevel, msg Message, t GenericException, mdc ThreadContextContextMap, ndc ThreadContextContextStack,  threadName VARCHAR2, LOCATION StackTraceElement , ts TIMESTAMP WITH TIME ZONE) RETURN self AS result
IS
BEGIN
	self.m_fqcn := fqcn;
	self.m_marker := mkr;
	self.m_message := msg;
	self.m_level := lvl;
	self.m_timestamp := SYSTIMESTAMP;
  self.m_ste :=  LOCATION;
  self.m_threadname := threadname;
  self.m_mdc := mdc;
  self.m_ndc := ndc;
return;
END;

--constructor function Log4oracleLogEvent(loggerName VARCHAR2, mkr Marker, fqcn VARCHAR2, lvl loglevel, msg Message, t GenericException, Map<String,String> mdc, org.apache.logging.log4j.ThreadContext.ContextStack ndc, String threadName, StackTraceElement location, ts timestamp with time zone) return self as result

	overriding member function toString return varchar2
is
begin
return 'not implemented';
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
	overriding MEMBER FUNCTION getLoggerName RETURN VARCHAR2
is
begin
return m_fqcn;
end;


	overriding MEMBER FUNCTION getSource RETURN StackTraceElement
  IS
  BEGIN
  RETURN m_ste;
  end;
  overriding MEMBER FUNCTION getThreadName RETURN VARCHAR2
  IS
  begin
  RETURN m_threadname;
  end;

  overriding MEMBER FUNCTION getContextMap RETURN ThreadContextContextMap
  IS
  begin
  RETURN m_MDC;
  END;
  
  overriding MEMBER FUNCTION getContextStack RETURN ThreadContextContextStack
  IS
  BEGIN
  RETURN M_NDC;
  end;

END;
/
show errors


