create or replace
type body LogLevel as

    
  /* Returns log level value as an indication of relative values to be sortable. */
  overriding map member function Compare return varchar2 as
  begin
    return to_char(m_value,'FMS0000000000' );
  end;
	overriding member function toString RETURN VARCHAR2
	is
	BEGIN
		return m_name;
	END;

	member function intLevel return NUMBER
	AS
	BEGIN
		return m_value;
	END;

 
	static function vals return log4_array
	AS
		retval log4_array := log4_array();

	BEGIN

		retval.extend(8);
		retval(1) := OFF ;
		retval(2) := FATAL ;
		retval(3) := ERROR ;
		retval(4) := WARN;
		retval(5) := INFO;
		retval(6) := DEBUG ;
		retval(7) := TRACE ;
		retval(8) := ll_ALL ;

		return retval;

	END;

constructor function LogLevel(self in out nocopy LogLevel, logLevel BINARY_INTEGER) return self as result as
  begin
    self.m_name := case logLevel
                   when 0 then 'OFF'
                   when 1 then 'FATAL'
                   when 2 then 'ERROR'
                   when 3 then 'WARN'
                   when 4 then 'INFO'
                   when 5 then 'DEBUG'
                   when 6 then 'TRACE'
                   when 2147483648-1 then 'ALL'
				else 'CUSTOM'
                 end;
    
      self.m_value := logLevel;
    
    return;
  end;

 static function ll_ALL return LogLevel as
  begin
    return LogLevel(2147483648-1);
  end;
  
  static function Trace return LogLevel as
  begin
    return LogLevel(6);
  end;

  static function Debug return LogLevel as
  begin
    return LogLevel(5);
  end;
  
  static function Info return LogLevel as
  begin
    return LogLevel(4);
  end;
  
  static function Warn return LogLevel as
  begin
    return LogLevel(3);
  end;
  
  static function Error return LogLevel as
  begin
    return LogLevel(2);
  end;
  
  static function Fatal return LogLevel as
  begin
    return LogLevel(1);
  end;
  
  static function Off return LogLevel as
  begin
    return LogLevel(0);
  end;

-- Compares this level against the level passed as an argument and returns true if this level is the same or more specific.
  MEMBER FUNCTION isAtLeastAsSpecificAs(lvl INTEGER) RETURN boolean as
  BEGIN
    return self.intLevel <= lvl;
  END;

  --Compares this level against the level passed as an argument and returns true if this level is the same or more specific.
  member function isAtLeastAsSpecificAs(lvl LogLevel) return boolean as
  begin
    return self.intLevel <= lvl.intLevel;
  end;
          
  --Compares the specified Level against this one.          
  member function lessOrEqual(lvl integer) return boolean as
  begin
    return self.intLevel <= lvl;
  end;
  
  --Compares the specified Level against this one.          
  member function lessOrEqual(lvl  LogLevel) return boolean as
  begin
    return self.intLevel <= lvl.intLevel;
  end;

  STATIC FUNCTION getLevel( NAME VARCHAR2)  RETURN LogLevel AS
  BEGIN
    return null;
  end;

  /** Converts the string passed as argument to a level. */
  STATIC FUNCTION toLevel( sArg VARCHAR2)  RETURN LogLevel as
    BEGIN
    RETURN toLevel(sArg, logLevel.DEBUG);
  end;
  --Converts the string passed as argument to a level.
  STATIC FUNCTION toLevel(NAME VARCHAR2, defaultLevel LogLevel)  RETURN LogLevel AS
  BEGIN
    IF name IS NULL THEN
            RETURN defaultLevel;
    END IF;
    
    return (case UPPER(name)
                   when 'OFF' then loglevel.off
                   when 'FATAL' then loglevel.fatal
                   when 'ERROR' then loglevel.error
                   when 'WARN' then loglevel.warn
                   when 'INFO' then loglevel.info
                   when 'DEBUG' then loglevel.debug 
                   when 'TRACE' then loglevel.trace
                   when 'ALL' then loglevel.ll_all
				else defaultLevel
                 end);

  end;

end;
/
show errors type body LogLevel
