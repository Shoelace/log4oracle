prompt create type log4_object 

create or replace type log4_object 
AUTHID DEFINER
AS OBJECT
(
	--m_name varchar2(200),
	zzz_dummy number,
	member function toString RETURN VARCHAR2,
	map member function Compare return varchar2 

)
not instantiable not final;
/

show errors

prompt create type log4_array 
create or replace type log4_array as table of log4_object;
/
show errors


create or replace type log4_sql_object under log4_object
(
	m_varchar varchar2(32000),
	m_number NUMBER,
	m_date DATE,

	constructor function log4_sql_object(SELF IN OUT NOCOPY log4_sql_object, v varchar2) return self as result,
	constructor function log4_sql_object(SELF IN OUT NOCOPY log4_sql_object, n number) return self as result,
	constructor function log4_sql_object(SELF IN OUT NOCOPY log4_sql_object, d date) return self as result,

	member function  getvalue return varchar2,
	member function  getvalue return number,
	member function  getvalue return date,
	overriding member function  toString return varchar2

) 
instantiable final;
/

create or replace type BODY log4_sql_object 
AS
	constructor function log4_sql_object(SELF IN OUT NOCOPY log4_sql_object, v varchar2) return self as result
	IS
	BEGIN
		m_varchar := v;
		return;
	END;
	constructor function log4_sql_object(SELF IN OUT NOCOPY log4_sql_object, n number) return self as result
	IS
	BEGIN
		m_number := n;
		return;
	END;

	constructor function log4_sql_object(SELF IN OUT NOCOPY log4_sql_object, d date) return self as result
	IS
	BEGIN
		m_date := d;
		return;
	END;

	member function  getvalue return varchar2
	AS
	BEGIN
		return m_varchar;
	END;
	member function  getvalue return number
	AS
	BEGIN
		return m_number;
	END;
	member function  getvalue return date
	AS
	BEGIN
		return m_date;
	END;

	overriding member function  toString return varchar2
	AS
	BEGIN
		--TODO: think of something better
		return m_varchar||to_char(m_number)||to_char(m_date);
	END;

end;
/
show errors
