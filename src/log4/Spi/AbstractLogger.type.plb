
CREATE OR REPLACE TYPE BODY Abstractlogger
AS
	overriding MEMBER FUNCTION getName RETURN VARCHAR2
	IS
	BEGIN
		RETURN m_name;
	END;

	overriding map MEMBER FUNCTION Compare RETURN number 
	IS
	BEGIN
		RETURN m_lvl;
	END;

	overriding MEMBER FUNCTION  getLevel RETURN LogLevel
	IS
	BEGIN
		RETURN null;
	END;


	overriding MEMBER FUNCTION isEnabled(lvl IN LogLevel, marker Marker) RETURN BOOLEAN
	IS
	BEGIN
		RETURN Logger_impl.isEnabled(self, lvl,marker);
	END;

	overriding MEMBER FUNCTION isEnabled(lvl IN LogLevel) RETURN BOOLEAN IS BEGIN RETURN isEnabled(lvl,NULL); END;

	overriding MEMBER FUNCTION isTraceEnabled RETURN BOOLEAN IS BEGIN RETURN isEnabled(Logger_impl.ll_TRACE,NULL); END;
	overriding MEMBER FUNCTION isDebugEnabled RETURN BOOLEAN IS BEGIN RETURN isEnabled(Logger_impl.ll_DEBUG,NULL); END;
	overriding MEMBER FUNCTION isInfoEnabled  RETURN BOOLEAN IS BEGIN RETURN isEnabled(Logger_impl.ll_INFO ,NULL); END;
	overriding MEMBER FUNCTION isWarnEnabled  RETURN BOOLEAN IS BEGIN RETURN isEnabled(Logger_impl.ll_WARN ,NULL); END;
	overriding MEMBER FUNCTION isErrorEnabled RETURN BOOLEAN IS BEGIN RETURN isEnabled(Logger_impl.ll_ERROR,NULL); END;
	overriding MEMBER FUNCTION isFatalEnabled RETURN BOOLEAN IS BEGIN RETURN isEnabled(Logger_impl.ll_FATAL,NULL); END;

	overriding MEMBER FUNCTION isTraceEnabled(marker Marker) RETURN BOOLEAN IS BEGIN RETURN isEnabled(Logger_impl.ll_TRACE,marker); END;
	overriding MEMBER FUNCTION isDebugEnabled(marker Marker) RETURN BOOLEAN IS BEGIN RETURN isEnabled(Logger_impl.ll_DEBUG,marker); END;
	overriding MEMBER FUNCTION isInfoEnabled (marker Marker) RETURN BOOLEAN IS BEGIN RETURN isEnabled(Logger_impl.ll_INFO ,marker); END;
	overriding MEMBER FUNCTION isWarnEnabled (marker Marker) RETURN BOOLEAN IS BEGIN RETURN isEnabled(Logger_impl.ll_WARN ,marker); END;
	overriding MEMBER FUNCTION isErrorEnabled(marker Marker) RETURN BOOLEAN IS BEGIN RETURN isEnabled(Logger_impl.ll_ERROR,marker); END;
	overriding MEMBER FUNCTION isFatalEnabled(marker Marker) RETURN BOOLEAN IS BEGIN RETURN isEnabled(Logger_impl.ll_FATAL,marker); END;

	overriding MEMBER PROCEDURE log(lvl LogLevel, marker Marker, msg Message)
	IS BEGIN IF isEnabled(lvl,marker) THEN Logger_impl.log(marker,m_name,lvl,msg); END IF; END;

	overriding MEMBER PROCEDURE log(lvl LogLevel, marker Marker, msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(lvl,marker) THEN Logger_impl.log(marker,m_name,lvl,msg,throwable); END IF; END;

	overriding MEMBER PROCEDURE log(lvl LogLevel, marker Marker, msg VARCHAR2)
	IS BEGIN IF isEnabled(lvl,marker) THEN Logger_impl.log(marker,m_name,lvl,MessageFactory.newMessage(msg)); END IF; END;

	overriding MEMBER PROCEDURE log(lvl LogLevel, marker Marker, msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(lvl,marker) THEN Logger_impl.log(marker,m_name,lvl,MessageFactory.newMessage(msg),throwable); END IF; END;


	overriding MEMBER PROCEDURE log(lvl LogLevel, msg Message)
	IS BEGIN IF isEnabled(lvl,NULL  ) THEN Logger_impl.log(null  ,m_name,lvl,msg); END IF; END;

	overriding MEMBER PROCEDURE log(lvl LogLevel, msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(lvl,NULL  ) THEN Logger_impl.log(NULL  ,m_name,lvl,msg,throwable); END IF; END;

	overriding MEMBER PROCEDURE log(lvl LogLevel, msg VARCHAR2)
	IS BEGIN IF isEnabled(lvl,NULL  ) THEN Logger_impl.log(NULL  ,m_name,lvl,MessageFactory.newMessage(msg)); END IF; END;

	overriding MEMBER PROCEDURE log(lvl LogLevel, msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(lvl,NULL  ) THEN Logger_impl.log(NULL  ,m_name,lvl,MessageFactory.newMessage(msg),throwable); END IF; END;


--entry

	overriding MEMBER PROCEDURE entry
	IS
	BEGIN
	IF isEnabled(Logger_impl.ll_TRACE,Logger_impl.ENTRY_MARKER) THEN
			Logger_impl.log(Logger_impl.ENTRY_MARKER,m_name,Logger_impl.ll_TRACE,NULL);
	END IF;
	END;

--exit

	overriding MEMBER PROCEDURE exit
	IS
	BEGIN
		IF isEnabled(Logger_impl.ll_TRACE,Logger_impl.EXIT_MARKER) THEN
			Logger_impl.log(Logger_impl.EXIT_MARKER,m_name,Logger_impl.ll_TRACE,NULL);
		END IF;
	END;

	overriding MEMBER FUNCTION exit(result log4_object) RETURN log4_object
	IS
	BEGIN
		IF isEnabled(Logger_impl.ll_TRACE,Logger_impl.EXIT_MARKER) THEN
			IF result is null then
				Logger_impl.log(Logger_impl.EXIT_MARKER ,m_name, Logger_impl.ll_TRACE, MessageFactory.newMessage('exit'));
			ELSE
				Logger_impl.log(Logger_impl.EXIT_MARKER ,m_name, Logger_impl.ll_TRACE, MessageFactory.newMessage('exit with ('||result.tostring||')'));
			END IF;
		END IF;
		RETURN result;
	END;

	overriding MEMBER FUNCTION exit(result VARCHAR2) RETURN VARCHAR2
	IS
	BEGIN
		IF isEnabled(Logger_impl.ll_TRACE,Logger_impl.EXIT_MARKER) THEN
			IF result is null then
				Logger_impl.log(Logger_impl.EXIT_MARKER ,m_name, Logger_impl.ll_TRACE, MessageFactory.newMessage('exit'));
			else
				Logger_impl.log(Logger_impl.EXIT_MARKER ,m_name, Logger_impl.ll_TRACE, MessageFactory.newMessage('exit with ('||result||')'));
			END IF;
		END IF;  
		RETURN result;
	END;

	overriding MEMBER FUNCTION exit(result NUMBER) RETURN NUMBER
	IS
	BEGIN
		IF isEnabled(Logger_impl.ll_TRACE,Logger_impl.EXIT_MARKER) THEN
			IF result is null then
				Logger_impl.log(Logger_impl.EXIT_MARKER ,m_name, Logger_impl.ll_TRACE, MessageFactory.newMessage('exit'));
			ELSE
				Logger_impl.log(Logger_impl.EXIT_MARKER ,m_name, Logger_impl.ll_TRACE, MessageFactory.newMessage('exit with ('||to_char(result)||')'));
			END IF;
		END IF;  
		RETURN result;
	END;

	overriding MEMBER FUNCTION exit(result DATE) RETURN DATE
	IS
	BEGIN
		IF isEnabled(Logger_impl.ll_TRACE,Logger_impl.EXIT_MARKER) THEN
			IF result is null then
				Logger_impl.log(Logger_impl.EXIT_MARKER ,m_name, Logger_impl.ll_TRACE, MessageFactory.newMessage('exit'));
			ELSE
				Logger_impl.log(Logger_impl.EXIT_MARKER ,m_name, Logger_impl.ll_TRACE, MessageFactory.newMessage('exit with ('||TO_CHAR(result)||')'));
			END IF;
		END IF;  
		RETURN result;
	END;

	overriding MEMBER FUNCTION exit(result TIMESTAMP ) RETURN TIMESTAMP 
	IS
	BEGIN
		IF isEnabled(Logger_impl.ll_TRACE,Logger_impl.EXIT_MARKER) THEN
			IF result is null then
				Logger_impl.log(Logger_impl.EXIT_MARKER ,m_name, Logger_impl.ll_TRACE, MessageFactory.newMessage('exit'));
			ELSE
				Logger_impl.log(Logger_impl.EXIT_MARKER ,m_name, Logger_impl.ll_TRACE, MessageFactory.newMessage('exit with ('||TO_CHAR(result)||')'));
			END IF;
		END IF;    
		RETURN result;
	END;

	overriding MEMBER FUNCTION exit(result TIMESTAMP WITH TIME ZONE) RETURN TIMESTAMP WITH TIME ZONE
	IS
	BEGIN
		IF isEnabled(Logger_impl.ll_TRACE,Logger_impl.EXIT_MARKER) THEN
			IF result is null then
				Logger_impl.log(Logger_impl.EXIT_MARKER ,m_name, Logger_impl.ll_TRACE, MessageFactory.newMessage('exit'));
			ELSE
				Logger_impl.log(Logger_impl.EXIT_MARKER ,m_name, Logger_impl.ll_TRACE, MessageFactory.newMessage('exit with ('||TO_CHAR(result)||')'));
			END IF;
		END IF;    
		RETURN result;
	END;

	overriding MEMBER FUNCTION exit(result BOOLEAN) RETURN BOOLEAN
	IS
	BEGIN
		IF isEnabled(Logger_impl.ll_TRACE,Logger_impl.EXIT_MARKER) THEN
			IF result IS NULL THEN
				Logger_impl.LOG(Logger_impl.EXIT_MARKER ,m_name, Logger_impl.ll_TRACE, MessageFactory.newMessage('exit with (NULL)'));
			elsif result then
				Logger_impl.LOG(Logger_impl.EXIT_MARKER ,m_name, Logger_impl.ll_TRACE, MessageFactory.newMessage('exit with (TRUE)'));
	  else
				Logger_impl.log(Logger_impl.EXIT_MARKER ,m_name, Logger_impl.ll_TRACE, MessageFactory.newMessage('exit with (FALSE)'));
			END IF;
		END IF;  
		RETURN result;
	END;

  --debug
	overriding MEMBER PROCEDURE debug(m Marker,msg Message)
	IS BEGIN IF isEnabled(Logger_impl.ll_DEBUG,m) THEN Logger_impl.log(m, m_name, Logger_impl.ll_DEBUG,msg); END IF; END;

	overriding MEMBER PROCEDURE debug(m Marker,msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(Logger_impl.ll_DEBUG,m) THEN Logger_impl.log(m, m_name, Logger_impl.ll_DEBUG,msg,throwable); END IF; END;

	overriding MEMBER PROCEDURE debug(m Marker,msg VARCHAR2)
	IS BEGIN IF isEnabled(Logger_impl.ll_DEBUG,m) THEN Logger_impl.log(m, m_name, Logger_impl.ll_DEBUG,MessageFactory.newMessage(msg)); END IF; END;

	overriding MEMBER PROCEDURE debug(m Marker,msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(Logger_impl.ll_DEBUG,m) THEN Logger_impl.log(m, m_name, Logger_impl.ll_DEBUG,MessageFactory.newMessage(msg),throwable); END IF; END;


	overriding MEMBER PROCEDURE debug(msg Message)
	IS BEGIN IF isEnabled(Logger_impl.ll_DEBUG,NULL) THEN Logger_impl.log(NULL, m_name, Logger_impl.ll_DEBUG,msg); END IF; END;

	overriding MEMBER PROCEDURE debug(msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(Logger_impl.ll_DEBUG,NULL) THEN Logger_impl.log(NULL, m_name, Logger_impl.ll_DEBUG,msg,throwable); END IF; END;  

	overriding MEMBER PROCEDURE debug(msg VARCHAR2)
	IS BEGIN IF isEnabled(Logger_impl.ll_DEBUG,NULL) THEN Logger_impl.log(NULL, m_name, Logger_impl.ll_DEBUG,MessageFactory.newMessage(msg)); END IF; END;

	overriding MEMBER PROCEDURE debug(msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(Logger_impl.ll_DEBUG,NULL) THEN Logger_impl.log(NULL, m_name, Logger_impl.ll_DEBUG,MessageFactory.newMessage(msg),throwable); END IF; END;  


--error
	overriding MEMBER PROCEDURE error(m Marker, msg Message)
	IS BEGIN IF isEnabled(Logger_impl.ll_ERROR,m)    THEN Logger_impl.log(m   ,m_name,Logger_impl.ll_ERROR,msg); END IF; END;

	overriding MEMBER PROCEDURE error(m Marker, msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(Logger_impl.ll_ERROR,m)    THEN Logger_impl.log(m   ,m_name,Logger_impl.ll_ERROR,msg,throwable); END IF; END;  

	overriding MEMBER PROCEDURE error(m Marker, msg VARCHAR2)
	IS BEGIN IF isEnabled(Logger_impl.ll_ERROR,m)    THEN Logger_impl.log(m   ,m_name,Logger_impl.ll_ERROR,MessageFactory.newMessage(msg)); END IF; END;

	overriding MEMBER PROCEDURE error(m Marker, msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(Logger_impl.ll_ERROR,m   ) THEN Logger_impl.log(m   ,m_name,Logger_impl.ll_ERROR,MessageFactory.newMessage(msg),throwable); END IF; END;  


	overriding MEMBER PROCEDURE error(msg Message)
	IS BEGIN IF isEnabled(Logger_impl.ll_ERROR,NULL) THEN Logger_impl.log(NULL,m_name,Logger_impl.ll_ERROR,msg); END IF; END;

	overriding MEMBER PROCEDURE error(msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(Logger_impl.ll_ERROR,NULL) THEN Logger_impl.log(NULL,m_name,Logger_impl.ll_ERROR,msg,throwable); END IF; END;  

	overriding MEMBER PROCEDURE error(msg VARCHAR2)
	IS BEGIN IF isEnabled(Logger_impl.ll_ERROR,NULL) THEN Logger_impl.log(NULL,m_name,Logger_impl.ll_ERROR,MessageFactory.newMessage(msg)); END IF; END;

	overriding MEMBER PROCEDURE error(msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(Logger_impl.ll_ERROR,NULL) THEN Logger_impl.log(NULL,m_name,Logger_impl.ll_ERROR,MessageFactory.newMessage(msg),throwable); END IF; END;  

  --info

	overriding MEMBER PROCEDURE info(m Marker, msg Message)
	IS BEGIN IF isEnabled(Logger_impl.ll_INFO,m   ) THEN Logger_impl.log(m   , m_name, Logger_impl.ll_INFO,msg); END IF; END;

	overriding MEMBER PROCEDURE info(m Marker, msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(Logger_impl.ll_INFO,m   ) THEN Logger_impl.log(m   , m_name, Logger_impl.ll_INFO,msg, throwable); END IF; END;

	overriding MEMBER PROCEDURE info(m Marker, msg VARCHAR2)
	IS BEGIN IF isEnabled(Logger_impl.ll_INFO,m   ) THEN Logger_impl.log(m   , m_name, Logger_impl.ll_INFO,MessageFactory.newMessage(msg)); END IF; END;

	overriding MEMBER PROCEDURE info(m Marker, msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(Logger_impl.ll_INFO,m   ) THEN Logger_impl.log(m   , m_name, Logger_impl.ll_INFO,MessageFactory.newMessage(msg),throwable); END IF; END;


	overriding MEMBER PROCEDURE info(msg Message)
	IS BEGIN IF isEnabled(Logger_impl.ll_INFO,NULL) THEN Logger_impl.log(NULL, m_name, Logger_impl.ll_INFO,msg); END IF; END;

	overriding MEMBER PROCEDURE info(msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(Logger_impl.ll_INFO,NULL) THEN Logger_impl.log(NULL, m_name, Logger_impl.ll_INFO,msg, throwable); END IF; END;

	overriding MEMBER PROCEDURE info(msg VARCHAR2)
	IS BEGIN IF isEnabled(Logger_impl.ll_INFO,NULL) THEN Logger_impl.log(NULL, m_name, Logger_impl.ll_INFO,MessageFactory.newMessage(msg)); END IF; END;

	overriding MEMBER PROCEDURE info(msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(Logger_impl.ll_INFO,NULL) THEN Logger_impl.log(NULL, m_name, Logger_impl.ll_INFO,MessageFactory.newMessage(msg),throwable); END IF; END;

--warn
	overriding MEMBER PROCEDURE warn(m Marker, msg Message)
	IS BEGIN IF isEnabled(Logger_impl.ll_WARN,m   ) THEN Logger_impl.log(m   ,m_name,Logger_impl.ll_WARN,msg); END IF; END;

	overriding MEMBER PROCEDURE warn(m Marker, msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(Logger_impl.ll_WARN,m   ) THEN Logger_impl.log(m   ,m_name,Logger_impl.ll_WARN,msg,throwable); END IF; END;

	overriding MEMBER PROCEDURE warn(m Marker, msg VARCHAR2)
	IS BEGIN IF isEnabled(Logger_impl.ll_WARN,m   ) THEN Logger_impl.log(m   ,m_name,Logger_impl.ll_WARN,MessageFactory.newMessage(msg)); END IF; END;

	overriding MEMBER PROCEDURE warn(m Marker, msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(Logger_impl.ll_WARN,m   ) THEN Logger_impl.log(m   ,m_name,Logger_impl.ll_WARN,MessageFactory.newMessage(msg),throwable); END IF; END;


	overriding MEMBER PROCEDURE warn(msg Message)
	IS BEGIN IF isEnabled(Logger_impl.ll_WARN,NULL) THEN Logger_impl.log(NULL,m_name,Logger_impl.ll_WARN,msg); END IF; END;

	overriding MEMBER PROCEDURE warn(msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(Logger_impl.ll_WARN,NULL) THEN Logger_impl.log(NULL,m_name,Logger_impl.ll_WARN,msg,throwable); END IF; END;

	overriding MEMBER PROCEDURE warn(msg VARCHAR2)
	IS BEGIN IF isEnabled(Logger_impl.ll_WARN,NULL) THEN Logger_impl.log(NULL,m_name,Logger_impl.ll_WARN,MessageFactory.newMessage(msg)); END IF; END;

	overriding MEMBER PROCEDURE warn(msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(Logger_impl.ll_WARN,NULL) THEN Logger_impl.log(NULL,m_name,Logger_impl.ll_WARN,MessageFactory.newMessage(msg),throwable); END IF; END;


--fatal
	overriding MEMBER PROCEDURE fatal(m Marker, msg Message)
	IS BEGIN IF isEnabled(Logger_impl.ll_FATAL,m) THEN Logger_impl.log(m,m_name,Logger_impl.ll_FATAL,msg); END IF; END;

	overriding MEMBER PROCEDURE fatal(m Marker, msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(Logger_impl.ll_FATAL,m) THEN Logger_impl.log(m,m_name,Logger_impl.ll_FATAL,msg,throwable); END IF; END;  

	overriding MEMBER PROCEDURE fatal(m Marker, msg VARCHAR2)
	IS BEGIN IF isEnabled(Logger_impl.ll_FATAL,m) THEN Logger_impl.log(m,m_name,Logger_impl.ll_FATAL,MessageFactory.newMessage(msg)); END IF; END;

	overriding MEMBER PROCEDURE fatal(m Marker, msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(Logger_impl.ll_FATAL,m) THEN Logger_impl.log(m,m_name,Logger_impl.ll_FATAL,MessageFactory.newMessage(msg),throwable); END IF; END;  


	overriding MEMBER PROCEDURE fatal(msg Message)
	IS BEGIN IF isEnabled(Logger_impl.ll_FATAL,NULL) THEN Logger_impl.log(NULL,m_name,Logger_impl.ll_FATAL,msg); END IF; END;

	overriding MEMBER PROCEDURE fatal(msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(Logger_impl.ll_FATAL,NULL) THEN Logger_impl.log(NULL,m_name,Logger_impl.ll_FATAL,msg,throwable); END IF; END;  

	overriding MEMBER PROCEDURE fatal(msg VARCHAR2)
	IS BEGIN IF isEnabled(Logger_impl.ll_FATAL,NULL) THEN Logger_impl.log(NULL,m_name,Logger_impl.ll_FATAL,MessageFactory.newMessage(msg)); END IF; END;

	overriding MEMBER PROCEDURE fatal(msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(Logger_impl.ll_FATAL,NULL) THEN Logger_impl.log(NULL,m_name,Logger_impl.ll_FATAL,MessageFactory.newMessage(msg),throwable); END IF; END;  

--trace

	overriding MEMBER PROCEDURE trace(m Marker, msg Message)
	IS BEGIN IF isEnabled(Logger_impl.ll_TRACE,m   ) THEN Logger_impl.log(m   ,m_name,Logger_impl.ll_TRACE,msg); END IF; END;

	overriding MEMBER PROCEDURE trace(m Marker, msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(Logger_impl.ll_TRACE,m   ) THEN Logger_impl.log(m   ,m_name,Logger_impl.ll_TRACE,msg,throwable); END IF; END;  

	overriding MEMBER PROCEDURE trace(m Marker, msg VARCHAR2)
	IS BEGIN IF isEnabled(Logger_impl.ll_TRACE,m   ) THEN Logger_impl.log(m   ,m_name,Logger_impl.ll_TRACE,MessageFactory.newMessage(msg)); END IF; END;

	overriding MEMBER PROCEDURE trace(m Marker, msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(Logger_impl.ll_TRACE,m   ) THEN Logger_impl.log(m   ,m_name,Logger_impl.ll_TRACE,MessageFactory.newMessage(msg),throwable); END IF; END;  


	overriding MEMBER PROCEDURE trace(msg Message)
	IS BEGIN IF isEnabled(Logger_impl.ll_TRACE,NULL) THEN Logger_impl.log(NULL,m_name,Logger_impl.ll_TRACE,msg); END IF; END;

	overriding MEMBER PROCEDURE trace(msg Message, throwable GenericException)
	IS BEGIN IF isEnabled(Logger_impl.ll_TRACE,NULL) THEN Logger_impl.log(NULL,m_name,Logger_impl.ll_TRACE,msg,throwable); END IF; END;  

	overriding MEMBER PROCEDURE trace(msg VARCHAR2)
	IS BEGIN IF isEnabled(Logger_impl.ll_TRACE,NULL) THEN Logger_impl.log(NULL,m_name,Logger_impl.ll_TRACE,MessageFactory.newMessage(msg)); END IF; END;

	overriding MEMBER PROCEDURE trace(msg VARCHAR2, throwable GenericException)
	IS BEGIN IF isEnabled(Logger_impl.ll_TRACE,NULL) THEN Logger_impl.log(NULL,m_name,Logger_impl.ll_TRACE,MessageFactory.newMessage(msg),throwable); END IF; END;  


--catching
	overriding MEMBER PROCEDURE catching(throwable GenericException DEFAULT GenericException() )
	IS
	BEGIN
		IF isEnabled(Logger_impl.ll_ERROR,Logger_impl.CATCHING_MARKER) THEN
			Logger_impl.log(Logger_impl.CATCHING_MARKER, m_name, Logger_impl.ll_ERROR,MessageFactory.newMessage('catching'),throwable);
		END IF;
	END;

	overriding MEMBER PROCEDURE catching(lvl LogLevel, throwable GenericException DEFAULT GenericException() )
	IS
	BEGIN
		IF isEnabled(lvl,Logger_impl.CATCHING_MARKER) THEN
			Logger_impl.log(Logger_impl.CATCHING_MARKER, m_name, lvl,MessageFactory.newMessage('catching'),throwable);
		END IF;
	END;


--parameterised stuff
	overriding MEMBER PROCEDURE trace(msg VARCHAR2
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
	  IF isEnabled(Logger_impl.ll_TRACE,NULL) THEN
			prms := log4_array(log4_sql_object(arg01),log4_sql_object(arg02),log4_sql_object(arg03),log4_sql_object(arg04),log4_sql_object(arg05),log4_sql_object(arg06),log4_sql_object(arg07),log4_sql_object(arg08),log4_sql_object(arg09) );
			Logger_impl.LOG(NULL, m_name, Logger_impl.ll_TRACE,MessageFactory.newMessage(msg, prms));
		END IF;  
	END;



	overriding MEMBER PROCEDURE debug(msg VARCHAR2
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
	  IF isEnabled(Logger_impl.ll_DEBUG,NULL) THEN
	  prms := log4_array(log4_sql_object(arg01),log4_sql_object(arg02),log4_sql_object(arg03),log4_sql_object(arg04),log4_sql_object(arg05),log4_sql_object(arg06),log4_sql_object(arg07),log4_sql_object(arg08),log4_sql_object(arg09) );
			Logger_impl.LOG(NULL, m_name, Logger_impl.ll_DEBUG,MessageFactory.newMessage(msg, prms));
	  end if;  
	END;

	overriding MEMBER PROCEDURE  info(msg VARCHAR2
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
	  IF isEnabled(Logger_impl.ll_INFO,NULL) THEN
	  prms := log4_array(log4_sql_object(arg01),log4_sql_object(arg02),log4_sql_object(arg03),log4_sql_object(arg04),log4_sql_object(arg05),log4_sql_object(arg06),log4_sql_object(arg07),log4_sql_object(arg08),log4_sql_object(arg09) );
			Logger_impl.LOG(NULL, m_name, Logger_impl.ll_INFO,MessageFactory.newMessage(msg, prms));
	  end if;  
	END;

	overriding MEMBER PROCEDURE  warn(msg VARCHAR2
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
	  IF isEnabled(Logger_impl.ll_WARN,NULL) THEN
	  prms := log4_array(log4_sql_object(arg01),log4_sql_object(arg02),log4_sql_object(arg03),log4_sql_object(arg04),log4_sql_object(arg05),log4_sql_object(arg06),log4_sql_object(arg07),log4_sql_object(arg08),log4_sql_object(arg09) );
			Logger_impl.LOG(NULL, m_name, Logger_impl.ll_WARN,MessageFactory.newMessage(msg, prms));
	  end if;  
	END;


	overriding MEMBER PROCEDURE error(msg VARCHAR2
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
	  IF isEnabled(Logger_impl.ll_ERROR,NULL) THEN
	  prms := log4_array(log4_sql_object(arg01),log4_sql_object(arg02),log4_sql_object(arg03),log4_sql_object(arg04),log4_sql_object(arg05),log4_sql_object(arg06),log4_sql_object(arg07),log4_sql_object(arg08),log4_sql_object(arg09) );
			Logger_impl.LOG(NULL, m_name, Logger_impl.ll_ERROR,MessageFactory.newMessage(msg, prms));
	  end if;  
	END;


	overriding MEMBER PROCEDURE fatal(msg VARCHAR2
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
	  IF isEnabled(Logger_impl.ll_FATAL,NULL) THEN
	  prms := log4_array(log4_sql_object(arg01),log4_sql_object(arg02),log4_sql_object(arg03),log4_sql_object(arg04),log4_sql_object(arg05),log4_sql_object(arg06),log4_sql_object(arg07),log4_sql_object(arg08),log4_sql_object(arg09) );
			Logger_impl.LOG(NULL, m_name, Logger_impl.ll_FATAL,MessageFactory.newMessage(msg, prms));
	  end if;  
	END;

	overriding MEMBER PROCEDURE entry(
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
	  --IF isEnabled(Logger_impl.ll_FATAL,NULL) THEN
	  --prms := log4_array(log4_sql_object(arg01),log4_sql_object(arg02),log4_sql_object(arg03),log4_sql_object(arg04),log4_sql_object(arg05),log4_sql_object(arg06),log4_sql_object(arg07),log4_sql_object(arg08),log4_sql_object(arg09) );
			--Logger_impl.LOG(NULL, m_name, Logger_impl.ll_FATAL,MessageFactory.newMessage(msg, prms));
	  --end if;  
	END;

	overriding MEMBER PROCEDURE printf(lvl LogLevel, mkr Marker, format VARCHAR2 , arg01 VARCHAR2 , arg02 VARCHAR2 DEFAULT NULL , arg03 VARCHAR2 DEFAULT NULL , arg04 VARCHAR2 DEFAULT NULL , arg05 VARCHAR2 DEFAULT NULL , arg06 VARCHAR2 DEFAULT NULL , arg07 VARCHAR2 DEFAULT NULL , arg08 VARCHAR2 DEFAULT NULL , arg09 VARCHAR2 DEFAULT NULL) 
	IS
	prms log4_array;
	BEGIN
	  IF isEnabled(lvl,mkr) THEN
		  prms := log4_array(log4_sql_object(arg01),log4_sql_object(arg02),log4_sql_object(arg03),log4_sql_object(arg04),log4_sql_object(arg05),log4_sql_object(arg06),log4_sql_object(arg07),log4_sql_object(arg08),log4_sql_object(arg09) );
		--	Logger_impl.LOG(NULL, m_name, Logger_impl.ll_FATAL,MessageFactory.newMessage(msg, prms));
	  end if;  
	END;
	overriding MEMBER PROCEDURE printf(lvl LogLevel            , format VARCHAR2 , arg01 VARCHAR2 , arg02 VARCHAR2 DEFAULT NULL , arg03 VARCHAR2 DEFAULT NULL , arg04 VARCHAR2 DEFAULT NULL , arg05 VARCHAR2 DEFAULT NULL , arg06 VARCHAR2 DEFAULT NULL , arg07 VARCHAR2 DEFAULT NULL , arg08 VARCHAR2 DEFAULT NULL , arg09 VARCHAR2 DEFAULT NULL) 
	IS
	prms log4_array;
	BEGIN
	  IF isEnabled(lvl,NULL) THEN
		  prms := log4_array(log4_sql_object(arg01),log4_sql_object(arg02),log4_sql_object(arg03),log4_sql_object(arg04),log4_sql_object(arg05),log4_sql_object(arg06),log4_sql_object(arg07),log4_sql_object(arg08),log4_sql_object(arg09) );
		--Logger_impl.LOG(NULL, m_name, Logger_impl.ll_FATAL,MessageFactory.newMessage(msg, prms));
	  end if;  
	END;



END;
/
show errors
-- vim: ts=4 sw=4 filetype=sqloracle
