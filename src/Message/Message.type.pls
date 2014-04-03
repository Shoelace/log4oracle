create or replace type Message under log4_object
(
	member function getFormattedMessage(self in out nocopy Message) return VARCHAR2,
	member function getFormat return VARCHAR2,
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
