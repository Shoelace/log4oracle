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


end;
/
show errors


/*
create or replace package ut_LogLevel
AUTHID DEFINER
AS
$IF $$UTPLSQL_ENABLE $THEN
   PROCEDURE ut_setup;
   PROCEDURE ut_teardown;
 
   PROCEDURE ut_LogLevel_1;
   PROCEDURE ut_LogLevel_2;
   PROCEDURE ut_LogLevel_3;
$END

END;
/
show errors

create or replace package body ut_LogLevel
AS
$IF $$UTPLSQL_ENABLE $THEN
 PROCEDURE ut_setup IS
   BEGIN
      NULL;
   END;
 
   PROCEDURE ut_teardown
   IS
   BEGIN
      NULL;
   END;
   PROCEDURE ut_LogLevel_1
	IS
	BEGIN
		utassert.objexists('test','LogLevel');
	END;
   
   PROCEDURE ut_LogLevel_2
	IS
		ll LogLevel;
		ll2 LogLevel;

	BEGIN
		utassert.this('null',ll is null);
		ll := LogLevel(5);
		utassert.this('notnull',ll is not null);

		utassert.eq('check value', ll.intLevel , 5);

	END;

	PROCEDURE ut_LogLevel_3
	IS
		ll LogLevel;
		prev_ll LogLevel;
		l_vals log4_array;
		i integer;

	BEGIN
		l_vals := LogLevel.vals();

		utassert.this('vals returns array',l_vals is not null);

		i := l_vals.count;

		utassert.this('levels defined',i > 0);
		i := l_vals.FIRST;  -- get subscript of first element
		WHILE i IS NOT NULL LOOP
		   ---- do something with courses(i) 
			ll := treat ( l_vals(i) as loglevel);
			if prev_ll is not null THEN
				utassert.this('incrementing levels:'||ll.tostring||' > '||prev_ll.tostring, ll > prev_ll);
			END IF;
--
			prev_ll :=  ll;
		   i := l_vals.NEXT(i);  -- get subscript of next element
		END LOOP;

	END;
   
$END

END;
/
show errors

BEGIN
$IF $$UTPLSQL_ENABLE $THEN
	utconfig.showconfig;
	utplsql.TEST ('LogLevel', samepackage_in => FALSE , recompile_in => FALSE);
$END
NULL;
END;
/

*/
