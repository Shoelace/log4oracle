create or replace
TYPE BODY StackTraceElement AS

	CONSTRUCTOR FUNCTION StackTraceElement(self IN OUT NOCOPY StackTraceElement, declaringClass VARCHAR2,  methodName VARCHAR2, fileName VARCHAR2, lineNumber INTEGER)  RETURN SELF AS RESULT
  IS
  BEGIN
    self.m_declaringClass := declaringClass;
    self.m_methodName     := methodname;
    self.m_fileName       := filename;
    self.m_lineNumber     := linenumber;
    RETURN;
  END;
	
  
/**
Returns a string representation of this stack trace element. The format of this string depends on the implementation, but the following examples may be regarded as typical:
"MyClass.mash(MyClass.java:9)" - Here, "MyClass" is the fully-qualified name of the class containing the execution point represented by this stack trace element, "mash" is the name of the method containing the execution point, "MyClass.java" is the source file containing the execution point, and "9" is the line number of the source line containing the execution point.
"MyClass.mash(MyClass.java)" - As above, but the line number is unavailable.
"MyClass.mash(Unknown Source)" - As above, but neither the file name nor the line number are available.
"MyClass.mash(Native Method)" - As above, but neither the file name nor the line number are available, and the method containing the execution point is known to be a native method.
*/
	 member function toString RETURN VARCHAR2
	IS
	BEGIN
		return utl_lms.format_message('%s.%s(%s:%s)', m_declaringClass, m_methodName, m_fileName, to_char(m_lineNumber));
	END;

	member function getClassName RETURN VARCHAR2
	IS
	BEGIN
		return m_declaringClass;
	END;

	member function getFileName RETURN VARCHAR2
	IS
	BEGIN
		RETURN m_fileName;
	END;
  	member function getLineNumber RETURN INTEGER
	IS
	BEGIN
		RETURN m_lineNumber;
	END;
  
  	member function getMethodName RETURN VARCHAR2
	IS
	BEGIN
		RETURN m_methodName;
	END;
  
  	member function isNativeMethod RETURN BOOLEAN
	IS
	BEGIN
		RETURN FALSE;
	END;
  

end;
/
show errors

