prompt create or replace package LogManager 

create or replace package LogManager 
AUTHID DEFINER
as
    

  --Returns a Logger with the name of the calling class.
	function GETLOGGER return LOGGER;

  --Returns a Logger with the specified name.
	function GETLOGGER(name varchar2) return LOGGER;
	function GETCLASSNAME(DEPTH number) return varchar2;

  --Returns THE root logger.
  function getRootLogger return LOGGER;
  

  --Returns the current LoggerContext.  
  function getContext return LoggerContext;
/*  
static LoggerContext	getContext(boolean currentContext)
Returns a LoggerContext.
static LoggerContext	getContext(ClassLoader loader, boolean currentContext)
Returns a LoggerContext.
static LoggerContext	getContext(ClassLoader loader, boolean currentContext, Object externalContext)
Returns a LoggerContext.
static LoggerContext	getContext(ClassLoader loader, boolean currentContext, Object externalContext, URI configLocation)
Returns a LoggerContext.
static LoggerContext	getContext(ClassLoader loader, boolean currentContext, Object externalContext, URI configLocation, String name)
Returns a LoggerContext.
static LoggerContext	getContext(ClassLoader loader, boolean currentContext, URI configLocation)
Returns a LoggerContext.

protected static LoggerContext	getContext(String fqcn, boolean currentContext)
Returns a LoggerContext
protected static LoggerContext	getContext(String fqcn, ClassLoader loader, boolean currentContext)
Returns a LoggerContext

static LoggerContextFactory	getFactory()
Returns the LoggerContextFactory.

static Logger	getFormatterLogger(Class<?> clazz)
Returns a formatter Logger using the fully qualified name of the Class as the Logger name.
static Logger	getFormatterLogger(Object value)
Returns a formatter Logger using the fully qualified name of the value's Class as the Logger name.
static Logger	getFormatterLogger(String name)
Returns a formatter Logger with the specified name.

static Logger	getLogger(Class<?> clazz)
Returns a Logger using the fully qualified name of the Class as the Logger name.
static Logger	getLogger(Class<?> clazz, MessageFactory messageFactory)
Returns a Logger using the fully qualified name of the Class as the Logger name.
static Logger	getLogger(MessageFactory messageFactory)
Returns a Logger with the name of the calling class.
static Logger	getLogger(Object value)
Returns a Logger using the fully qualified class name of the value as the Logger name.
static Logger	getLogger(Object value, MessageFactory messageFactory)
Returns a Logger using the fully qualified class name of the value as the Logger name.

static Logger	getLogger(String name, MessageFactory messageFactory)
Returns a Logger with the specified name.

protected static Logger	getLogger(String fqcn, String name)
Returns a Logger with the specified name.

*/

end LogManager;
/
show errors package LogManager

