create or replace
type LOCATIONINFO 
AUTHID DEFINER
as object
(

	owner        varchar2(30),
	name      varchar2(30),
	lineno    number,
	caller_type      varchar2(30),

	member function toString RETURN VARCHAR2,
	member function getfqcn RETURN VARCHAR2,


	constructor function LocationInfo return self as result
	
)
instantiable final;
/

show errors
