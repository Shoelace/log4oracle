create or replace
type ObjectMessage under Message
(
	m_obj log4_object,
	constructor function ObjectMessage(SELF IN OUT NOCOPY ObjectMessage, obj IN log4_object ) return self as result,
	overriding member function getFormattedMessage return VARCHAR2,
	overriding member function getFormat return VARCHAR2
)
instantiable not final;
/
show errors
