CREATE OR REPLACE TYPE logger 
AUTHID current_user
AS OBJECT
(
	m_name varchar2(255),
	m_lvl number,

	map MEMBER FUNCTION Compare RETURN NUMBER 
	-----
	--methods are list in alphabetical order (more or less)

	,MEMBER PROCEDURE catching(lvl LogLevel, throwable GenericException DEFAULT GenericException() )
	,MEMBER PROCEDURE catching(throwable GenericException DEFAULT GenericException() )

	,MEMBER PROCEDURE debug(m Marker, msg Message)
	,MEMBER PROCEDURE debug(m Marker, msg Message, throwable GenericException)
	,MEMBER PROCEDURE debug(m Marker, msg VARCHAR2)
	,MEMBER PROCEDURE debug(m Marker, msg VARCHAR2, throwable GenericException)

	,MEMBER PROCEDURE debug(msg Message)
	,MEMBER PROCEDURE debug(msg Message, throwable GenericException)
	,MEMBER PROCEDURE debug(msg VARCHAR2)
	,MEMBER PROCEDURE debug(msg VARCHAR2, throwable GenericException)

	,MEMBER PROCEDURE entry

	,MEMBER PROCEDURE error(m Marker, msg Message)
	,MEMBER PROCEDURE error(m Marker, msg Message, throwable GenericException)
	,MEMBER PROCEDURE error(m Marker, msg VARCHAR2)
	,MEMBER PROCEDURE error(m Marker, msg VARCHAR2, throwable GenericException)

	,MEMBER PROCEDURE error(msg Message)
	,MEMBER PROCEDURE error(msg Message, throwable GenericException)
	,MEMBER PROCEDURE error(msg VARCHAR2)
	,MEMBER PROCEDURE error(msg VARCHAR2, throwable GenericException)

	,MEMBER PROCEDURE exit
	--,MEMBER FUNCTION exit(result R) return R
	--sql overloads
	,MEMBER FUNCTION  exit(result VARCHAR2) return VARCHAR2
	,MEMBER FUNCTION  exit(result NUMBER) return NUMBER
	,MEMBER FUNCTION  exit(result DATE) return DATE
	--,MEMBER FUNCTION  exit(result BINARY_FLOAT) return BINARY_FLOAT
	--,MEMBER FUNCTION  exit(result BINARY_DOUBLE) return BINARY_DOUBLE
	,MEMBER FUNCTION  exit(result TIMESTAMP ) return TIMESTAMP 
	,MEMBER FUNCTION  exit(result TIMESTAMP WITH TIME ZONE) return TIMESTAMP WITH TIME ZONE
	--,MEMBER FUNCTION  exit(result INTERVAL YEAR TO MONTH ) return INTERVAL YEAR TO MONTH
	--,MEMBER FUNCTION  exit(result INTERVAL DAY TO SECOND ) return INTERVAL DAY TO SECOND
	--,MEMBER FUNCTION  exit(result RAW) return RAW
	--,MEMBER FUNCTION  exit(result BFILE) return BFILE
	--pl/sql overloads
	,MEMBER FUNCTION  exit(result BOOLEAN) return BOOLEAN
	,MEMBER FUNCTION  exit(result log4_object) return log4_object

	,MEMBER PROCEDURE fatal(m Marker, msg Message)
	,MEMBER PROCEDURE fatal(m Marker, msg Message, throwable GenericException)
	,MEMBER PROCEDURE fatal(m Marker, msg VARCHAR2)
	,MEMBER PROCEDURE fatal(m Marker, msg VARCHAR2, throwable GenericException)

	,MEMBER PROCEDURE fatal(msg Message)
	,MEMBER PROCEDURE fatal(msg Message, throwable GenericException)
	,MEMBER PROCEDURE fatal(msg VARCHAR2)
	,MEMBER PROCEDURE fatal(msg VARCHAR2, throwable GenericException)

	,MEMBER FUNCTION  getLevel RETURN LogLevel
	--,MEMBER FUNCTION getMessageFactory() RETURN MessageFactory
	,MEMBER FUNCTION  getName return VARCHAR2

	,MEMBER PROCEDURE info (m Marker, msg Message)
	,MEMBER PROCEDURE info (m Marker, msg Message, throwable GenericException)
	,MEMBER PROCEDURE info (m Marker, msg VARCHAR2)
	,MEMBER PROCEDURE info (m Marker, msg VARCHAR2, throwable GenericException)

	,MEMBER PROCEDURE info (msg Message)
	,MEMBER PROCEDURE info (msg Message, throwable GenericException)
	,MEMBER PROCEDURE info (msg VARCHAR2)
	,MEMBER PROCEDURE info (msg VARCHAR2, throwable GenericException)

	,MEMBER FUNCTION  isEnabled(lvl LogLevel) return BOOLEAN
	,MEMBER FUNCTION  isEnabled(lvl LogLevel, marker Marker) return BOOLEAN

	,MEMBER FUNCTION  isTraceEnabled return BOOLEAN
	,MEMBER FUNCTION  isTraceEnabled(marker Marker) return BOOLEAN

	,MEMBER FUNCTION  isDebugEnabled return BOOLEAN
	,MEMBER FUNCTION  isDebugEnabled(marker Marker) return BOOLEAN

	,MEMBER FUNCTION  isInfoEnabled  return BOOLEAN
	,MEMBER FUNCTION  isInfoEnabled(marker Marker)  return BOOLEAN

	,MEMBER FUNCTION  isWarnEnabled  return BOOLEAN
	,MEMBER FUNCTION  isWarnEnabled(marker Marker)  return BOOLEAN

	,MEMBER FUNCTION  isErrorEnabled return BOOLEAN
	,MEMBER FUNCTION  isErrorEnabled(marker Marker) return BOOLEAN

	,MEMBER FUNCTION  isFatalEnabled return BOOLEAN
	,MEMBER FUNCTION  isFatalEnabled(marker Marker) return BOOLEAN

	,MEMBER PROCEDURE log(lvl LogLevel, marker Marker, msg Message)
	,MEMBER PROCEDURE log(lvl LogLevel, marker Marker, msg Message, throwable GenericException)
	,MEMBER PROCEDURE log(lvl LogLevel, marker Marker, msg VARCHAR2)
	,MEMBER PROCEDURE log(lvl LogLevel, marker Marker, msg VARCHAR2, throwable GenericException)
	,MEMBER PROCEDURE log(lvl LogLevel, msg Message)
	,MEMBER PROCEDURE log(lvl LogLevel, msg Message, throwable GenericException)
	,MEMBER PROCEDURE log(lvl LogLevel, msg VARCHAR2)
	,MEMBER PROCEDURE log(lvl LogLevel, msg VARCHAR2, throwable GenericException)

	--,MEMBER FUNCTION  throwing(lvl LogLevel, t GenericException) return GenericException
	--,MEMBER FUNCTION  throwing(t GenericException) return GenericException

	,MEMBER PROCEDURE trace(m Marker, msg Message)
	,MEMBER PROCEDURE trace(m Marker, msg Message, throwable GenericException)
	,MEMBER PROCEDURE trace(m Marker, msg VARCHAR2)
	,MEMBER PROCEDURE trace(m Marker, msg VARCHAR2, throwable GenericException)

	,MEMBER PROCEDURE trace(msg Message)
	,MEMBER PROCEDURE trace(msg Message, throwable GenericException)
	,MEMBER PROCEDURE trace(msg VARCHAR2)
	,MEMBER PROCEDURE trace(msg VARCHAR2, throwable GenericException)

	,MEMBER PROCEDURE warn (m Marker, msg Message)
	,MEMBER PROCEDURE warn (m Marker, msg Message, throwable GenericException)
	,MEMBER PROCEDURE warn (m Marker, msg VARCHAR2)
	,MEMBER PROCEDURE warn (m Marker, msg VARCHAR2, throwable GenericException)

	,MEMBER PROCEDURE warn (msg Message)
	,MEMBER PROCEDURE warn (msg Message, throwable GenericException)
	,MEMBER PROCEDURE warn (msg VARCHAR2)
	,MEMBER PROCEDURE warn (msg VARCHAR2, throwable GenericException)

	--parameterisedmessage overloads
	--TODO: there must be a better way then this

	,MEMBER PROCEDURE entry(               arg01 VARCHAR2 , arg02 VARCHAR2 DEFAULT NULL , arg03 VARCHAR2 DEFAULT NULL , arg04 VARCHAR2 DEFAULT NULL , arg05 VARCHAR2 DEFAULT NULL , arg06 VARCHAR2 DEFAULT NULL , arg07 VARCHAR2 DEFAULT NULL , arg08 VARCHAR2 DEFAULT NULL , arg09 VARCHAR2 DEFAULT NULL) 

	,MEMBER PROCEDURE trace(msg VARCHAR2 , arg01 VARCHAR2 , arg02 VARCHAR2 DEFAULT NULL , arg03 VARCHAR2 DEFAULT NULL , arg04 VARCHAR2 DEFAULT NULL , arg05 VARCHAR2 DEFAULT NULL , arg06 VARCHAR2 DEFAULT NULL , arg07 VARCHAR2 DEFAULT NULL , arg08 VARCHAR2 DEFAULT NULL , arg09 VARCHAR2 DEFAULT NULL) 
	,MEMBER PROCEDURE debug(msg VARCHAR2 , arg01 VARCHAR2 , arg02 VARCHAR2 DEFAULT NULL , arg03 VARCHAR2 DEFAULT NULL , arg04 VARCHAR2 DEFAULT NULL , arg05 VARCHAR2 DEFAULT NULL , arg06 VARCHAR2 DEFAULT NULL , arg07 VARCHAR2 DEFAULT NULL , arg08 VARCHAR2 DEFAULT NULL , arg09 VARCHAR2 DEFAULT NULL) 
	,MEMBER PROCEDURE  info(msg VARCHAR2 , arg01 VARCHAR2 , arg02 VARCHAR2 DEFAULT NULL , arg03 VARCHAR2 DEFAULT NULL , arg04 VARCHAR2 DEFAULT NULL , arg05 VARCHAR2 DEFAULT NULL , arg06 VARCHAR2 DEFAULT NULL , arg07 VARCHAR2 DEFAULT NULL , arg08 VARCHAR2 DEFAULT NULL , arg09 VARCHAR2 DEFAULT NULL) 
	,MEMBER PROCEDURE  warn(msg VARCHAR2 , arg01 VARCHAR2 , arg02 VARCHAR2 DEFAULT NULL , arg03 VARCHAR2 DEFAULT NULL , arg04 VARCHAR2 DEFAULT NULL , arg05 VARCHAR2 DEFAULT NULL , arg06 VARCHAR2 DEFAULT NULL , arg07 VARCHAR2 DEFAULT NULL , arg08 VARCHAR2 DEFAULT NULL , arg09 VARCHAR2 DEFAULT NULL) 
	,MEMBER PROCEDURE error(msg VARCHAR2 , arg01 VARCHAR2 , arg02 VARCHAR2 DEFAULT NULL , arg03 VARCHAR2 DEFAULT NULL , arg04 VARCHAR2 DEFAULT NULL , arg05 VARCHAR2 DEFAULT NULL , arg06 VARCHAR2 DEFAULT NULL , arg07 VARCHAR2 DEFAULT NULL , arg08 VARCHAR2 DEFAULT NULL , arg09 VARCHAR2 DEFAULT NULL) 
	,MEMBER PROCEDURE fatal(msg VARCHAR2 , arg01 VARCHAR2 , arg02 VARCHAR2 DEFAULT NULL , arg03 VARCHAR2 DEFAULT NULL , arg04 VARCHAR2 DEFAULT NULL , arg05 VARCHAR2 DEFAULT NULL , arg06 VARCHAR2 DEFAULT NULL , arg07 VARCHAR2 DEFAULT NULL , arg08 VARCHAR2 DEFAULT NULL , arg09 VARCHAR2 DEFAULT NULL) 

	,MEMBER PROCEDURE printf(lvl LogLevel, mkr Marker, format VARCHAR2 , arg01 VARCHAR2 , arg02 VARCHAR2 DEFAULT NULL , arg03 VARCHAR2 DEFAULT NULL , arg04 VARCHAR2 DEFAULT NULL , arg05 VARCHAR2 DEFAULT NULL , arg06 VARCHAR2 DEFAULT NULL , arg07 VARCHAR2 DEFAULT NULL , arg08 VARCHAR2 DEFAULT NULL , arg09 VARCHAR2 DEFAULT NULL) 
	,MEMBER PROCEDURE printf(lvl LogLevel            , format VARCHAR2 , arg01 VARCHAR2 , arg02 VARCHAR2 DEFAULT NULL , arg03 VARCHAR2 DEFAULT NULL , arg04 VARCHAR2 DEFAULT NULL , arg05 VARCHAR2 DEFAULT NULL , arg06 VARCHAR2 DEFAULT NULL , arg07 VARCHAR2 DEFAULT NULL , arg08 VARCHAR2 DEFAULT NULL , arg09 VARCHAR2 DEFAULT NULL) 

) not instantiable not final
;
/
show errors
-- vim: ts=4 sw=4 filetype=sqloracle


