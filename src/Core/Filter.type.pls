create or replace TYPE Filter
AUTHID DEFINER
under log4_object
(

	onMatch Result,
	onMismatch Result

    ,constructor function filter(onMatch Result, onMismatch Result) return self as result


    /**
     * Returns the result that should be returned when the filter does not match the event.
     * @return the Result that should be returned when the filter does not match the event.
     */
    , member function getOnMismatch return Result
    /**
     * Returns the result that should be returned when the filter matches the event.
     * @return the Result that should be returned when the filter matches the event.
     */
    , member function getOnMatch return Result

 /* Filter an event.
     * @param logger The Logger.
     * @param level The event logging Level.
     * @param marker The Marker for the event or null.
     * @param msg String text to filter on.
     * @param params An array of parameters or null.
     * @return the Result.
    Result filter(Logger logger, Level level, Marker marker, String msg, Object... params);
     */

    /**
     * Filter an event.
     * @param logger The Logger.
     * @param level The event logging Level.
     * @param marker The Marker for the event or null.
     * @param msg Any Object.
     * @param t A Throwable or null.
     * @return the Result.
     */
    , member function dofilter(logger Logger, lvl LogLevel, marker Marker, msg log4_object, t GenericException) return Result

    /**
     * Filter an event.
     * @param logger The Logger.
     * @param level The event logging Level.
     * @param marker The Marker for the event or null.
     * @param msg The Message
     * @param t A Throwable or null.
     * @return the Result.
     */
    , member function dofilter(logger Logger, lvl LogLevel, marker Marker, msg Message, t GenericException) return Result

    /**
     * Filter an event.
     * @param event The Event to filter on.
     * @return the Result.
     */
    , member function dofilter(event LogEvent) return Result


) not final ;
/
show errors

create or replace TYPE BODY Filter
AS

    constructor function filter(onMatch Result, onMismatch Result) return self as result
	IS
	BEGIN
		IF onMatch is NULL THEN
			self.onMatch := Result.NEUTRAL;
		ELSE
			self.onMatch := onMatch;
		END IF;
		IF onMismatch is NULL THEN
			self.onMismatch := Result.DENY;
		ELSE
			self.onMismatch := onMismatch;
		END IF;
		return;
	END;

    member function getOnMismatch return Result
	IS
	BEGIN
		return onMismatch;
	end;

    member function getOnMatch return Result
	IS
	BEGIN
		return onMatch;
	end;

    member function dofilter(logger Logger, lvl LogLevel, marker Marker, msg log4_object, t GenericException) return Result
	IS
	BEGIN
		return Result.NEUTRAL;
	end;
    member function dofilter(logger Logger, lvl LogLevel, marker Marker, msg Message, t GenericException) return Result
	IS
	BEGIN
		return Result.NEUTRAL;
	end;
    member function dofilter(event LogEvent) return Result
	IS
	BEGIN
		return Result.NEUTRAL;
	end;

END;
/
show errors

create or replace TYPE FilterArray as TABLE of Filter;
/
