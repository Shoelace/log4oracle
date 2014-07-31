create or replace
type ObjectMessage under Message
(
	m_obj log4_object,
	constructor FUNCTION ObjectMessage(SELF IN OUT NOCOPY ObjectMessage, obj IN log4_object ) RETURN self AS result,
	overriding MEMBER FUNCTION getFormattedMessage(SELF IN OUT NOCOPY ObjectMessage) RETURN VARCHAR2,
	overriding MEMBER FUNCTION getFormat RETURN VARCHAR2,
	overriding MEMBER FUNCTION getThrowable RETURN GenericException,
  overriding member function getParameters return log4_array

  
)
instantiable not final;
/
show errors
