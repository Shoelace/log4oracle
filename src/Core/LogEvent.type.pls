
prompt create or replace TYPE LogEvent 

create or replace
TYPE LogEvent 
authid definer
as object
(
	m_endofbatch varchar2(1),

/**
* Gets thread name.
* 
* @return thread name, may be null.
*/
	member function getThreadName return varchar2,

/**
* Gets the message associated with the event.
* 
* @return message.
*/
	member function getMessage return Message,

/**
* Gets the Marker associated with the event.
* 
* @return Marker
*/
	member function getMarker return Marker,

/**
* Gets the level.
* 
* @return loglevel.
*/
	member function getLevel return LogLevel,
	member function getThrown return GenericException,
	member function isEndOfBatch return boolean,
	member function getTimestamp return timestamp with time zone, --was getMilis

	member function toString return varchar2

)
not final not instantiable ;
/
show errors

