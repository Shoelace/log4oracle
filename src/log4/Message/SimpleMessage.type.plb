create or replace type BODY
SimpleMessage 
AS

	constructor function SimpleMessage(SELF IN OUT NOCOPY SimpleMessage, msg IN VARCHAR2 ) return self as result
	IS
	BEGIN
		self.m_message := msg;
		return;
	END;
	overriding member function getFormattedMessage(SELF IN OUT NOCOPY SimpleMessage) return VARCHAR2
	IS
	BEGIN
		return m_message;
	END;
	overriding member function getFormat return VARCHAR2
	IS
	BEGIN
		return m_message;
	END;
	overriding member function getParameters return log4_array
	IS
	BEGIN
		return null;
	END;
	overriding member function getThrowable return GenericException
	IS
	BEGIN
		return null;
	END;

END;
/
show errors
