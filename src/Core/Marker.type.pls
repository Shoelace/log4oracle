create or replace
TYPE Marker 
under log4_object
(
	/* The name of this level. */
	m_name VARCHAR2(255),
	m_parent REF Marker,

	member function getName return varchar2,
	member function getParent return Marker,
	--these search up tree to find parents
	member function isInstanceOf(m Marker) return boolean,
	--member function isInstanceOf(name Varchar2) return boolean,
	overriding member function toString return varchar2,

	/* Returns log level value as an indication of relative values to be sortable. */
	overriding map member function Compare return varchar2

)
not final not instantiable ;
/
show errors
