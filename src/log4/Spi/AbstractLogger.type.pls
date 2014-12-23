CREATE OR REPLACE TYPE Abstractlogger 
under ExtendedLogger
(

	overriding map MEMBER FUNCTION Compare RETURN NUMBER 
	-----
	--methods are list in alphabetical order (more or less)

	,overriding MEMBER PROCEDURE catching(lvl LogLevel, throwable GenericException DEFAULT GenericException() )
	,overriding MEMBER PROCEDURE catching(throwable GenericException DEFAULT GenericException() )

	,overriding MEMBER PROCEDURE debug(m Marker, msg Message)
	,overriding MEMBER PROCEDURE debug(m Marker, msg Message, throwable GenericException)
	,overriding MEMBER PROCEDURE debug(m Marker, msg VARCHAR2)
	,overriding MEMBER PROCEDURE debug(m Marker, msg VARCHAR2, throwable GenericException)

	,overriding MEMBER PROCEDURE debug(msg Message)
	,overriding MEMBER PROCEDURE debug(msg Message, throwable GenericException)
	,overriding MEMBER PROCEDURE debug(msg VARCHAR2)
	,overriding MEMBER PROCEDURE debug(msg VARCHAR2, throwable GenericException)

	,overriding MEMBER PROCEDURE entry

	,overriding MEMBER PROCEDURE error(m Marker, msg Message)
	,overriding MEMBER PROCEDURE error(m Marker, msg Message, throwable GenericException)
	,overriding MEMBER PROCEDURE error(m Marker, msg VARCHAR2)
	,overriding MEMBER PROCEDURE error(m Marker, msg VARCHAR2, throwable GenericException)

	,overriding MEMBER PROCEDURE error(msg Message)
	,overriding MEMBER PROCEDURE error(msg Message, throwable GenericException)
	,overriding MEMBER PROCEDURE error(msg VARCHAR2)
	,overriding MEMBER PROCEDURE error(msg VARCHAR2, throwable GenericException)

	,overriding MEMBER PROCEDURE exit
	--,overriding MEMBER FUNCTION exit(result R) return R
	--sql overloads
	,overriding MEMBER FUNCTION  exit(result VARCHAR2) return VARCHAR2
	,overriding MEMBER FUNCTION  exit(result NUMBER) return NUMBER
	,overriding MEMBER FUNCTION  exit(result DATE) return DATE
	--,overriding MEMBER FUNCTION  exit(result BINARY_FLOAT) return BINARY_FLOAT
	--,overriding MEMBER FUNCTION  exit(result BINARY_DOUBLE) return BINARY_DOUBLE
	,overriding MEMBER FUNCTION  exit(result TIMESTAMP ) return TIMESTAMP 
	,overriding MEMBER FUNCTION  exit(result TIMESTAMP WITH TIME ZONE) return TIMESTAMP WITH TIME ZONE
	--,overriding MEMBER FUNCTION  exit(result INTERVAL YEAR TO MONTH ) return INTERVAL YEAR TO MONTH
	--,overriding MEMBER FUNCTION  exit(result INTERVAL DAY TO SECOND ) return INTERVAL DAY TO SECOND
	--,overriding MEMBER FUNCTION  exit(result RAW) return RAW
	--,overriding MEMBER FUNCTION  exit(result BFILE) return BFILE
	--pl/sql overloads
	,overriding MEMBER FUNCTION  exit(result BOOLEAN) return BOOLEAN
	,overriding MEMBER FUNCTION  exit(result log4_object) return log4_object

	,overriding MEMBER PROCEDURE fatal(m Marker, msg Message)
	,overriding MEMBER PROCEDURE fatal(m Marker, msg Message, throwable GenericException)
	,overriding MEMBER PROCEDURE fatal(m Marker, msg VARCHAR2)
	,overriding MEMBER PROCEDURE fatal(m Marker, msg VARCHAR2, throwable GenericException)

	,overriding MEMBER PROCEDURE fatal(msg Message)
	,overriding MEMBER PROCEDURE fatal(msg Message, throwable GenericException)
	,overriding MEMBER PROCEDURE fatal(msg VARCHAR2)
	,overriding MEMBER PROCEDURE fatal(msg VARCHAR2, throwable GenericException)

	,overriding MEMBER FUNCTION  getLevel RETURN LogLevel
	--,overriding MEMBER FUNCTION getMessageFactory() RETURN MessageFactory
	,overriding MEMBER FUNCTION  getName return VARCHAR2

	,overriding MEMBER PROCEDURE info (m Marker, msg Message)
	,overriding MEMBER PROCEDURE info (m Marker, msg Message, throwable GenericException)
	,overriding MEMBER PROCEDURE info (m Marker, msg VARCHAR2)
	,overriding MEMBER PROCEDURE info (m Marker, msg VARCHAR2, throwable GenericException)

	,overriding MEMBER PROCEDURE info (msg Message)
	,overriding MEMBER PROCEDURE info (msg Message, throwable GenericException)
	,overriding MEMBER PROCEDURE info (msg VARCHAR2)
	,overriding MEMBER PROCEDURE info (msg VARCHAR2, throwable GenericException)

	,overriding MEMBER FUNCTION  isEnabled(lvl LogLevel) return BOOLEAN
	,overriding MEMBER FUNCTION  isEnabled(lvl LogLevel, marker Marker) return BOOLEAN

	,overriding MEMBER FUNCTION  isTraceEnabled return BOOLEAN
	,overriding MEMBER FUNCTION  isTraceEnabled(marker Marker) return BOOLEAN

	,overriding MEMBER FUNCTION  isDebugEnabled return BOOLEAN
	,overriding MEMBER FUNCTION  isDebugEnabled(marker Marker) return BOOLEAN

	,overriding MEMBER FUNCTION  isInfoEnabled  return BOOLEAN
	,overriding MEMBER FUNCTION  isInfoEnabled(marker Marker)  return BOOLEAN

	,overriding MEMBER FUNCTION  isWarnEnabled  return BOOLEAN
	,overriding MEMBER FUNCTION  isWarnEnabled(marker Marker)  return BOOLEAN

	,overriding MEMBER FUNCTION  isErrorEnabled return BOOLEAN
	,overriding MEMBER FUNCTION  isErrorEnabled(marker Marker) return BOOLEAN

	,overriding MEMBER FUNCTION  isFatalEnabled return BOOLEAN
	,overriding MEMBER FUNCTION  isFatalEnabled(marker Marker) return BOOLEAN

	,overriding MEMBER PROCEDURE log(lvl LogLevel, marker Marker, msg Message)
	,overriding MEMBER PROCEDURE log(lvl LogLevel, marker Marker, msg Message, throwable GenericException)
	,overriding MEMBER PROCEDURE log(lvl LogLevel, marker Marker, msg VARCHAR2)
	,overriding MEMBER PROCEDURE log(lvl LogLevel, marker Marker, msg VARCHAR2, throwable GenericException)
	,overriding MEMBER PROCEDURE log(lvl LogLevel, msg Message)
	,overriding MEMBER PROCEDURE log(lvl LogLevel, msg Message, throwable GenericException)
	,overriding MEMBER PROCEDURE log(lvl LogLevel, msg VARCHAR2)
	,overriding MEMBER PROCEDURE log(lvl LogLevel, msg VARCHAR2, throwable GenericException)

	--,overriding MEMBER FUNCTION  throwing(lvl LogLevel, t GenericException) return GenericException
	--,overriding MEMBER FUNCTION  throwing(t GenericException) return GenericException

	,overriding MEMBER PROCEDURE trace(m Marker, msg Message)
	,overriding MEMBER PROCEDURE trace(m Marker, msg Message, throwable GenericException)
	,overriding MEMBER PROCEDURE trace(m Marker, msg VARCHAR2)
	,overriding MEMBER PROCEDURE trace(m Marker, msg VARCHAR2, throwable GenericException)

	,overriding MEMBER PROCEDURE trace(msg Message)
	,overriding MEMBER PROCEDURE trace(msg Message, throwable GenericException)
	,overriding MEMBER PROCEDURE trace(msg VARCHAR2)
	,overriding MEMBER PROCEDURE trace(msg VARCHAR2, throwable GenericException)

	,overriding MEMBER PROCEDURE warn (m Marker, msg Message)
	,overriding MEMBER PROCEDURE warn (m Marker, msg Message, throwable GenericException)
	,overriding MEMBER PROCEDURE warn (m Marker, msg VARCHAR2)
	,overriding MEMBER PROCEDURE warn (m Marker, msg VARCHAR2, throwable GenericException)

	,overriding MEMBER PROCEDURE warn (msg Message)
	,overriding MEMBER PROCEDURE warn (msg Message, throwable GenericException)
	,overriding MEMBER PROCEDURE warn (msg VARCHAR2)
	,overriding MEMBER PROCEDURE warn (msg VARCHAR2, throwable GenericException)

	--parameterisedmessage overloads
	--TODO: there must be a better way then this

	,overriding MEMBER PROCEDURE entry(               arg01 VARCHAR2 , arg02 VARCHAR2 DEFAULT NULL , arg03 VARCHAR2 DEFAULT NULL , arg04 VARCHAR2 DEFAULT NULL , arg05 VARCHAR2 DEFAULT NULL , arg06 VARCHAR2 DEFAULT NULL , arg07 VARCHAR2 DEFAULT NULL , arg08 VARCHAR2 DEFAULT NULL , arg09 VARCHAR2 DEFAULT NULL) 

	,overriding MEMBER PROCEDURE trace(msg VARCHAR2 , arg01 VARCHAR2 , arg02 VARCHAR2 DEFAULT NULL , arg03 VARCHAR2 DEFAULT NULL , arg04 VARCHAR2 DEFAULT NULL , arg05 VARCHAR2 DEFAULT NULL , arg06 VARCHAR2 DEFAULT NULL , arg07 VARCHAR2 DEFAULT NULL , arg08 VARCHAR2 DEFAULT NULL , arg09 VARCHAR2 DEFAULT NULL) 
	,overriding MEMBER PROCEDURE debug(msg VARCHAR2 , arg01 VARCHAR2 , arg02 VARCHAR2 DEFAULT NULL , arg03 VARCHAR2 DEFAULT NULL , arg04 VARCHAR2 DEFAULT NULL , arg05 VARCHAR2 DEFAULT NULL , arg06 VARCHAR2 DEFAULT NULL , arg07 VARCHAR2 DEFAULT NULL , arg08 VARCHAR2 DEFAULT NULL , arg09 VARCHAR2 DEFAULT NULL) 
	,overriding MEMBER PROCEDURE  info(msg VARCHAR2 , arg01 VARCHAR2 , arg02 VARCHAR2 DEFAULT NULL , arg03 VARCHAR2 DEFAULT NULL , arg04 VARCHAR2 DEFAULT NULL , arg05 VARCHAR2 DEFAULT NULL , arg06 VARCHAR2 DEFAULT NULL , arg07 VARCHAR2 DEFAULT NULL , arg08 VARCHAR2 DEFAULT NULL , arg09 VARCHAR2 DEFAULT NULL) 
	,overriding MEMBER PROCEDURE  warn(msg VARCHAR2 , arg01 VARCHAR2 , arg02 VARCHAR2 DEFAULT NULL , arg03 VARCHAR2 DEFAULT NULL , arg04 VARCHAR2 DEFAULT NULL , arg05 VARCHAR2 DEFAULT NULL , arg06 VARCHAR2 DEFAULT NULL , arg07 VARCHAR2 DEFAULT NULL , arg08 VARCHAR2 DEFAULT NULL , arg09 VARCHAR2 DEFAULT NULL) 
	,overriding MEMBER PROCEDURE error(msg VARCHAR2 , arg01 VARCHAR2 , arg02 VARCHAR2 DEFAULT NULL , arg03 VARCHAR2 DEFAULT NULL , arg04 VARCHAR2 DEFAULT NULL , arg05 VARCHAR2 DEFAULT NULL , arg06 VARCHAR2 DEFAULT NULL , arg07 VARCHAR2 DEFAULT NULL , arg08 VARCHAR2 DEFAULT NULL , arg09 VARCHAR2 DEFAULT NULL) 
	,overriding MEMBER PROCEDURE fatal(msg VARCHAR2 , arg01 VARCHAR2 , arg02 VARCHAR2 DEFAULT NULL , arg03 VARCHAR2 DEFAULT NULL , arg04 VARCHAR2 DEFAULT NULL , arg05 VARCHAR2 DEFAULT NULL , arg06 VARCHAR2 DEFAULT NULL , arg07 VARCHAR2 DEFAULT NULL , arg08 VARCHAR2 DEFAULT NULL , arg09 VARCHAR2 DEFAULT NULL) 

	,overriding MEMBER PROCEDURE printf(lvl LogLevel, mkr Marker, format VARCHAR2 , arg01 VARCHAR2 , arg02 VARCHAR2 DEFAULT NULL , arg03 VARCHAR2 DEFAULT NULL , arg04 VARCHAR2 DEFAULT NULL , arg05 VARCHAR2 DEFAULT NULL , arg06 VARCHAR2 DEFAULT NULL , arg07 VARCHAR2 DEFAULT NULL , arg08 VARCHAR2 DEFAULT NULL , arg09 VARCHAR2 DEFAULT NULL) 
	,overriding MEMBER PROCEDURE printf(lvl LogLevel            , format VARCHAR2 , arg01 VARCHAR2 , arg02 VARCHAR2 DEFAULT NULL , arg03 VARCHAR2 DEFAULT NULL , arg04 VARCHAR2 DEFAULT NULL , arg05 VARCHAR2 DEFAULT NULL , arg06 VARCHAR2 DEFAULT NULL , arg07 VARCHAR2 DEFAULT NULL , arg08 VARCHAR2 DEFAULT NULL , arg09 VARCHAR2 DEFAULT NULL) 

) not instantiable not final
;
/
show errors TYPE AbstractLogger
-- vim: ts=4 sw=4 filetype=sqloracle


