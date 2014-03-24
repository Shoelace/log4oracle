
prompt create or replace TYPE Log4oracleLogEvent 

create or replace
TYPE Log4oracleLogEvent 
under LogEvent
(
	m_marker Marker,
	m_level LogLevel,
	m_name  varchar2(200),
	m_message Message,
	m_timestamp timestamp with time zone,
--MDC
--NDC
	m_throwable GenericException,

constructor function Log4oracleLogEvent(ts timestamp with time zone)  return self as result,
--constructor function Log4oracleLogEvent(loggerName VARCHAR2, mkr Marker, fqcn VARCHAR2, lvl loglevel, msg Message, List<Property> properties, Throwable t) return self as result,
constructor function Log4oracleLogEvent(loggerName VARCHAR2, mkr Marker, fqcn VARCHAR2, lvl loglevel, msg Message, t GenericException) return self as result,
--constructor function Log4oracleLogEvent(loggerName VARCHAR2, mkr Marker, fqcn VARCHAR2, lvl loglevel, msg Message, t GenericException, Map<String,String> mdc, org.apache.logging.log4j.ThreadContext.ContextStack ndc, String threadName, StackTraceElement location, ts timestamp with time zone) return self as result


	overriding member function getMessage return Message,
	overriding member function getMarker return Marker,
	overriding member function getLevel return LogLevel,
	overriding member function getTimestamp return timestamp with time zone, --was getMilis
	overriding member function toString return varchar2
)
not final instantiable ;
/
show errors

