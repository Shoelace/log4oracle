create or replace
TYPE LogLevel 
AUTHID DEFINER
under log4_object
(

	/* The name of this level. */
	m_name varchar2(255),
	/* The value of this level. */
	m_value INTEGER,

	
	constructor function LogLevel(self in out nocopy LogLevel, logLevel BINARY_INTEGER) return self as result,

	/* Returns log level value as an indication of relative values to be sortable. */
	overriding map member function Compare return VARCHAR2,
	overriding member function toString RETURN VARCHAR2,


	member function intLevel return NUMBER,

	static function ll_ALL return LogLevel,
	static function TRACE return LogLevel,
	static function DEBUG return LogLevel,
	static function INFO return LogLevel,
	static function WARN return LogLevel,
	static function ERROR return LogLevel,
	static function FATAL return LogLevel,
	static function OFF return LogLevel,
	static function vals return log4_array

/*
Method Summary
 boolean	isAtLeastAsSpecificAs(int level) 
          Compares this level against the level passed as an argument and returns true if this level is the same or more specific.
 boolean	isAtLeastAsSpecificAs(Level level) 
          Compares this level against the level passed as an argument and returns true if this level is the same or more specific.
 boolean	lessOrEqual(int level) 
          Compares the specified Level against this one.
 boolean	lessOrEqual(Level level) 
          Compares the specified Level against this one.
static Level	toLevel(String sArg) 
          Converts the string passed as argument to a level.
static Level	toLevel(String name, Level defaultLevel) 
          Converts the string passed as argument to a level.
static Level	valueOf(String name) 
          Returns the enum constant of this type with the specified name.
static Level[]	values() 
          Returns an array containing the constants of this enum type, in the order they are declared.
*/

)
instantiable final;
/
show errors
