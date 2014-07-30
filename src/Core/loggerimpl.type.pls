
CREATE or replace TYPE loggerimpl
UNDER logger
(

/*
void	addAppender(Appender appender)
This method is not exposed through the public API and is used primarily for unit testing.
void	addFilter(Filter filter)
This method is not exposed through the public API and is used primarily for unit testing.
int	filterCount()
This method is not exposed through the public API and is used primarily for unit testing.
Map<String,Appender>	getAppenders()
This method is not exposed through the public API and is used primarily for unit testing.
LoggerContext	getContext()
Returns the LoggerContext this Logger is associated with.
Iterator<Filter>	getFilters()
This method is not exposed through the public API and is used primarily for unit testing.
org.apache.logging.log4j.Level	getLevel()
Returns the Level associated with the Logger.
Logger	getParent()
This method is only used for 1.x compatibility.
boolean	isAdditive()
This method is not exposed through the public API and is present only to support the Log4j 1.2 compatibility bridge.
boolean	isEnabled(org.apache.logging.log4j.Level level, org.apache.logging.log4j.Marker marker, org.apache.logging.log4j.message.Message msg, Throwable t) 
boolean	isEnabled(org.apache.logging.log4j.Level level, org.apache.logging.log4j.Marker marker, Object msg, Throwable t) 
boolean	isEnabled(org.apache.logging.log4j.Level level, org.apache.logging.log4j.Marker marker, String msg) 
boolean	isEnabled(org.apache.logging.log4j.Level level, org.apache.logging.log4j.Marker marker, String msg, Object... p1) 
boolean	isEnabled(org.apache.logging.log4j.Level level, org.apache.logging.log4j.Marker marker, String msg, Throwable t) 
void	log(org.apache.logging.log4j.Marker marker, String fqcn, org.apache.logging.log4j.Level level, org.apache.logging.log4j.message.Message data, Throwable t) 
void	removeAppender(Appender appender)
This method is not exposed through the public API and is used primarily for unit testing.
void	setAdditive(boolean additive)
This method is not exposed through the public API and is present only to support the Log4j 1.2 compatibility bridge.
void	setLevel(org.apache.logging.log4j.Level level)
This method is not exposed through the public API and is provided primarily for unit testing.
String	toString()
Returns a String representation of this instance in the form "name:level[ in context_name]".
*/
);
/
show errors
