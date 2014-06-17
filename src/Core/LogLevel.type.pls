create or replace
TYPE LogLevel
AUTHID DEFINER
under log4_object
(

	/* The name of this level. */
	m_name varchar2(255),
	/* The value of this level. */
	m_value INTEGER

	
	,constructor function LogLevel(self in out nocopy LogLevel, LogLevel BINARY_INTEGER) return self as result

	/* Returns log level value as an indication of relative values to be sortable. */
	,overriding map member function Compare return VARCHAR2
	,overriding member function toString RETURN VARCHAR2

	,member function intLevel return NUMBER

	,static function ll_ALL return LogLevel
	,static function TRACE return LogLevel
	,static function DEBUG return LogLevel
	,static function INFO return LogLevel
	,static function WARN return LogLevel
	,static function ERROR return LogLevel
	,static function FATAL return LogLevel
	,STATIC FUNCTION OFF RETURN LogLevel
	,STATIC FUNCTION vals RETURN log4_array

  -- Compares this level against the level passed as an argument and returns true if this level is the same or more specific.
  ,MEMBER FUNCTION isAtLeastAsSpecificAs(lvl INTEGER) RETURN boolean
  --Compares this level against the level passed as an argument and returns true if this level is the same or more specific.
  ,member function isAtLeastAsSpecificAs(lvl LogLevel) return boolean
          
  --Compares the specified Level against this one.          
  ,member function lessOrEqual(lvl integer) return boolean
  
  --Compares the specified Level against this one.          
  ,member function lessOrEqual(lvl  LogLevel) return boolean


  /** Return the Level assoicated with the name or null if the Level cannot be found. */
  ,STATIC FUNCTION getLevel( name VARCHAR2)  RETURN LogLevel


  /** Converts the string passed as argument to a level. */
  ,STATIC FUNCTION toLevel( sArg VARCHAR2)  RETURN LogLevel
  --Converts the string passed as argument to a level.
  ,STATIC FUNCTION toLevel( name varchar2, defaultLevel LogLevel)  return LogLevel

/*          
static Level	valueOf(String name) 
          Returns the enum constant of this type with the specified name.
static Level[]	values() 
          Returns an array containing the constants of this enum type, in the order they are declared.
*/

)
instantiable final;
/
show errors
