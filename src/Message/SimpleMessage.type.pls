create or replace
type SimpleMessage under Message
(
	m_message VARCHAR2(32000),
	constructor function SimpleMessage(SELF IN OUT NOCOPY SimpleMessage, msg IN VARCHAR2 ) return self as result,
	overriding member function getFormattedMessage(SELF IN OUT NOCOPY SimpleMessage) return VARCHAR2,
	overriding member function getFormat return VARCHAR2,
	overriding member function getParameters return log4_array,
	overriding member function getThrowable return GenericException

)
instantiable not final;
/
show errors
