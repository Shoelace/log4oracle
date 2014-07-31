create or replace type BODY
ParameterizedMessage  
AS

	constructor function ParameterizedMessage (SELF IN OUT NOCOPY ParameterizedMessage , msg IN VARCHAR2, params log4_array ) return self as result
	IS
	BEGIN
		self.m_format := msg;
		self.m_params := params;

		return;
	END;


	 overriding member function getFormattedMessage(self IN out nocopy ParameterizedMessage) return VARCHAR2
	IS
	BEGIN
    IF m_message IS NULL THEN
      --formatmessage()
   		m_message := m_format;
      FOR i IN 1 .. REGEXP_COUNT(m_message, '[^\\]{}') LOOP
        exit WHEN i > m_params.LAST;
        m_message := regexp_replace(m_message, '([^\\]){}', '\1'||m_params(i).tostring() , 1 ,1 );
      END LOOP;    
    END IF;
		return m_message;
	END;
  

   
	overriding member function getFormat return VARCHAR2
	IS
	BEGIN
		return m_format;
	END;
	overriding member function getParameters return log4_array
	IS
	BEGIN
		return m_params;
	END;
	overriding member function getThrowable return GenericException
	IS
	BEGIN
		return null;
	END;

END;
/
show errors
