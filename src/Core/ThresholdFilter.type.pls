create or replace TYPE ThresholdFilter
under Filter
(
	m_lvl LogLevel

    , constructor function ThresholdFilter(l LogLevel, onMatch Result, onMismatch Result) return self as result

    , overriding member function dofilter(logger Logger, lvl LogLevel, marker Marker, msg log4_object, t GenericException) return Result
    , overriding member function dofilter(logger Logger, lvl LogLevel, marker Marker, msg Message, t GenericException) return Result
    , overriding member function dofilter(event LogEvent) return Result

    , member function dofilter(lvl LogLevel) return Result


) not final ;
/
show errors

create or replace TYPE BODY ThresholdFilter
AS

    constructor function ThresholdFilter(l Loglevel, onMatch Result, onMismatch Result) return self as result
	IS
	BEGIN
		m_lvl := l;
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

    overriding member function dofilter(logger Logger, lvl LogLevel, marker Marker, msg log4_object, t GenericException) return Result
	IS
	BEGIN
		return dofilter(lvl);
	end;
    overriding member function dofilter(logger Logger, lvl LogLevel, marker Marker, msg Message, t GenericException) return Result
	IS
	BEGIN
		return dofilter(lvl);
	end;
    overriding member function dofilter(event LogEvent) return Result
	IS
	BEGIN
		return dofilter(event.getLevel());
	end;

    member function dofilter(lvl LogLevel) return Result
	IS
	BEGIN
		--return lvl.isAtLEastAsSpecificAs(m_lvl);
		if lvl <= m_lvl then
			return onMatch;
		end if;
		return onMismatch;
	end;
END;
/
show errors
