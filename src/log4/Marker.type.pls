CREATE OR REPLACE
TYPE Marker FORCE
under log4_object
(
	/* The name of this level. */
	m_name VARCHAR2(255),
	m_parent_name VARCHAR2(255),

--	member function addParents(markers MarkerArray) return Marker,

	MEMBER FUNCTION getName RETURN VARCHAR2,
	member function getParent return Marker,
--	member function hasParents return boolean

	--these search up tree to find parents
	member function isInstanceOf(m Marker) return boolean,
	--member function isInstanceOf(name Varchar2) return boolean,

	member function remove(m Marker) return boolean,

	overriding member function toString return varchar2,

	/* Returns log level value as an indication of relative values to be sortable. */
	overriding map member function Compare return varchar2

)
not final not instantiable ;
/
show errors
