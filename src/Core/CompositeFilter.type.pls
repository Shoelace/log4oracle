create or replace TYPE CompositeFilter
under Filter
(
	m_filters FilterArray

    ,constructor function Compositefilter(filters FilterArray) return self as result


    ,overriding member function dofilter(logger Logger, lvl LogLevel, marker Marker, msg log4_object, t GenericException) return Result
    ,overriding member function dofilter(logger Logger, lvl LogLevel, marker Marker, msg Message, t GenericException) return Result
    ,overriding member function dofilter(event LogEvent) return Result
	
	, member function addFilter(filter Filter) return CompositeFilter
	, member function removeFilter(filter Filter) return CompositeFilter

	, member function hasFilters return boolean

) not final ;
/
show errors

create or replace TYPE BODY CompositeFilter
AS

    constructor function Compositefilter(filters FilterArray) return self as result
	IS
	BEGIN
		onMatch := Result.NEUTRAL;
		onMismatch := Result.NEUTRAL;
		m_filters := filters;
		return;
	END;

	member function addFilter(filter Filter) return CompositeFilter
	IS
	BEGIN
        --m_filters.extend();
        --m_filters(m_filters.LAST) := filter;
		return self;
	END;

	member function removeFilter(filter Filter) return CompositeFilter
	IS
	BEGIN
		for x in m_filters.FIRST .. m_filters.LAST LOOP
			if m_filters.exists(x) and m_filters(x) = filter then
				--m_filters.delete(x);
				exit;
			end if;
		end loop;
		return self;
	END;
	member function hasFilters return boolean
	is
	begin
		return m_filters.count >0;
	end;

    overriding member function dofilter(logger Logger, lvl LogLevel, marker Marker, msg log4_object, t GenericException) return Result
	IS
	retval Result := Result.NEUTRAL;
	BEGIN
		for x in m_filters.FIRST .. m_filters.LAST LOOP
			if m_filters.exists(x) THEN
				retval := m_filters(x).dofilter(logger, lvl, marker, msg, t);
				IF retval != Result.NEUTRAL THEN
					return retval;
				END IF;
			end if;
		END LOOP;
        return retval;
	end;
    overriding member function dofilter(logger Logger, lvl LogLevel, marker Marker, msg Message, t GenericException) return Result
	IS
		retval Result := Result.NEUTRAL;
	BEGIN
		for x in m_filters.FIRST .. m_filters.LAST LOOP
            retval := m_filters(x).dofilter(logger, lvl, marker, msg, t);
			IF retval != Result.NEUTRAL THEN
				return retval;
			END IF;
		END LOOP;
        return retval;
	end;
    overriding member function dofilter(event LogEvent) return Result
	IS
		retval Result := Result.NEUTRAL;
	BEGIN
		for x in m_filters.FIRST .. m_filters.LAST LOOP
            retval := m_filters(x).dofilter(event);
			IF retval != Result.NEUTRAL THEN
				return retval;
			END IF;
		END LOOP;
        return retval;
	end;

END;
/
show errors
