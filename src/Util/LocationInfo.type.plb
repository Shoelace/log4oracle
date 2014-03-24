create or replace
type body LocationInfo as

  constructor function LocationInfo return self as result as
  begin
    return;
  end;

	 member function toString RETURN VARCHAR2
	IS
	BEGIN
		return utl_lms.format_message('%s %s %s %s', owner, name, to_char(lineno), caller_type);
	END;

	member function getfqcn RETURN VARCHAR2
	IS
	BEGIN
		return utl_lms.format_message('%s.%s', owner, name );
	END;

  
end;
/
show errors

