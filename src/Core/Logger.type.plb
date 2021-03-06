CREATE OR REPLACE TYPE BODY logger
AS
	MEMBER FUNCTION getName RETURN VARCHAR2
	IS
	BEGIN
		RETURN m_name;
	END;

	map MEMBER FUNCTION Compare RETURN number 
	IS
	BEGIN
		RETURN m_lvl;
	END;

	MEMBER FUNCTION  getLevel RETURN LogLevel
	IS
	BEGIN
		RETURN null;
	END;


	MEMBER FUNCTION isEnabled(lvl IN LogLevel, marker Marker) RETURN BOOLEAN
	IS
	BEGIN
		RETURN logimpl.isEnabled(self, lvl,marker);
	END;

	MEMBER FUNCTION isEnabled(lvl IN LogLevel) RETURN BOOLEAN IS BEGIN RETURN isEnabled(lvl,NULL); END;

	MEMBER FUNCTION isTraceEnabled RETURN BOOLEAN IS BEGIN RETURN isEnabled(logimpl.ll_TRACE,NULL); END;
	MEMBER FUNCTION isDebugEnabled RETURN BOOLEAN IS BEGIN RETURN isEnabled(logimpl.ll_DEBUG,NULL); END;
	MEMBER FUNCTION isInfoEnabled  RETURN BOOLEAN IS BEGIN RETURN isEnabled(logimpl.ll_INFO ,NULL); END;
	MEMBER FUNCTION isWarnEnabled  RETURN BOOLEAN IS BEGIN RETURN isEnabled(logimpl.ll_WARN ,NULL); END;
	MEMBER FUNCTION isErrorEnabled RETURN BOOLEAN IS BEGIN RETURN isEnabled(logimpl.ll_ERROR,NULL); END;
	MEMBER FUNCTION isFatalEnabled RETURN BOOLEAN IS BEGIN RETURN isEnabled(logimpl.ll_FATAL,NULL); END;

	MEMBER FUNCTION isTraceEnabled(marker Marker) RETURN BOOLEAN IS BEGIN RETURN isEnabled(logimpl.ll_TRACE,marker); END;
	MEMBER FUNCTION isDebugEnabled(marker Marker) RETURN BOOLEAN IS BEGIN RETURN isEnabled(logimpl.ll_DEBUG,marker); END;
	MEMBER FUNCTION isInfoEnabled (marker Marker) RETURN BOOLEAN IS BEGIN RETURN isEnabled(logimpl.ll_INFO ,marker); END;
	MEMBER FUNCTION isWarnEnabled (marker Marker) RETURN BOOLEAN IS BEGIN RETURN isEnabled(logimpl.ll_WARN ,marker); END;
	MEMBER FUNCTION isErrorEnabled(marker Marker) RETURN BOOLEAN IS BEGIN RETURN isEnabled(logimpl.ll_ERROR,marker); END;
	MEMBER FUNCTION isFatalEnabled(marker Marker) RETURN BOOLEAN IS BEGIN RETURN isEnabled(logimpl.ll_FATAL,marker); END;

	MEMBER PROCEDURE log(lvl LogLevel, marker Marker, msg Message)
	IS BEGIN IF isEnabled(lvl,marker) THEN logimpl.log(marker,m_name,lvl,msg); END IF; END;

	MEMBER PROCEDURE log(lvl LogLevel, marker Marker, msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(lvl,marker) THEN logimpl.log(marker,m_name,lvl,msg,throwable); END IF; END;

	MEMBER PROCEDURE log(lvl LogLevel, marker Marker, msg VARCHAR2)
	IS BEGIN IF isEnabled(lvl,marker) THEN logimpl.log(marker,m_name,lvl,MessageFactory.newMessage(msg)); END IF; END;

	MEMBER PROCEDURE log(lvl LogLevel, marker Marker, msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(lvl,marker) THEN logimpl.log(marker,m_name,lvl,MessageFactory.newMessage(msg),throwable); END IF; END;


	MEMBER PROCEDURE log(lvl LogLevel, msg Message)
	IS BEGIN IF isEnabled(lvl,NULL  ) THEN logimpl.log(null  ,m_name,lvl,msg); END IF; END;

	MEMBER PROCEDURE log(lvl LogLevel, msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(lvl,NULL  ) THEN logimpl.log(NULL  ,m_name,lvl,msg,throwable); END IF; END;

	MEMBER PROCEDURE log(lvl LogLevel, msg VARCHAR2)
	IS BEGIN IF isEnabled(lvl,NULL  ) THEN logimpl.log(NULL  ,m_name,lvl,MessageFactory.newMessage(msg)); END IF; END;

	MEMBER PROCEDURE log(lvl LogLevel, msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(lvl,NULL  ) THEN logimpl.log(NULL  ,m_name,lvl,MessageFactory.newMessage(msg),throwable); END IF; END;


--entry

	MEMBER PROCEDURE entry
	IS
	BEGIN
	IF isEnabled(logimpl.ll_TRACE,logimpl.ENTRY_MARKER) THEN
			logimpl.log(logimpl.ENTRY_MARKER,m_name,logimpl.ll_TRACE,NULL);
	END IF;
	END;

--exit

	MEMBER PROCEDURE exit
	IS
	BEGIN
		IF isEnabled(logimpl.ll_TRACE,logimpl.EXIT_MARKER) THEN
			logimpl.log(logimpl.EXIT_MARKER,m_name,logimpl.ll_TRACE,NULL);
		END IF;
	END;

	MEMBER FUNCTION exit(result log4_object) RETURN log4_object
	IS
	BEGIN
		IF isEnabled(logimpl.ll_TRACE,logimpl.EXIT_MARKER) THEN
			IF result is null then
				logimpl.log(logimpl.EXIT_MARKER ,m_name, logimpl.ll_TRACE, MessageFactory.newMessage('exit'));
			ELSE
				logimpl.log(logimpl.EXIT_MARKER ,m_name, logimpl.ll_TRACE, MessageFactory.newMessage('exit with ('||result.tostring||')'));
			END IF;
		END IF;
		RETURN result;
	END;

	MEMBER FUNCTION exit(result VARCHAR2) RETURN VARCHAR2
	IS
	BEGIN
		IF isEnabled(logimpl.ll_TRACE,logimpl.EXIT_MARKER) THEN
			IF result is null then
				logimpl.log(logimpl.EXIT_MARKER ,m_name, logimpl.ll_TRACE, MessageFactory.newMessage('exit'));
			else
				logimpl.log(logimpl.EXIT_MARKER ,m_name, logimpl.ll_TRACE, MessageFactory.newMessage('exit with ('||result||')'));
			END IF;
		END IF;  
		RETURN result;
	END;

	MEMBER FUNCTION exit(result NUMBER) RETURN NUMBER
	IS
	BEGIN
		IF isEnabled(logimpl.ll_TRACE,logimpl.EXIT_MARKER) THEN
			IF result is null then
				logimpl.log(logimpl.EXIT_MARKER ,m_name, logimpl.ll_TRACE, MessageFactory.newMessage('exit'));
			ELSE
				logimpl.log(logimpl.EXIT_MARKER ,m_name, logimpl.ll_TRACE, MessageFactory.newMessage('exit with ('||to_char(result)||')'));
			END IF;
		END IF;  
		RETURN result;
	END;

	MEMBER FUNCTION exit(result DATE) RETURN DATE
	IS
	BEGIN
		IF isEnabled(logimpl.ll_TRACE,logimpl.EXIT_MARKER) THEN
			IF result is null then
				logimpl.log(logimpl.EXIT_MARKER ,m_name, logimpl.ll_TRACE, MessageFactory.newMessage('exit'));
			ELSE
				logimpl.log(logimpl.EXIT_MARKER ,m_name, logimpl.ll_TRACE, MessageFactory.newMessage('exit with ('||TO_CHAR(result)||')'));
			END IF;
		END IF;  
		RETURN result;
	END;

	MEMBER FUNCTION exit(result TIMESTAMP ) RETURN TIMESTAMP 
	IS
	BEGIN
		IF isEnabled(logimpl.ll_TRACE,logimpl.EXIT_MARKER) THEN
			IF result is null then
				logimpl.log(logimpl.EXIT_MARKER ,m_name, logimpl.ll_TRACE, MessageFactory.newMessage('exit'));
			ELSE
				logimpl.log(logimpl.EXIT_MARKER ,m_name, logimpl.ll_TRACE, MessageFactory.newMessage('exit with ('||TO_CHAR(result)||')'));
			END IF;
		END IF;    
		RETURN result;
	END;

	MEMBER FUNCTION exit(result TIMESTAMP WITH TIME ZONE) RETURN TIMESTAMP WITH TIME ZONE
	IS
	BEGIN
		IF isEnabled(logimpl.ll_TRACE,logimpl.EXIT_MARKER) THEN
			IF result is null then
				logimpl.log(logimpl.EXIT_MARKER ,m_name, logimpl.ll_TRACE, MessageFactory.newMessage('exit'));
			ELSE
				logimpl.log(logimpl.EXIT_MARKER ,m_name, logimpl.ll_TRACE, MessageFactory.newMessage('exit with ('||TO_CHAR(result)||')'));
			END IF;
		END IF;    
		RETURN result;
	END;

	MEMBER FUNCTION exit(result BOOLEAN) RETURN BOOLEAN
	IS
	BEGIN
		IF isEnabled(logimpl.ll_TRACE,logimpl.EXIT_MARKER) THEN
			IF result IS NULL THEN
				logimpl.LOG(logimpl.EXIT_MARKER ,m_name, logimpl.ll_TRACE, MessageFactory.newMessage('exit with (NULL)'));
			elsif result then
				logimpl.LOG(logimpl.EXIT_MARKER ,m_name, logimpl.ll_TRACE, MessageFactory.newMessage('exit with (TRUE)'));
	  else
				logimpl.log(logimpl.EXIT_MARKER ,m_name, logimpl.ll_TRACE, MessageFactory.newMessage('exit with (FALSE)'));
			END IF;
		END IF;  
		RETURN result;
	END;

  --debug
	MEMBER PROCEDURE debug(m Marker,msg Message)
	IS BEGIN IF isEnabled(logimpl.ll_DEBUG,m) THEN logimpl.log(m, m_name, logimpl.ll_DEBUG,msg); END IF; END;

	MEMBER PROCEDURE debug(m Marker,msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(logimpl.ll_DEBUG,m) THEN logimpl.log(m, m_name, logimpl.ll_DEBUG,msg,throwable); END IF; END;

	MEMBER PROCEDURE debug(m Marker,msg VARCHAR2)
	IS BEGIN IF isEnabled(logimpl.ll_DEBUG,m) THEN logimpl.log(m, m_name, logimpl.ll_DEBUG,MessageFactory.newMessage(msg)); END IF; END;

	MEMBER PROCEDURE debug(m Marker,msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(logimpl.ll_DEBUG,m) THEN logimpl.log(m, m_name, logimpl.ll_DEBUG,MessageFactory.newMessage(msg),throwable); END IF; END;


	MEMBER PROCEDURE debug(msg Message)
	IS BEGIN IF isEnabled(logimpl.ll_DEBUG,NULL) THEN logimpl.log(NULL, m_name, logimpl.ll_DEBUG,msg); END IF; END;

	MEMBER PROCEDURE debug(msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(logimpl.ll_DEBUG,NULL) THEN logimpl.log(NULL, m_name, logimpl.ll_DEBUG,msg,throwable); END IF; END;  

	MEMBER PROCEDURE debug(msg VARCHAR2)
	IS BEGIN IF isEnabled(logimpl.ll_DEBUG,NULL) THEN logimpl.log(NULL, m_name, logimpl.ll_DEBUG,MessageFactory.newMessage(msg)); END IF; END;

	MEMBER PROCEDURE debug(msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(logimpl.ll_DEBUG,NULL) THEN logimpl.log(NULL, m_name, logimpl.ll_DEBUG,MessageFactory.newMessage(msg),throwable); END IF; END;  


--error
	MEMBER PROCEDURE error(m Marker, msg Message)
	IS BEGIN IF isEnabled(logimpl.ll_ERROR,m)    THEN logimpl.log(m   ,m_name,logimpl.ll_ERROR,msg); END IF; END;

	MEMBER PROCEDURE error(m Marker, msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(logimpl.ll_ERROR,m)    THEN logimpl.log(m   ,m_name,logimpl.ll_ERROR,msg,throwable); END IF; END;  

	MEMBER PROCEDURE error(m Marker, msg VARCHAR2)
	IS BEGIN IF isEnabled(logimpl.ll_ERROR,m)    THEN logimpl.log(m   ,m_name,logimpl.ll_ERROR,MessageFactory.newMessage(msg)); END IF; END;

	MEMBER PROCEDURE error(m Marker, msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(logimpl.ll_ERROR,m   ) THEN logimpl.log(m   ,m_name,logimpl.ll_ERROR,MessageFactory.newMessage(msg),throwable); END IF; END;  


	MEMBER PROCEDURE error(msg Message)
	IS BEGIN IF isEnabled(logimpl.ll_ERROR,NULL) THEN logimpl.log(NULL,m_name,logimpl.ll_ERROR,msg); END IF; END;

	MEMBER PROCEDURE error(msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(logimpl.ll_ERROR,NULL) THEN logimpl.log(NULL,m_name,logimpl.ll_ERROR,msg,throwable); END IF; END;  

	MEMBER PROCEDURE error(msg VARCHAR2)
	IS BEGIN IF isEnabled(logimpl.ll_ERROR,NULL) THEN logimpl.log(NULL,m_name,logimpl.ll_ERROR,MessageFactory.newMessage(msg)); END IF; END;

	MEMBER PROCEDURE error(msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(logimpl.ll_ERROR,NULL) THEN logimpl.log(NULL,m_name,logimpl.ll_ERROR,MessageFactory.newMessage(msg),throwable); END IF; END;  

  --info

	MEMBER PROCEDURE info(m Marker, msg Message)
	IS BEGIN IF isEnabled(logimpl.ll_INFO,m   ) THEN logimpl.log(m   , m_name, logimpl.ll_INFO,msg); END IF; END;

	MEMBER PROCEDURE info(m Marker, msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(logimpl.ll_INFO,m   ) THEN logimpl.log(m   , m_name, logimpl.ll_INFO,msg, throwable); END IF; END;

	MEMBER PROCEDURE info(m Marker, msg VARCHAR2)
	IS BEGIN IF isEnabled(logimpl.ll_INFO,m   ) THEN logimpl.log(m   , m_name, logimpl.ll_INFO,MessageFactory.newMessage(msg)); END IF; END;

	MEMBER PROCEDURE info(m Marker, msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(logimpl.ll_INFO,m   ) THEN logimpl.log(m   , m_name, logimpl.ll_INFO,MessageFactory.newMessage(msg),throwable); END IF; END;


	MEMBER PROCEDURE info(msg Message)
	IS BEGIN IF isEnabled(logimpl.ll_INFO,NULL) THEN logimpl.log(NULL, m_name, logimpl.ll_INFO,msg); END IF; END;

	MEMBER PROCEDURE info(msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(logimpl.ll_INFO,NULL) THEN logimpl.log(NULL, m_name, logimpl.ll_INFO,msg, throwable); END IF; END;

	MEMBER PROCEDURE info(msg VARCHAR2)
	IS BEGIN IF isEnabled(logimpl.ll_INFO,NULL) THEN logimpl.log(NULL, m_name, logimpl.ll_INFO,MessageFactory.newMessage(msg)); END IF; END;

	MEMBER PROCEDURE info(msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(logimpl.ll_INFO,NULL) THEN logimpl.log(NULL, m_name, logimpl.ll_INFO,MessageFactory.newMessage(msg),throwable); END IF; END;

--warn
	MEMBER PROCEDURE warn(m Marker, msg Message)
	IS BEGIN IF isEnabled(logimpl.ll_WARN,m   ) THEN logimpl.log(m   ,m_name,logimpl.ll_WARN,msg); END IF; END;

	MEMBER PROCEDURE warn(m Marker, msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(logimpl.ll_WARN,m   ) THEN logimpl.log(m   ,m_name,logimpl.ll_WARN,msg,throwable); END IF; END;

	MEMBER PROCEDURE warn(m Marker, msg VARCHAR2)
	IS BEGIN IF isEnabled(logimpl.ll_WARN,m   ) THEN logimpl.log(m   ,m_name,logimpl.ll_WARN,MessageFactory.newMessage(msg)); END IF; END;

	MEMBER PROCEDURE warn(m Marker, msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(logimpl.ll_WARN,m   ) THEN logimpl.log(m   ,m_name,logimpl.ll_WARN,MessageFactory.newMessage(msg),throwable); END IF; END;


	MEMBER PROCEDURE warn(msg Message)
	IS BEGIN IF isEnabled(logimpl.ll_WARN,NULL) THEN logimpl.log(NULL,m_name,logimpl.ll_WARN,msg); END IF; END;

	MEMBER PROCEDURE warn(msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(logimpl.ll_WARN,NULL) THEN logimpl.log(NULL,m_name,logimpl.ll_WARN,msg,throwable); END IF; END;

	MEMBER PROCEDURE warn(msg VARCHAR2)
	IS BEGIN IF isEnabled(logimpl.ll_WARN,NULL) THEN logimpl.log(NULL,m_name,logimpl.ll_WARN,MessageFactory.newMessage(msg)); END IF; END;

	MEMBER PROCEDURE warn(msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(logimpl.ll_WARN,NULL) THEN logimpl.log(NULL,m_name,logimpl.ll_WARN,MessageFactory.newMessage(msg),throwable); END IF; END;


--fatal
	MEMBER PROCEDURE fatal(m Marker, msg Message)
	IS BEGIN IF isEnabled(logimpl.ll_FATAL,m) THEN logimpl.log(m,m_name,logimpl.ll_FATAL,msg); END IF; END;

	MEMBER PROCEDURE fatal(m Marker, msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(logimpl.ll_FATAL,m) THEN logimpl.log(m,m_name,logimpl.ll_FATAL,msg,throwable); END IF; END;  

	MEMBER PROCEDURE fatal(m Marker, msg VARCHAR2)
	IS BEGIN IF isEnabled(logimpl.ll_FATAL,m) THEN logimpl.log(m,m_name,logimpl.ll_FATAL,MessageFactory.newMessage(msg)); END IF; END;

	MEMBER PROCEDURE fatal(m Marker, msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(logimpl.ll_FATAL,m) THEN logimpl.log(m,m_name,logimpl.ll_FATAL,MessageFactory.newMessage(msg),throwable); END IF; END;  


	MEMBER PROCEDURE fatal(msg Message)
	IS BEGIN IF isEnabled(logimpl.ll_FATAL,NULL) THEN logimpl.log(NULL,m_name,logimpl.ll_FATAL,msg); END IF; END;

	MEMBER PROCEDURE fatal(msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(logimpl.ll_FATAL,NULL) THEN logimpl.log(NULL,m_name,logimpl.ll_FATAL,msg,throwable); END IF; END;  

	MEMBER PROCEDURE fatal(msg VARCHAR2)
	IS BEGIN IF isEnabled(logimpl.ll_FATAL,NULL) THEN logimpl.log(NULL,m_name,logimpl.ll_FATAL,MessageFactory.newMessage(msg)); END IF; END;

	MEMBER PROCEDURE fatal(msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(logimpl.ll_FATAL,NULL) THEN logimpl.log(NULL,m_name,logimpl.ll_FATAL,MessageFactory.newMessage(msg),throwable); END IF; END;  

--trace

	MEMBER PROCEDURE trace(m Marker, msg Message)
	IS BEGIN IF isEnabled(logimpl.ll_TRACE,m   ) THEN logimpl.log(m   ,m_name,logimpl.ll_TRACE,msg); END IF; END;

	MEMBER PROCEDURE trace(m Marker, msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(logimpl.ll_TRACE,m   ) THEN logimpl.log(m   ,m_name,logimpl.ll_TRACE,msg,throwable); END IF; END;  

	MEMBER PROCEDURE trace(m Marker, msg VARCHAR2)
	IS BEGIN IF isEnabled(logimpl.ll_TRACE,m   ) THEN logimpl.log(m   ,m_name,logimpl.ll_TRACE,MessageFactory.newMessage(msg)); END IF; END;

	MEMBER PROCEDURE trace(m Marker, msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(logimpl.ll_TRACE,m   ) THEN logimpl.log(m   ,m_name,logimpl.ll_TRACE,MessageFactory.newMessage(msg),throwable); END IF; END;  


	MEMBER PROCEDURE trace(msg Message)
	IS BEGIN IF isEnabled(logimpl.ll_TRACE,NULL) THEN logimpl.log(NULL,m_name,logimpl.ll_TRACE,msg); END IF; END;

	MEMBER PROCEDURE trace(msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(logimpl.ll_TRACE,NULL) THEN logimpl.log(NULL,m_name,logimpl.ll_TRACE,msg,throwable); END IF; END;  

	MEMBER PROCEDURE trace(msg VARCHAR2)
	IS BEGIN IF isEnabled(logimpl.ll_TRACE,NULL) THEN logimpl.log(NULL,m_name,logimpl.ll_TRACE,MessageFactory.newMessage(msg)); END IF; END;

	MEMBER PROCEDURE trace(msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(logimpl.ll_TRACE,NULL) THEN logimpl.log(NULL,m_name,logimpl.ll_TRACE,MessageFactory.newMessage(msg),throwable); END IF; END;  


--catching
	MEMBER PROCEDURE catching(throwable GenericException DEFAULT GenericException() )
	IS
	BEGIN
		IF isEnabled(logimpl.ll_ERROR,logimpl.CATCHING_MARKER) THEN
			logimpl.log(logimpl.CATCHING_MARKER, m_name, logimpl.ll_ERROR,MessageFactory.newMessage('catching'),throwable);
		END IF;
	END;

	MEMBER PROCEDURE catching(lvl LogLevel, throwable GenericException DEFAULT GenericException() )
	IS
	BEGIN
		IF isEnabled(lvl,logimpl.CATCHING_MARKER) THEN
			logimpl.log(logimpl.CATCHING_MARKER, m_name, lvl,MessageFactory.newMessage('catching'),throwable);
		END IF;
	END;


--parameterised stuff
	MEMBER PROCEDURE trace(msg VARCHAR2
						, arg01 VARCHAR2
						, arg02 VARCHAR2 DEFAULT NULL
						, arg03 VARCHAR2 DEFAULT NULL
						, arg04 VARCHAR2 DEFAULT NULL
						, arg05 VARCHAR2 DEFAULT NULL
						, arg06 VARCHAR2 DEFAULT NULL
						, arg07 VARCHAR2 DEFAULT NULL
						, arg08 VARCHAR2 DEFAULT NULL
						, arg09 VARCHAR2 DEFAULT NULL
						)
	IS
	prms log4_array;
	BEGIN
	  IF isEnabled(logimpl.ll_TRACE,NULL) THEN
			prms := log4_array(log4_sql_object(arg01),log4_sql_object(arg02),log4_sql_object(arg03),log4_sql_object(arg04),log4_sql_object(arg05),log4_sql_object(arg06),log4_sql_object(arg07),log4_sql_object(arg08),log4_sql_object(arg09) );
			logimpl.LOG(NULL, m_name, logimpl.ll_TRACE,MessageFactory.newMessage(msg, prms));
		END IF;  
	END;



	MEMBER PROCEDURE debug(msg VARCHAR2
						, arg01 VARCHAR2
						, arg02 VARCHAR2 DEFAULT NULL
						, arg03 VARCHAR2 DEFAULT NULL
						, arg04 VARCHAR2 DEFAULT NULL
						, arg05 VARCHAR2 DEFAULT NULL
						, arg06 VARCHAR2 DEFAULT NULL
						, arg07 VARCHAR2 DEFAULT NULL
						, arg08 VARCHAR2 DEFAULT NULL
						, arg09 VARCHAR2 DEFAULT NULL
						)
	IS
	prms log4_array;
	BEGIN
	  IF isEnabled(logimpl.ll_DEBUG,NULL) THEN
	  prms := log4_array(log4_sql_object(arg01),log4_sql_object(arg02),log4_sql_object(arg03),log4_sql_object(arg04),log4_sql_object(arg05),log4_sql_object(arg06),log4_sql_object(arg07),log4_sql_object(arg08),log4_sql_object(arg09) );
			logimpl.LOG(NULL, m_name, logimpl.ll_DEBUG,MessageFactory.newMessage(msg, prms));
	  end if;  
	END;

	MEMBER PROCEDURE  info(msg VARCHAR2
						, arg01 VARCHAR2
						, arg02 VARCHAR2 DEFAULT NULL
						, arg03 VARCHAR2 DEFAULT NULL
						, arg04 VARCHAR2 DEFAULT NULL
						, arg05 VARCHAR2 DEFAULT NULL
						, arg06 VARCHAR2 DEFAULT NULL
						, arg07 VARCHAR2 DEFAULT NULL
						, arg08 VARCHAR2 DEFAULT NULL
						, arg09 VARCHAR2 DEFAULT NULL
						)
	IS
	prms log4_array;
	BEGIN
	  IF isEnabled(logimpl.ll_INFO,NULL) THEN
	  prms := log4_array(log4_sql_object(arg01),log4_sql_object(arg02),log4_sql_object(arg03),log4_sql_object(arg04),log4_sql_object(arg05),log4_sql_object(arg06),log4_sql_object(arg07),log4_sql_object(arg08),log4_sql_object(arg09) );
			logimpl.LOG(NULL, m_name, logimpl.ll_INFO,MessageFactory.newMessage(msg, prms));
	  end if;  
	END;

	MEMBER PROCEDURE  warn(msg VARCHAR2
						, arg01 VARCHAR2
						, arg02 VARCHAR2 DEFAULT NULL
						, arg03 VARCHAR2 DEFAULT NULL
						, arg04 VARCHAR2 DEFAULT NULL
						, arg05 VARCHAR2 DEFAULT NULL
						, arg06 VARCHAR2 DEFAULT NULL
						, arg07 VARCHAR2 DEFAULT NULL
						, arg08 VARCHAR2 DEFAULT NULL
						, arg09 VARCHAR2 DEFAULT NULL
						)
	IS
	prms log4_array;
	BEGIN
	  IF isEnabled(logimpl.ll_WARN,NULL) THEN
	  prms := log4_array(log4_sql_object(arg01),log4_sql_object(arg02),log4_sql_object(arg03),log4_sql_object(arg04),log4_sql_object(arg05),log4_sql_object(arg06),log4_sql_object(arg07),log4_sql_object(arg08),log4_sql_object(arg09) );
			logimpl.LOG(NULL, m_name, logimpl.ll_WARN,MessageFactory.newMessage(msg, prms));
	  end if;  
	END;


	MEMBER PROCEDURE error(msg VARCHAR2
						, arg01 VARCHAR2
						, arg02 VARCHAR2 DEFAULT NULL
						, arg03 VARCHAR2 DEFAULT NULL
						, arg04 VARCHAR2 DEFAULT NULL
						, arg05 VARCHAR2 DEFAULT NULL
						, arg06 VARCHAR2 DEFAULT NULL
						, arg07 VARCHAR2 DEFAULT NULL
						, arg08 VARCHAR2 DEFAULT NULL
						, arg09 VARCHAR2 DEFAULT NULL
						)
	IS
	prms log4_array;
	BEGIN
	  IF isEnabled(logimpl.ll_ERROR,NULL) THEN
	  prms := log4_array(log4_sql_object(arg01),log4_sql_object(arg02),log4_sql_object(arg03),log4_sql_object(arg04),log4_sql_object(arg05),log4_sql_object(arg06),log4_sql_object(arg07),log4_sql_object(arg08),log4_sql_object(arg09) );
			logimpl.LOG(NULL, m_name, logimpl.ll_ERROR,MessageFactory.newMessage(msg, prms));
	  end if;  
	END;


	MEMBER PROCEDURE fatal(msg VARCHAR2
						, arg01 VARCHAR2
						, arg02 VARCHAR2 DEFAULT NULL
						, arg03 VARCHAR2 DEFAULT NULL
						, arg04 VARCHAR2 DEFAULT NULL
						, arg05 VARCHAR2 DEFAULT NULL
						, arg06 VARCHAR2 DEFAULT NULL
						, arg07 VARCHAR2 DEFAULT NULL
						, arg08 VARCHAR2 DEFAULT NULL
						, arg09 VARCHAR2 DEFAULT NULL
						)
	IS
	prms log4_array;
	BEGIN
	  IF isEnabled(logimpl.ll_FATAL,NULL) THEN
	  prms := log4_array(log4_sql_object(arg01),log4_sql_object(arg02),log4_sql_object(arg03),log4_sql_object(arg04),log4_sql_object(arg05),log4_sql_object(arg06),log4_sql_object(arg07),log4_sql_object(arg08),log4_sql_object(arg09) );
			logimpl.LOG(NULL, m_name, logimpl.ll_FATAL,MessageFactory.newMessage(msg, prms));
	  end if;  
	END;

	MEMBER PROCEDURE entry(
						 arg01 VARCHAR2
						, arg02 VARCHAR2 DEFAULT NULL
						, arg03 VARCHAR2 DEFAULT NULL
						, arg04 VARCHAR2 DEFAULT NULL
						, arg05 VARCHAR2 DEFAULT NULL
						, arg06 VARCHAR2 DEFAULT NULL
						, arg07 VARCHAR2 DEFAULT NULL
						, arg08 VARCHAR2 DEFAULT NULL
						, arg09 VARCHAR2 DEFAULT NULL
						)
	IS
	--prms log4_array;
	BEGIN
null;
	  --IF isEnabled(logimpl.ll_FATAL,NULL) THEN
	  --prms := log4_array(log4_sql_object(arg01),log4_sql_object(arg02),log4_sql_object(arg03),log4_sql_object(arg04),log4_sql_object(arg05),log4_sql_object(arg06),log4_sql_object(arg07),log4_sql_object(arg08),log4_sql_object(arg09) );
			--logimpl.LOG(NULL, m_name, logimpl.ll_FATAL,MessageFactory.newMessage(msg, prms));
	  --end if;  
	END;

	MEMBER PROCEDURE printf(lvl LogLevel, mkr Marker, format VARCHAR2 , arg01 VARCHAR2 , arg02 VARCHAR2 DEFAULT NULL , arg03 VARCHAR2 DEFAULT NULL , arg04 VARCHAR2 DEFAULT NULL , arg05 VARCHAR2 DEFAULT NULL , arg06 VARCHAR2 DEFAULT NULL , arg07 VARCHAR2 DEFAULT NULL , arg08 VARCHAR2 DEFAULT NULL , arg09 VARCHAR2 DEFAULT NULL) 
	IS
	prms log4_array;
	BEGIN
	  IF isEnabled(lvl,mkr) THEN
		  prms := log4_array(log4_sql_object(arg01),log4_sql_object(arg02),log4_sql_object(arg03),log4_sql_object(arg04),log4_sql_object(arg05),log4_sql_object(arg06),log4_sql_object(arg07),log4_sql_object(arg08),log4_sql_object(arg09) );
		--	logimpl.LOG(NULL, m_name, logimpl.ll_FATAL,MessageFactory.newMessage(msg, prms));
	  end if;  
	END;
	MEMBER PROCEDURE printf(lvl LogLevel            , format VARCHAR2 , arg01 VARCHAR2 , arg02 VARCHAR2 DEFAULT NULL , arg03 VARCHAR2 DEFAULT NULL , arg04 VARCHAR2 DEFAULT NULL , arg05 VARCHAR2 DEFAULT NULL , arg06 VARCHAR2 DEFAULT NULL , arg07 VARCHAR2 DEFAULT NULL , arg08 VARCHAR2 DEFAULT NULL , arg09 VARCHAR2 DEFAULT NULL) 
	IS
	prms log4_array;
	BEGIN
	  IF isEnabled(lvl,NULL) THEN
		  prms := log4_array(log4_sql_object(arg01),log4_sql_object(arg02),log4_sql_object(arg03),log4_sql_object(arg04),log4_sql_object(arg05),log4_sql_object(arg06),log4_sql_object(arg07),log4_sql_object(arg08),log4_sql_object(arg09) );
		--logimpl.LOG(NULL, m_name, logimpl.ll_FATAL,MessageFactory.newMessage(msg, prms));
	  end if;  
	END;



END;
/
show errors
-- vim: ts=4 sw=4 filetype=sqloracle
