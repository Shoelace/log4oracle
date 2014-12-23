CREATE OR REPLACE
package LoggerContext_impl
AS
	TYPE LoggerArray IS TABLE OF Logger NOT NULL INDEX BY VARCHAR2(255); --Logger.name%type;
	m_all_loggers LoggerArray;
  
  FUNCTION getLogger(NAME VARCHAR2) RETURN Logger;
  FUNCTION hasLogger(NAME VARCHAR2) RETURN BOOLEAN;

END;
/

CREATE OR REPLACE
package BODY LoggerContext_impl 
as


FUNCTION getLogger(NAME VARCHAR2) RETURN Logger
IS
BEGIN
    --loggerimpl(NAME,999);
    /*
    293            Logger logger = loggers.get(name);
294            if (logger != null) {
295                AbstractLogger.checkMessageFactory(logger, messageFactory);
296                return logger;
297            }
298    
299            logger = newInstance(this, name, messageFactory);
300            FINAL Logger prev = loggers.putIfAbsent(NAME, logger);
301            RETURN prev == NULL ? logger : prev;
*/

		IF NOT m_all_loggers.EXISTS(NAME) THEN
            m_all_loggers(name) :=  SimpleLogger(name,Loglevel.DEBUG,true,true,true,false,NULL);
    END IF;
    
    return m_all_loggers(name);
END;

FUNCTION hasLogger(NAME VARCHAR2) RETURN BOOLEAN
IS
BEGIN
		return m_all_loggers.exists(name);
END;
        
END;
/
