create or replace
type StackTraceElement 
AUTHID DEFINER
AS OBJECT
(
/**
11   * An element in a stack trace, as returned by {@link
12   * Throwable#getStackTrace()}.  Each element represents a single stack frame.
13   * All stack frames except for the one at the top of the stack represent
14   * a method invocation.  The frame at the top of the stack represents the 
15   * the execution point at which the stack trace was generated.  Typically,
16   * this is the point at which the throwable corresponding to the stack trace
17   * was created.
18   *
19   * @since  1.4
20   * @author Josh Bloch
21   */

m_lineNumber INTEGER,
m_declaringClass VARCHAR2(255),
m_methodName VARCHAR2(255),
m_fileName VARCHAR2(255),

--  caller_type      VARCHAR2(30),
      

--	MAP MEMBER FUNCTION equals RETURN BOOLEAN, --map

	MEMBER FUNCTION getClassName RETURN VARCHAR2,
/**
36       * Returns the name of the source file containing the execution point
37       * represented by this stack trace element.  Generally, this corresponds
38       * to the <tt>SourceFile</tt> attribute of the relevant <tt>class</tt>
39       * file (as per <i>The Java Virtual Machine Specification</i>, Section
40       * 4.7.7).  In some systems, the name may refer to some source code unit
41       * other than a file, such as an entry in source repository.
42       *
43       * @return the name of the file containing the execution point
44       *         represented by this stack trace element, or <tt>null</tt> if
45       *         this information is unavailable.
46       */  
	MEMBER FUNCTION getFileName RETURN VARCHAR2,
	MEMBER FUNCTION getLineNumber RETURN INTEGER,
	MEMBER FUNCTION getMethodName RETURN VARCHAR2,
	MEMBER FUNCTION isNativeMethod RETURN BOOLEAN,

/**
104      * Returns a string representation of this stack trace element.  The
105      * format of this string depends on the implementation, but the following
106      * examples may be regarded as typical:
107      * <ul>
108      * <li>
109      *   <tt>"MyClass.mash(MyClass.java:9)"</tt> - Here, <tt>"MyClass"</tt>
110      *   is the <i>fully-qualified name</i> of the class containing the
111      *   execution point represented by this stack trace element,
112      *   <tt>"mash"</tt> is the name of the method containing the execution
113      *   point, <tt>"MyClass.java"</tt> is the source file containing the
114      *   execution point, and <tt>"9"</tt> is the line number of the source
115      *   line containing the execution point.
116      * <li>
117      *   <tt>"MyClass.mash(MyClass.java)"</tt> - As above, but the line
118      *   number is unavailable.
119      * <li>
120      *   <tt>"MyClass.mash(Unknown Source)"</tt> - As above, but neither
121      *   the file name nor the line  number are available.
122      * <li>
123      *   <tt>"MyClass.mash(Native Method)"</tt> - As above, but neither
124      *   the file name nor the line  number are available, and the method
125      *   containing the execution point is known to be a native method.
126      * </ul>
127      * @see    Throwable#printStackTrace()
128      */
	MEMBER FUNCTION toString RETURN VARCHAR2


	,CONSTRUCTOR FUNCTION StackTraceElement(self IN OUT NOCOPY StackTraceElement, declaringClass VARCHAR2,  methodName VARCHAR2, fileName VARCHAR2, lineNumber INTEGER)  RETURN SELF AS RESULT
	,CONSTRUCTOR FUNCTION StackTraceElement(self IN OUT NOCOPY StackTraceElement, depth PLS_INTEGER )  RETURN SELF AS RESULT
	,CONSTRUCTOR FUNCTION StackTraceElement(self IN OUT NOCOPY StackTraceElement)  RETURN SELF AS RESULT
	
)
instantiable final;
/

show errors
