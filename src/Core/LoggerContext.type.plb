prompt CREATE OR REPLACE TYPE BODY LoggerContextImpl

CREATE OR REPLACE TYPE BODY LoggerContextImpl
AS
	overriding MEMBER FUNCTION getLogger(NAME VARCHAR2) RETURN Logger
	IS
	BEGIN
		NULL;
	end;  
	--Determine if the specified Logger exists.
	overriding MEMBER FUNCTION hasLogger(NAME VARCHAR2) RETURN boolean
	IS
	BEGIN
		return false;
	end;

	--constructors
	--Constructor taking only a name.
	constructor FUNCTION LoggerContextImpl(NAME VARCHAR2) RETURN self AS result
	IS
	BEGIN
		self.m_name := NAME;
		return;
	end;
	--Constructor taking a name and a reference to an external context.
	constructor function LoggerContextImpl(NAME varchar2, externalContext Ref log4_object) return self as result
	IS
	BEGIN
		self.m_name := NAME;
		self.m_externalContext := externalContext;
		return;
	end;
	--Constructor taking a name external context and a configuration location String.
	constructor FUNCTION LoggerContextImpl(NAME VARCHAR2, externalContext Ref log4_object, configLocn VARCHAR2) RETURN self AS result
	IS
	BEGIN
		self.m_name := NAME;
		self.m_externalContext := externalContext;

		IF trim(configLocn) IS NOT NULL THEN
		BEGIN
			self.m_configLocation := utlfileuritype(configLocn);
		exception
			WHEN others THEN
				self.m_configLocation := NULL;
		END;
		END IF;
		return;
	end;
	--Constructor taking a name, external context and a configuration URI.
	constructor function LoggerContextImpl(NAME varchar2, externalContext Ref log4_object, configLocn URITYPE) return self as result
	IS
	BEGIN
		self.m_name := NAME;
		self.m_externalContext := externalContext;
		self.m_configLocation := configLocn;
		RETURN;
	END;


	--implementation details
	--ADD A FILTER TO THE Configuration.
	MEMBER PROCEDURE addFilter(FILTER FILTER )
	IS
	BEGIN
		m_config.addFilter(filter);
	END;

	--Gets the name.
	member function getName return varchar2
	IS
	BEGIN
		return m_name;
	END;
	--Reconfigure the context.
	member procedure reconfigure
	IS
	BEGIN
		null;
	END;

	--Removes a Filter from the current Configuration.
	member procedure removeFilter(Filter filter)
	IS
	BEGIN
		m_config.removeFilter(filter);

	END;
	--Cause ALL Loggers TO be UPDATED against THE CURRENT Configuration.
	member procedure updateLoggers
	IS
	BEGIN
		updateLoggers(self.m_config);
	END;

	MEMBER PROCEDURE updateLoggers(config Configuration )
	IS
	BEGIN
		NULL;
	END;


	overriding MEMBER FUNCTION 	getExternalContext RETURN REF log4_object
	IS
	BEGIN
		return m_externalcontext;
	END;

END ;
/
show errors
