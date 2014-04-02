
--prompt create or replace TYPE Log4oracleLogEvent 

create or replace
TYPE Log4oracleLogEvent 
under LogEvent
(
	m_marker Marker,
	m_level LogLevel,
	m_name  VARCHAR2(200),
	m_fqcn  VARCHAR2(200),
	m_threadname  varchar2(200),
	m_message Message,
	m_timestamp TIMESTAMP WITH TIME ZONE,
  m_ste StackTraceElement,
--MDC
  m_MDC ThreadContextContextMap,
--NDC
  m_NDC ThreadContextContextStack,

	m_throwable GenericException,

constructor function Log4oracleLogEvent(ts timestamp with time zone)  return self as result,
--constructor function Log4oracleLogEvent(loggerName VARCHAR2, mkr Marker, fqcn VARCHAR2, lvl loglevel, msg Message, List<Property> properties, Throwable t) return self as result,
constructor FUNCTION Log4oracleLogEvent(loggerName VARCHAR2, mkr Marker, fqcn VARCHAR2, lvl loglevel, msg Message, t GenericException) RETURN self AS result,
constructor FUNCTION Log4oracleLogEvent(loggerName VARCHAR2, mkr Marker, fqcn VARCHAR2, lvl loglevel, msg Message, t GenericException, mdc ThreadContextContextMap, ndc ThreadContextContextStack,  threadName VARCHAR2, LOCATION StackTraceElement , ts TIMESTAMP WITH TIME ZONE) RETURN self AS result,
--constructor FUNCTION Log4oracleLogEvent(loggerName VARCHAR2, mkr Marker, fqcn VARCHAR2, lvl loglevel, msg Message, t GenericException, Map<String,String> mdc, org.apache.LOGGING.log4j.ThreadContext.ContextStack ndc,  threadName VARCHAR2, LOCATION StackTraceElement , ts TIMESTAMP WITH TIME ZONE) RETURN self AS result


  overriding MEMBER FUNCTION getContextMap RETURN ThreadContextContextMap,
  overriding MEMBER FUNCTION getContextStack RETURN ThreadContextContextStack,

	overriding MEMBER FUNCTION getLoggerName RETURN VARCHAR2,

	overriding member function getMessage return Message,
	overriding member function getMarker return Marker,
	overriding member function getLevel return LogLevel,
	overriding MEMBER FUNCTION getTimestamp RETURN TIMESTAMP WITH TIME ZONE, --was getMilis
	overriding MEMBER FUNCTION getSource RETURN StackTraceElement, 
	overriding member function getThreadName return varchar2,
	overriding member function getThrown return GenericException,
	overriding member function toString return varchar2
)
not final instantiable ;
/
show errors

