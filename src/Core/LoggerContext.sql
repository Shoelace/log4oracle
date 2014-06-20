DROP type LoggerContext FORCE;

CREATE OR REPLACE TYPE LoggerContext
AS OBJECT
(
m_name varchar2(2000)

--interface
/**
* An anchor for some other context, such as a ServletContext.
* @return The external context.
    Object getExternalContext();
*/
    ,NOT INSTANTIABLE MEMBER FUNCTION getExternalContext RETURN Ref log4_object

/**
* Returns a Logger.
* @param name The name of the Logger to return.
* @return The logger with the specified name.
*/
    ,not instantiable member function getLogger(name varchar2) return Logger

/**
* Returns a Logger.
* @param name The name of the Logger to return.
* @param messageFactory The message factory is used only when creating a logger, subsequent use does not change
the logger but will log a warning if mismatched.
* @return The logger with the specified name.
*/
   -- ,member function getLogger(name varchar2, MessageFactory messageFactory) return Logger 

/**
* Detects if a Logger with the specified name exists.
* @param name The Logger name to search for.
* @return true if the Logger exists, false otherwise.
*/
    ,not instantiable member function hasLogger(NAME varchar2) return boolean
    
) not final not instantiable;
/


CREATE OR REPLACE TYPE LoggerContextImpl
UNDER LoggerContext
(
   m_config  Configuration,
   m_externalContext REF log4_object,
   m_configLocation URITYPE,


 --interface implentation
 --Obtain a Logger from the Context.
  overriding MEMBER FUNCTION getLogger(NAME VARCHAR2) RETURN Logger
  --Determine if the specified Logger exists.
 ,overriding MEMBER FUNCTION hasLogger(NAME VARCHAR2) RETURN boolean
 
 --constructors
 --Constructor taking only a name.
 ,constructor FUNCTION LoggerContextImpl(NAME VARCHAR2) RETURN self AS result
 --Constructor taking a name and a reference to an external context.
 ,constructor function LoggerContextImpl(NAME varchar2, externalContext Ref log4_object) return self as result
  --Constructor taking a name external context and a configuration location String.
 ,constructor FUNCTION LoggerContextImpl(NAME VARCHAR2, externalContext REF log4_object, configLocn VARCHAR2) RETURN self AS result
 --Constructor taking a name, external context and a configuration URI.
 ,constructor function LoggerContextImpl(NAME varchar2, externalContext Ref log4_object, configLocn URITYPE) return self as result
  

 
 --implementation details
 --ADD A FILTER TO THE Configuration.
, member procedure addFilter(filter Filter )

--Gets the name.
, member function getName return varchar2

--Reconfigure the context.
, member procedure reconfigure

--Removes a Filter from the current Configuration.
, member procedure removeFilter(Filter filter)

--Cause ALL Loggers TO be UPDATED against THE CURRENT Configuration.
, member procedure updateLoggers

--Cause ALL Logger TO be UPDATED against THE specified Configuration.
, member procedure updateLoggers(config Configuration )


--Returns THE CURRENT Configuration.
--, member function getConfiguration return Configuration	

--Returns THE EXTERNAL CONTEXT.
, overriding MEMBER FUNCTION 	getExternalContext RETURN REF log4_object

/*
void	addPropertyChangeListener(PropertyChangeListener listener) 
URI	getConfigLocation() 

Logger	getLogger(String name, org.apache.logging.log4j.message.MessageFactory messageFactory)
Obtain a Logger from the Context.

LoggerContext.Status	getStatus() 


boolean	isStarted() 

protected Logger	newInstance(LoggerContext ctx, String name, org.apache.logging.log4j.message.MessageFactory messageFactory) 
void	onChange(Reconfigurable reconfigurable)
Cause a reconfiguration to take place when the underlying configuration file changes.



void	removePropertyChangeListener(PropertyChangeListener listener) 
void	setConfigLocation(URI configLocation) 
void	setExternalContext(Object context)
Set the external context.
void	start() 
void	start(Configuration config)
Start with a specific configuration.
void	stop() 

*/
);
/

CREATE OR REPLACE TYPE BODY LoggerContextImpl
AS
  overriding MEMBER FUNCTION getLogger(NAME VARCHAR2) RETURN Logger
 IS
 BEGIN
 NULL;
 end;  
  --Determine if the specified Logger exists.
  overriding MEMBER FUNCTION hasLogger(NAME VARCHAR2) RETURN boolean
   IS
 BEGIN
 return false;
 end;
 
 --constructors
 --Constructor taking only a name.
 constructor FUNCTION LoggerContextImpl(NAME VARCHAR2) RETURN self AS result
  IS
 BEGIN
 self.m_name := NAME;
 return;
 end;
 --Constructor taking a name and a reference to an external context.
 constructor function LoggerContextImpl(NAME varchar2, externalContext Ref log4_object) return self as result
  IS
 BEGIN
 self.m_name := NAME;
 self.m_externalContext := externalContext;
 return;
 
 end;
  --Constructor taking a name external context and a configuration location String.
 constructor FUNCTION LoggerContextImpl(NAME VARCHAR2, externalContext Ref log4_object, configLocn VARCHAR2) RETURN self AS result
  IS
 BEGIN
   self.m_name := NAME;
   self.m_externalContext := externalContext;

   IF trim(configLocn) IS NOT NULL THEN
   BEGIN
     self.m_configLocation := utlfileuritype(configLocn);
   exception
     WHEN others THEN
       self.m_configLocation := NULL;
   END;
   END IF;
   
    
 end;
 --Constructor taking a name, external context and a configuration URI.
 constructor function LoggerContextImpl(NAME varchar2, externalContext Ref log4_object, configLocn URITYPE) return self as result
  IS
 BEGIN
   self.m_name := NAME;
   self.m_externalContext := externalContext;
   self.m_configLocation := configLocn;
 end;
  

 
 --implementation details
 --ADD A FILTER TO THE Configuration.
 MEMBER PROCEDURE addFilter(FILTER FILTER )
 IS
 BEGIN
   m_config.addFilter(filter);
 end;

--Gets the name.
 member function getName return varchar2
 IS
 BEGIN
 return m_name;
 END;
--Reconfigure the context.
 member procedure reconfigure
 IS
 BEGIN
 null;
 END;
 
--Removes a Filter from the current Configuration.
 member procedure removeFilter(Filter filter)
 IS
 BEGIN
   m_config.removeFilter(filter);

 END;
--Cause ALL Loggers TO be UPDATED against THE CURRENT Configuration.
 member procedure updateLoggers
 IS
 BEGIN
    updateLoggers(self.m_config);
 END;

 MEMBER PROCEDURE updateLoggers(config Configuration )
 IS
 BEGIN
   NULL;
 END;

 
 overriding MEMBER FUNCTION 	getExternalContext RETURN REF log4_object
 IS
 BEGIN
 return m_externalcontext;
 END;
 
END ;
/
