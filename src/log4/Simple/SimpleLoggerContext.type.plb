CREATE OR REPLACE TYPE BODY SimpleLoggerContext 
AS

	--Constructor taking a name and a reference to an external context.
	constructor function SimpleLoggerContext return self as result
	IS
	BEGIN
  LoggerContext_impl.m_all_loggers.DELETE;
        m_showContextMap := 0;
        m_showLogName := 0; 
        m_showShortName := 1; 
        m_showDateTime := 0; 

        --FINAL String lvl = props.getStringProperty(SYSTEM_PREFIX + "level");
        m_defaultLevel := LogLevel.ERROR;
		RETURN;
	end;

  overriding MEMBER FUNCTION getLogger(NAME VARCHAR2) RETURN Logger
 IS
 BEGIN
 NULL;
 return LoggerContext_impl.getLogger(NAME);
 /*
         if (loggers.containsKey(name)) {
            final Logger logger = loggers.get(name);
            AbstractLogger.checkMessageFactory(logger, messageFactory);
            return logger;
        }

        loggers.putIfAbsent(name, new SimpleLogger(name, defaultLevel, showLogName, showShortName, showDateTime,
                showContextMap, dateTimeFormat, messageFactory, props, stream));
        return loggers.get(name);
    }*/
    
 end;  
  --Determine if the specified Logger exists.
  overriding MEMBER FUNCTION hasLogger(NAME VARCHAR2) RETURN boolean
   IS
 BEGIN
 RETURN LoggerContext_impl.hasLogger(NAME);
 end;
 
 overriding MEMBER FUNCTION 	getExternalContext RETURN REF log4_object
 IS
 BEGIN
 RETURN NULL;
 END;

END;
/