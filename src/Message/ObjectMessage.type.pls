create or replace
type ObjectMessage under Message
(
	m_obj log4_object,
	constructor FUNCTION ObjectMessage(SELF IN OUT NOCOPY ObjectMessage, obj IN log4_object ) RETURN self AS result,
	overriding member function getFormattedMessage(SELF IN OUT NOCOPY ObjectMessage) return VARCHAR2,
	overriding member function getFormat return VARCHAR2
)
instantiable not final;
/
show errors
