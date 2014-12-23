prompt CREATE OR REPLACE TYPE DefaultConfiguration 

CREATE OR REPLACE TYPE DefaultConfiguration 
UNDER Configuration
(
        /**
039         * The name of the default configuration.
040         *
041        public static final String DEFAULT_NAME = "Default";
042        /**
043         * The System Property used to specify the logging level.
044         *
045        public static final String DEFAULT_LEVEL = "org.apache.logging.log4j.level";
046        /**
047         * The default Pattern used for the default Layout.
048         *
049        PUBLIC STATIC FINAL String DEFAULT_PATTERN = "%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n";
050    
*/

 constructor function DefaultConfiguration  return self as result

);
/
show errors

create or replace
TYPE body DefaultConfiguration 
AS
  constructor function DefaultConfiguration return self as result
	as
		app Appender;
		k_layout layout;
	BEGIN
		--dbms_output.put_line('MarkerImpl(name):'||name);
		self.m_name := 'DEFAULT';
		--k_layout := PatternLayout('%date %5level %logger - %marker - %l - %m %ex%n');

		k_layout := PatternLayout('%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n' );

		app := DBMSOutputAppender('dbmsoutput',null,k_layout,false);
		--addAppender(app);
 --final LoggerConfig root = getRootLogger();
--065            root.addAppender(appender, null, null);
--root.setLevel(LogLevel.ERROR);

		return;
	end;

--@Override
--074        protected void doConfigure() {
--075        }

end;
/
show errors

