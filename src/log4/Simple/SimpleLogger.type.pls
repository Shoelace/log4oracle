
CREATE or replace TYPE SimpleLogger
UNDER Abstractlogger
(

    /** Include the current time in the log message */
    m_showDateTime integer,
    /** Include the ThreadContextMap in the log message */
    m_showContextMap integer,
    
    m_LogName varchar2(200),
    /** The date and time format to use in the log message */
    m_dateTimeFormat varchar2(200),

    m_Level LogLevel

,constructor function SimpleLogger(name varchar2, defaultLevel loglevel, showLogName boolean,
                            showShortLogName boolean, showDateTime boolean, showContextMap boolean,
                            dateTimeFormat varchar2
--, MessageFactory messageFactory, PropertiesUtil props, PrintStream stream
)RETURN self AS result

--, overriding member procedure logMessage(final String fqcn, final Level level, final Marker marker, final Message msg, 
--127                final Throwable throwable) {
	,overriding MEMBER PROCEDURE logMessage(fqcn Varchar2, lvl LogLevel, marker Marker, msg Message, throwable GenericException)


) instantiable not final;
/
show errors
