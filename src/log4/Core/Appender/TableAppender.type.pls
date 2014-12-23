prompt create or replace TYPE TableAppender 

create or replace
TYPE TableAppender 
under Appender
(
	constructor function TableAppender(name VARCHAR2, filter Filter, layout Layout,ignoreExceptions boolean ) return self as result

	,overriding member procedure append(event LogEvent) 


)
final instantiable ;
/
show errors
