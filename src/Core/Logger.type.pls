CREATE OR REPLACE TYPE logger
AUTHID current_user
AS OBJECT
(
  m_name varchar2(255),
  m_lvl number,
  
	map member function Compare return number 

  
	/* log4x 1.x api */

  ,member procedure trace(msg varchar2)
  --,member procedure trace(msg varchar2, throwable)
  ,MEMBER PROCEDURE DEBUG(msg VARCHAR2)
  ,MEMBER PROCEDURE DEBUG(msg VARCHAR2, throwable GenericException)
  ,member procedure info(msg varchar2)
  --,member procedure info(msg varchar2, throwable)
  ,member procedure warn(msg varchar2)
  --,member procedure warn(msg varchar2, throwable)
  ,MEMBER PROCEDURE ERROR(msg VARCHAR2)
  ,member procedure error(msg varchar2, throwable GenericException)
  ,MEMBER PROCEDURE fatal(msg VARCHAR2)
  ,MEMBER PROCEDURE fatal(msg VARCHAR2, throwable GenericException)
  

  ,member function isTraceEnabled return BOOLEAN
  ,member function isDebugEnabled return BOOLEAN
  ,member function isInfoEnabled  return BOOLEAN
  ,member function isWarnEnabled  return BOOLEAN
  ,member function isErrorEnabled return BOOLEAN
  ,member function isFatalEnabled return BOOLEAN

  ,member function getName return VARCHAR2

/*  removed from 2.x
getlevel
getparent
*/

  ,member procedure log(lvl LogLevel, msg varchar2)
  --,member procedure log(lvl varchar2, MSG varchar2, throwable)
  --,member procedure log(fqcn varchar2,lvl varchar2, MSG varchar2, throwable)

	/* end log4 1.x api */


	/* log4 2.x api */
  ,member procedure catching(throwable GenericException DEFAULT GenericException() )
  ,member procedure catching(lvl LogLevel, throwable GenericException DEFAULT GenericException() )

  ,MEMBER PROCEDURE DEBUG(m Marker, msg VARCHAR2)
  ,member procedure debug(m Marker, msg varchar2, throwable GenericException)

  ,member procedure entry
  --,member procedure entry(params varchar2)

  ,member procedure error(m Marker, msg varchar2)
  --,member procedure error(m varchar2, msg varchar2, throwable)

  ,member procedure exit
--sql overloads
  ,member function exit(result VARCHAR2) return VARCHAR2
  ,member function exit(result NUMBER) return NUMBER
  ,member function exit(result DATE) return DATE
  --,member function exit(result BINARY_FLOAT) return BINARY_FLOAT
  --,member function exit(result BINARY_DOUBLE) return BINARY_DOUBLE
  ,member function exit(result TIMESTAMP ) return TIMESTAMP 
  ,member function exit(result TIMESTAMP WITH TIME ZONE) return TIMESTAMP WITH TIME ZONE
  --,member function exit(result INTERVAL YEAR TO MONTH ) return INTERVAL YEAR TO MONTH
  --,member function exit(result INTERVAL DAY TO SECOND ) return INTERVAL DAY TO SECOND
  --,member function exit(result RAW) return RAW
  --,member function exit(result BFILE) return BFILE
--pl/sql overloads
  ,member function exit(result BOOLEAN) return BOOLEAN
  ,member function exit(result log4_object) return log4_object
  --,member function exit(result R) return R

  ,member procedure fatal(m Marker, msg varchar2)
  --,member procedure fatal(m varchar2, msg varchar2, throwable)

  ,member procedure info(m Marker, msg varchar2)
  --,member procedure info(m varchar2, msg varchar2, throwable)

  ,member function isTraceEnabled(marker Marker) return BOOLEAN
  ,member function isDebugEnabled(marker Marker) return BOOLEAN
  ,member function isInfoEnabled(marker Marker)  return BOOLEAN
  ,member function isWarnEnabled(marker Marker)  return BOOLEAN
  ,member function isErrorEnabled(marker Marker) return BOOLEAN
  ,member function isFatalEnabled(marker Marker) return BOOLEAN

  ,member function isEnabled(lvl LogLevel) return BOOLEAN
  ,member function isEnabled(lvl LogLevel, marker Marker) return BOOLEAN

  ,member procedure log(lvl LogLevel, marker Marker, msg varchar2)
  ,member procedure log(lvl LogLevel, marker Marker, msg varchar2, throwable GenericException)


  --,member function throwing(lvl varchar2, t throwable) return throwable
  --,member function throwing(t throwable) return throwable

  ,member procedure trace(m Marker, msg varchar2)
  --,member procedure trace(m Marker, msg varchar2, throwable)

  ,member procedure warn(m Marker, msg varchar2)
  --,member procedure warn(m Marker, msg varchar2, throwable)

	/* end log4 2.x */
  
  --parameterisedmessage overloads

  ,MEMBER PROCEDURE trace(msg VARCHAR2 , arg01 VARCHAR2 , arg02 VARCHAR2 DEFAULT NULL , arg03 VARCHAR2 DEFAULT NULL , arg04 VARCHAR2 DEFAULT NULL , arg05 VARCHAR2 DEFAULT NULL , arg06 VARCHAR2 DEFAULT NULL , arg07 VARCHAR2 DEFAULT NULL , arg08 VARCHAR2 DEFAULT NULL , arg09 VARCHAR2 DEFAULT NULL) 
  ,MEMBER PROCEDURE debug(msg VARCHAR2 , arg01 VARCHAR2 , arg02 VARCHAR2 DEFAULT NULL , arg03 VARCHAR2 DEFAULT NULL , arg04 VARCHAR2 DEFAULT NULL , arg05 VARCHAR2 DEFAULT NULL , arg06 VARCHAR2 DEFAULT NULL , arg07 VARCHAR2 DEFAULT NULL , arg08 VARCHAR2 DEFAULT NULL , arg09 VARCHAR2 DEFAULT NULL) 
  --,MEMBER PROCEDURE info (msg VARCHAR2 , arg01 VARCHAR2 , arg02 VARCHAR2 DEFAULT NULL , arg03 VARCHAR2 DEFAULT NULL , arg04 VARCHAR2 DEFAULT NULL , arg05 VARCHAR2 DEFAULT NULL , arg06 VARCHAR2 DEFAULT NULL , arg07 VARCHAR2 DEFAULT NULL , arg08 VARCHAR2 DEFAULT NULL , arg09 VARCHAR2 DEFAULT NULL) 

) not instantiable not final
;
/
show errors


