prompt CREATE OR REPLACE PACKAGE LogImpl 
CREATE OR REPLACE PACKAGE LogImpl 
AUTHID DEFINER
as
	ll_TRACE LogLevel;
	ll_DEBUG LogLevel;
	ll_INFO LogLevel;
	ll_WARN LogLevel;
	ll_ERROR LogLevel;
	ll_FATAL LogLevel;
	ll_ALL LogLevel;

	FLOW_MARKER     MARKER;
	ENTRY_MARKER   MARKER;
	EXIT_MARKER    MARKER;

	EXCEPTION_MARKER MARKER;
	CATCHING_MARKER MARKER;
	THROWING_MARKER  MARKER;

	--function isEnabled(lvl LogLevel, mkr Marker) return BOOLEAN;
	function isEnabled(self IN Logger, lvl LogLevel, mkr Marker) return BOOLEAN ;

 /**
     * Logs a message with location information.
     *
     * @param marker The Marker
     * @param fqcn   The fully qualified class name of the <b>caller</b>
     * @param level  The logging level
     * @param data   The Message.
     * @param t      A Throwable or null.
     */
	procedure log(marker Marker, fqcn varchar2, lvl LogLevel, msg Message, t GenericException default null);

end;
/
show errors

