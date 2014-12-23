create or replace
type body GenericException as
	
	constructor function GenericException(message varchar2 default null) return self as result as
	begin
		self.m_sqlcode := SQLCODE;
		self.m_sqlerrm := SQLERRM;
		self.ErrorStack := dbms_utility.format_error_stack;
		self.ErrorBacktrace := dbms_utility.format_error_backtrace;
		self.CallStack := dbms_utility.format_call_stack;
		self.Message := message;

		return;
	end;
	
	member function Format return varchar2 is
	begin
		if self.Message is null then
			return self.m_sqlerrm;
		else
			return self.Message||chr(13)||self.m_sqlerrm;
		end if;
	end;
	
end;
/
