prompt create or replace TYPE Appender 

create or replace
TYPE Appender 
AUTHID CURRENT_USER
as object
(
	/* The name of this Appender. */
	m_name varchar2(255),
	m_layout Layout,
	m_filter Filter,

	member procedure append(event LogEvent) ,

	--member function getHandler return ErrorHandler,
	member function getLayout return Layout,

	member function getName return varchar2,
   -- member function ignoreExceptions return boolean,

	--member procedure setHandler(h ErrorHandler) ,

	member function toString return varchar2,

   constructor function Appender(name VARCHAR2, filter Filter, layout Layout,ignoreExceptions boolean ) return self as result,

	map member function Compare return varchar2

	--abstractfilterable interface
	
    ,member procedure addFilter(Filter filter) 
    ,member procedure removeFilter(Filter filter) 
    ,member function hasFilter return boolean

    ,member function isFiltered(event LogEvent) return boolean

    --AbstractAppender
    --, member procedure error(msg VARCHAR2)
    --, member procedure error(msg VARCHAR2, event LogEvent,t GENERICEXCEPTION)
    --, member procedure error(msg VARCHAR2, t GENERICEXCEPTION)


)
not final not instantiable ;
/
show errors

-- vim: ts=4 sw=4 filetype=sqloracle

