prompt create or replace TYPE Appender 
create or replace
TYPE Appender 
as object
(
	/* The name of this Appender. */
	m_name varchar2(255),
	m_layout Layout,

	member function getName return varchar2,
	member procedure append(event LogEvent) ,

	--member function getHandler return ErrorHandler,
	member function getLayout return Layout,
	--member procedure setHandler(h ErrorHandler) ,

	member function toString return varchar2,

 --constructor function Appender(name VARCHAR2, filter Filter, layout Layout,ignoreExceptions boolean ) return self as result,
 constructor function Appender(name VARCHAR2, filter varchar2, layout Layout,ignoreExceptions boolean ) return self as result,

	map member function Compare return varchar2

)
not final not instantiable ;
/
show errors


