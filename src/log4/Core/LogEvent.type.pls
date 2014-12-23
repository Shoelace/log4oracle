Prompt create or replace TYPE LogEvent 

create or replace
TYPE LogEvent 
authid definer
under log4_object
(
	m_endofbatch varchar2(1),
  
    /**
     * Gets the MDC data.
     * 
     * @return A copy of the Mapped Diagnostic Context or null.
     */
--    Map<String, String> getContextMap();
     member function getContextMap return ThreadContextContextMap,

    /**
     * Gets the NDC data.
     * 
     * @return A copy of the Nested Diagnostic Context or null;
     */
    --ThreadContextContextStack getContextStack();
     MEMBER FUNCTION getContextStack RETURN ThreadContextContextStack,

/**
* Gets the level.
* 
* @return loglevel.
*/
	MEMBER FUNCTION getLevel RETURN LogLevel,
  
/**
* Gets Logger name.
* 
* @return Logger name, may be null.
*/
	MEMBER FUNCTION getLoggerName RETURN VARCHAR2,

/**
* Gets the Marker associated with the event.
* 
* @return Marker
*/
	MEMBER FUNCTION getMarker RETURN Marker,
  
/**
* Gets the message associated with the event.
* 
* @return message.
*/
	member function getMessage return Message,

	MEMBER FUNCTION getTimestamp RETURN TIMESTAMP WITH TIME ZONE, --was getMilis
   
  /**
     * Gets the source of logging request.
     * 
     * @return source of logging request, may be null.
     */
	MEMBER FUNCTION getSource RETURN StackTraceElement,

/**
* Gets thread name.
* 
* @return thread name, may be null.
*/
	MEMBER FUNCTION getThreadName RETURN VARCHAR2,

    /**
     * Gets throwable associated with logging request.
     * 
     * @return throwable, may be null.
     */
	member function getThrown return GenericException,

/**
     * Returns {@code true} if this event is the last one in a batch, {@code false} otherwise. Used by asynchronous
     * Loggers and Appenders to signal to buffered downstream components when to flush to disk, as a more efficient
     * alternative to the {@code immediateFlush=true} configuration.
     * 
     * @return whether this event is the last one in a batch.
     */
	member function isEndOfBatch return boolean,

    /**
     * Sets whether this event is the last one in a batch. Used by asynchronous Loggers and Appenders to signal to
     * buffered downstream components when to flush to disk, as a more efficient alternative to the
     * {@code immediateFlush=true} configuration.
     * 
     * @param endOfBatch
     *            {@code true} if this event is the last one in a batch, {@code false} otherwise.
     */
    member procedure setEndOfBatch(endOfBatch boolean ),

	overriding member function toString return varchar2

)
not final not instantiable ;
/
show errors

