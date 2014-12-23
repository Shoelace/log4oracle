create or replace type Message under log4_object
(
	member function getFormat return VARCHAR2,
	member function getFormattedMessage(self in out nocopy Message) return VARCHAR2,
	member function getParameters return log4_array,
	member function getThrowable return GenericException

/* multi format
String[]	getFormats()
Returns the supported formats.
String	getFormattedMessage(String[] formats)
Returns the Message formatted as a String.
*/
)
not final not instantiable;
/
show errors

create or replace type MultiformatMessage under Message
(
	member function getFormats return log4_array,
	MEMBER FUNCTION getFormattedMessage(self IN out nocopy MultiformatMessage, formats log4_array ) RETURN VARCHAR2
	--member function getParameters return log4_array,
	--member function getThrowable return GenericException

/* multi format
String[]	getFormats()
Returns the supported formats.
String	getFormattedMessage(String[] formats)
Returns the Message formatted as a String.
*/
)
not final not instantiable;
/
show errors

-- vim: ts=4 sw=4 filetype=sqloracle
