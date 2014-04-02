create or replace
TYPE DBMSOutputAppender 
under Appender
(
 --constructor function Appender(name VARCHAR2, filter Filter, layout Layout,ignoreExceptions boolean ) return self as result,
 constructor function DBMSOutputAppender(name VARCHAR2, filter varchar2, layout Layout,ignoreExceptions boolean ) return self as result

	,overriding member procedure append(event LogEvent) 


)
final instantiable ;
/
show errors


create or replace
TYPE BODY DBMSOutputAppender 
as
	
 --constructor function Appender(name VARCHAR2, filter Filter, layout Layout,ignoreExceptions boolean ) return self as result,
 constructor function DBMSOutputAppender(name VARCHAR2, filter varchar2, layout Layout,ignoreExceptions boolean ) return self as result
	IS
	BEGIN
		self.m_name := name;
		self.m_layout := layout;
		NULL;
		return;
	END;

	overriding member procedure append(event LogEvent) 
	IS
	BEGIN
		dbms_output.put_line(rtrim(m_layout.format(event),CHR(13)||CHR(10)) );
		NULL;
	END;

end;

/
show errors


