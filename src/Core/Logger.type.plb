create or replace type body LOGGER AS
  member function getName return VARCHAR2
	is
	begin
		return m_name;
	end;

	member function isEnabled(lvl IN LogLevel) return BOOLEAN
	is
	begin
		return isEnabled(lvl,NULL);
	END;

	member function isEnabled(lvl IN LogLevel, marker Marker) return BOOLEAN
	is
	begin
		return logimpl.isenabled(self, lvl,marker);
	END;

	member function isTraceEnabled return BOOLEAN
	is
	begin
	return isEnabled(logimpl.ll_TRACE,NULL);
	END;
	member function isDebugEnabled return BOOLEAN
	is
	begin
	return isEnabled(logimpl.ll_DEBUG,NULL);
	END;
	member function isInfoEnabled  return BOOLEAN
	is
	begin
	return isEnabled(logimpl.ll_INFO,NULL);
	END;
	member function isWarnEnabled  return BOOLEAN
	is
	begin
	return isEnabled(logimpl.ll_WARN,NULL);
	END;
	member function isErrorEnabled return BOOLEAN
	is
	begin
	return isEnabled(logimpl.ll_ERROR,NULL);
	END;
	member function isFatalEnabled return BOOLEAN
	is
	begin
	return isEnabled(logimpl.ll_FATAL,NULL);
	END;
	member function isTraceEnabled(marker Marker) return BOOLEAN
	is
	begin
	return isEnabled(logimpl.ll_TRACE,marker);
	END;
	member function isDebugEnabled(marker Marker) return BOOLEAN
	is
	begin
	return isEnabled(logimpl.ll_DEBUG,marker);
	END;
	member function isInfoEnabled(marker Marker)  return BOOLEAN
	is
	begin
	return isEnabled(logimpl.ll_INFO,marker);
	END;
	member function isWarnEnabled(marker Marker)  return BOOLEAN
	is
	begin
	return isEnabled(logimpl.ll_WARN,marker);
	END;
	member function isErrorEnabled(marker Marker) return BOOLEAN
	is
	begin
	return isEnabled(logimpl.ll_ERROR,marker);
	END;
	member function isFatalEnabled(marker Marker) return BOOLEAN
	is
	begin
	return isEnabled(logimpl.ll_FATAL,marker);
	END;

	member procedure log(lvl LogLevel, msg varchar2)
	is
	begin
	if isenabled(lvl,NULL) THEN
		logimpl.log(null,m_name,lvl,MessageFactory.newMessage(msg));
	end if;
	END;

	member procedure log(lvl LogLevel, marker Marker, msg varchar2)
	is
	begin
	if isenabled(lvl,marker) THEN
		logimpl.log(marker,m_name,lvl,MessageFactory.newMessage(msg));
	end if;
	END;

	member procedure log(lvl LogLevel, marker Marker, msg varchar2, throwable GenericException)
	is
	begin
	if isenabled(lvl,marker) THEN
		logimpl.log(marker,m_name,lvl,MessageFactory.newMessage(msg),throwable);
	end if;
	END;


	member procedure entry
	is
	begin
	if isenabled(logimpl.ll_TRACE,logimpl.ENTRY_MARKER) THEN
			logimpl.log(logimpl.ENTRY_MARKER,m_name,logimpl.ll_TRACE,NULL);
	end if;
	END;

	member procedure exit
	is
	begin
		if isenabled(logimpl.ll_TRACE,logimpl.EXIT_MARKER) THEN
			logimpl.log(logimpl.EXIT_MARKER,m_name,logimpl.ll_TRACE,NULL);
		end if;
	end;
	member function exit(result log4_object) return log4_object
	is
	begin
		if isenabled(logimpl.ll_TRACE,logimpl.EXIT_MARKER) THEN
			if result is null then
				logimpl.log(logimpl.EXIT_MARKER ,m_name, logimpl.ll_TRACE, MessageFactory.newMessage('exit'));
			else
				logimpl.log(logimpl.EXIT_MARKER ,m_name, logimpl.ll_TRACE, MessageFactory.newMessage('exit with ('||result.tostring||')'));
			end if;
		end if;
		return result;
	end;


	member procedure trace(MSG varchar2)
	is
	begin
	if isenabled(logimpl.ll_TRACE,NULL) THEN
			logimpl.log(NULL, m_name,logimpl.ll_TRACE,MessageFactory.newMessage(msg));
	end if;
	end;

	member procedure debug(MSG varchar2)
	is
	begin
	if isenabled(logimpl.ll_DEBUG,NULL) THEN
			logimpl.log(NULL, m_name, logimpl.ll_DEBUG,MessageFactory.newMessage(msg));
	end if;
	end;
	member procedure debug(m Marker,MSG varchar2)
	is
	begin
	if isenabled(logimpl.ll_DEBUG,m) THEN
			logimpl.log(m, m_name, logimpl.ll_DEBUG,MessageFactory.newMessage(msg));
	end if;
	end;

	member procedure info(MSG varchar2)
	is
	begin
	if isenabled(logimpl.ll_INFO,NULL) THEN
			logimpl.log(NULL, m_name, logimpl.ll_INFO,MessageFactory.newMessage(msg));
	end if;
	end;

	member procedure warn(MSG varchar2)
	is
	begin
	if isenabled(logimpl.ll_WARN,NULL) THEN
			logimpl.log(NULL,m_name,logimpl.ll_WARN,MessageFactory.newMessage(msg));
	end if;
	end;

	member procedure error(msg varchar2)
	is
	begin
	if isenabled(logimpl.ll_ERROR,NULL) THEN
			logimpl.log(NULL,m_name,logimpl.ll_ERROR,MessageFactory.newMessage(msg));
	end if;
	END;
	member procedure error(msg varchar2, throwable GenericException)
	is
	begin
	IF isenabled(logimpl.ll_ERROR,NULL) THEN
			logimpl.log(NULL,m_name,logimpl.ll_ERROR,MessageFactory.newMessage(msg),throwable);
	END IF;
	end;  

	member procedure fatal(msg varchar2)
	is
	begin
	if isenabled(logimpl.ll_FATAL,NULL) THEN
			logimpl.log(NULL,m_name,logimpl.ll_FATAL,MessageFactory.newMessage(msg));
	end if;
	END;
	member procedure fatal(msg varchar2, throwable GenericException)
	is
	begin
	IF isenabled(logimpl.ll_FATAL,NULL) THEN
			logimpl.log(NULL,m_name,logimpl.ll_FATAL,MessageFactory.newMessage(msg),throwable);
	end if;
	end;  

	--marker versions
	member procedure trace(m Marker, msg varchar2)
	is
	begin
	if isenabled(logimpl.ll_TRACE,m) THEN
			logimpl.log(m, m_name, logimpl.ll_TRACE,MessageFactory.newMessage(msg));
	end if;
	END;
	member procedure info(m Marker, msg varchar2)
	is
	begin
	if isenabled(logimpl.ll_INFO,m) THEN
			logimpl.log(m, m_name, logimpl.ll_INFO,MessageFactory.newMessage(msg));
	end if;

	END;
	member procedure warn(m Marker, msg varchar2)
	is
	begin
	if isenabled(logimpl.ll_WARN,m) THEN
			logimpl.log(m, m_name, logimpl.ll_WARN,MessageFactory.newMessage(msg));
	end if;
	END;
	member procedure error(m Marker, msg varchar2)
	is
	begin
	if isenabled(logimpl.ll_ERROR,m) THEN
			logimpl.log(m, m_name, logimpl.ll_ERROR,MessageFactory.newMessage(msg));
	end if;
	END;
	member procedure fatal(m Marker, msg varchar2)
	is
	begin
	if isenabled(logimpl.ll_FATAL,m) THEN
			logimpl.log(m, m_name, logimpl.ll_FATAL,MessageFactory.newMessage(msg));
	end if;
	END;


	member function exit(result VARCHAR2) return VARCHAR2
	is
	begin
		return result;
	end;
	member function exit(result NUMBER) return NUMBER
	is
	begin
		return result;
	end;
	member function exit(result DATE) return DATE
	is
	begin
		return result;
	end;
	member function exit(result TIMESTAMP ) return TIMESTAMP 
	is
	begin
		return result;
	end;
	member function exit(result TIMESTAMP WITH TIME ZONE) return TIMESTAMP WITH TIME ZONE
	is
	begin
		return result;
	end;

	member function exit(result BOOLEAN) return BOOLEAN
	is
	begin
		return result;
	end;

	map member function Compare return number 
	is
	begin
		return m_lvl;
	end;

	member procedure catching(throwable GenericException default GenericException() )
	is
	begin
		if isenabled(logimpl.ll_ERROR,logimpl.CATCHING_MARKER) THEN
			logimpl.log(logimpl.CATCHING_MARKER, m_name, logimpl.ll_ERROR,MessageFactory.newMessage('catching'),throwable);
		end if;
	end;
	member procedure catching(lvl LogLevel, throwable GenericException default GenericException() )
	is
	begin
		if isenabled(lvl,logimpl.CATCHING_MARKER) THEN
			logimpl.log(logimpl.CATCHING_MARKER, m_name, lvl,MessageFactory.newMessage('catching'),throwable);
		end if;
	end;




end;
/
show errors

