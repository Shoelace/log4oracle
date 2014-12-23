
CREATE OR REPLACE TYPE SimpleLoggerContext 
UNDER LoggerContext 
(

    /** The default format to use when formatting dates */
--    protected static final String DEFAULT_DATE_TIME_FORMAT = 'yyyy/MM/dd HH:mm:ss:SSS zzz';

    /** All system properties used by <code>SimpleLog</code> start with this */
--    protected static final String SYSTEM_PREFIX = "org.apache.logging.log4j.simplelog.";

    /** Properties loaded from simplelog.properties */
--    private final Properties simpleLogProps = new Properties();

--    private final PropertiesUtil props;

    /** Include the instance name in the log message? */
    m_showLogName integer,
    /**
     * Include the short name ( last component ) of the logger in the log message. Defaults to true - otherwise we'll be
     * lost in a flood of messages without knowing who sends them.
     */
    m_showShortName integer,
    /** Include the current time in the log message */
    m_showDateTime integer,
    /** Include the ThreadContextMap in the log message */
    m_showContextMap integer,
    
    /** The date and time format to use in the log message */
    m_dateTimeFormat varchar2(200),

   m_defaultLevel LogLevel

	, constructor FUNCTION SimpleLoggerContext RETURN self AS result

/*
    public SimpleLoggerContext() {
        props = new PropertiesUtil("log4j2.simplelog.properties");

        showContextMap = props.getBooleanProperty(SYSTEM_PREFIX + "showContextMap", false);
        showLogName = props.getBooleanProperty(SYSTEM_PREFIX + "showlogname", false);
        showShortName = props.getBooleanProperty(SYSTEM_PREFIX + "showShortLogname", true);
        showDateTime = props.getBooleanProperty(SYSTEM_PREFIX + "showdatetime", false);
        final String lvl = props.getStringProperty(SYSTEM_PREFIX + "level");
        defaultLevel = Level.toLevel(lvl, Level.ERROR);

        dateTimeFormat = showDateTime ? props.getStringProperty(SimpleLoggerContext.SYSTEM_PREFIX + "dateTimeFormat",
                DEFAULT_DATE_TIME_FORMAT) : null;

        final String fileName = props.getStringProperty(SYSTEM_PREFIX + "logFile", "system.err");
        PrintStream ps;
        if ("system.err".equalsIgnoreCase(fileName)) {
            ps = System.err;
        } else if ("system.out".equalsIgnoreCase(fileName)) {
            ps = System.out;
        } else {
            try {
                final FileOutputStream os = new FileOutputStream(fileName);
                ps = new PrintStream(os);
            } catch (final FileNotFoundException fnfe) {
                ps = System.err;
            }
        }
        this.stream = ps;
    }
    
    @Override
    public Logger getLogger(final String name, final MessageFactory messageFactory) {

    */
  ,overriding MEMBER FUNCTION getLogger(NAME VARCHAR2) RETURN Logger

  --Determine if the specified Logger exists.
  ,overriding MEMBER FUNCTION hasLogger(NAME VARCHAR2) RETURN boolean

 
 ,overriding MEMBER FUNCTION 	getExternalContext RETURN REF log4_object
 
);
/
show errors

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