
CREATE OR REPLACE TYPE Configuration 
UNDER log4_object
(
    m_name varchar2(200)

    /**
     * Returns the configuration name.
     * @return the name of the configuration.
     */
    ,member function getName return varchar2

    /**
     * Locates the appropriate LoggerConfig for a Logger name. This will remove tokens from the
     * package name as necessary or return the root LoggerConfig if no other matches were found.
     * @param name The Logger name.
     * @return The located LoggerConfig.
     */
   -- LoggerConfig getLoggerConfig(String name);

    /**
     * Returns a Map containing all the Appenders and their name.
     * @return A Map containing each Appender's name and the Appender object.
     */
    /* 
    Map<String, Appender> getAppenders();

    Map<String, LoggerConfig> getLoggers();

    void addLoggerAppender(Logger logger, Appender appender);

    void addLoggerFilter(Logger logger, Filter filter);

    void setLoggerAdditive(Logger logger, boolean additive);

    Map<String, String> getProperties();

    void start();

    void stop();

    void addListener(ConfigurationListener listener);

    void removeListener(ConfigurationListener listener);

    StrSubstitutor getStrSubstitutor();

    void createConfiguration(Node node, LogEvent event);

    <T> T getComponent(String name);

    void addComponent(String name, Object object);

    void setConfigurationMonitor(ConfigurationMonitor monitor);

    ConfigurationMonitor getConfigurationMonitor();

    void setAdvertiser(Advertiser advertiser);

    Advertiser getAdvertiser();

    boolean isShutdownHookEnabled();
    */
    
    --filterable interface
    /**
     * Adds a new Filter. If a Filter already exists it is converted to a CompositeFilter.
     * @param filter The Filter to add.
     */
    ,member procedure addFilter(Filter filter)

    /**
     * Removes a Filter.
     * @param filter The Filter to remove.
     */
    ,member procedure removeFilter(Filter filter)

    /**
     * Returns an Iterator for all the Filters.
     * @return an Iterator for all the Filters.
     */
    ,member function getFilter return Filter 

    /**
     * Determine if a Filter is present.
     * @return true if a Filter is present, false otherwise.
     */
    ,member function  hasFilter return boolean

    /**
     * Determines if the event should be filtered.
     * @param event The LogEvent.
     * @return true if the event should be filtered, false otherwise.
     */
    ,member function  isFiltered( event LogEvent) return boolean


);
/
