create or replace type BODY
ObjectMessage 
AS

	constructor function ObjectMessage(SELF IN OUT NOCOPY ObjectMessage, obj IN log4_object ) return self as result
	IS
	BEGIN
		self.m_obj := obj;
		return;
	END;
	overriding member function getFormattedMessage(SELF IN OUT NOCOPY ObjectMessage)  return VARCHAR2
	IS
	BEGIN
		return m_obj.toString();
	END;
	overriding member function getFormat return VARCHAR2
	IS
	BEGIN
		return m_obj.toString();
	END;

	overriding MEMBER FUNCTION getThrowable RETURN GenericException
  IS
  BEGIN
    return null;
  END;
    
  overriding MEMBER FUNCTION getParameters RETURN log4_array
  IS
  BEGIN
    return log4_array(m_obj);
  END;

END;
/
show errors



