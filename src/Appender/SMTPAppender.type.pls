prompt create or replace TYPE SMTPAppender 

create or replace
TYPE SMTPAppender 
under Appender
(
 constructor function SMTPAppender(name VARCHAR2, filter Filter, layout Layout,ignoreExceptions boolean ) return self as result

	,overriding member procedure append(event LogEvent) 


)
final instantiable ;
/
show errors


create or replace
TYPE BODY SMTPAppender 
as
	
 constructor function SMTPAppender(name VARCHAR2, filter Filter, layout Layout,ignoreExceptions boolean ) return self as result
	IS
	BEGIN
		self.m_name := name;
		self.m_layout := layout;
		self.m_filter := filter;
		NULL;
		return;
	END;

	overriding member procedure append(event LogEvent) 
	IS
	  PRAGMA AUTONOMOUS_TRANSACTION; 
    
    ll    LogLevel := event.getLevel();
    --t     GenericException := event.getthrown();
    --m     Message := event.GetMessage();
    --msg   log_table.logmessage%TYPE := m.getformattedmessage();
    --cm    ThreadContextContextMap := event.getContextMap();

		dolog boolean := true;
		
	BEGIN
		--if isfiltered() then
		--end if;
		if dolog THEN
			dbms_output.put_line('EMAIL');
			send_mail(p_to   => 'dsplbrun@abdn.ac.uk'
					 ,p_from => 'log4@esbdev'
					,p_subject => 'LOG4 message'
					,p_text_msg => m_layout.format(event)
				,p_smtp_host =>'mail.abdn.ac.uk'
			);
		END IF;
	END;

end;
/
show errors


