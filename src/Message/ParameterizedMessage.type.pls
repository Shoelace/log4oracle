prompt create or replace type ParameterizedMessage under Message

create or replace
type ParameterizedMessage under Message
(
	m_message VARCHAR2(32000),
	m_format VARCHAR2(32000),
	m_params log4_array,
	constructor FUNCTION ParameterizedMessage (SELF IN OUT NOCOPY ParameterizedMessage , msg IN VARCHAR2 , params log4_array) RETURN self AS result,

  --MEMBER FUNCTION getFormattedMessage(self IN out nocopy Message) return VARCHAR2,
  overriding member function getFormattedMessage(self IN out nocopy ParameterizedMessage) return VARCHAR2,
	overriding member function getFormat return VARCHAR2,
	overriding MEMBER FUNCTION getParameters RETURN log4_array,
	overriding MEMBER FUNCTION getThrowable RETURN GenericException

	--member function formatMessage(msgPattern VARCHAR2, args log4_array) return VARCHAR2

)
instantiable not final;
/
show errors
