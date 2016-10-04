declare
--L_LOG LOG4_LOGGER := LOG4MANAGER.GETLOGGER();
L_LOG LOGGER := LOGMANAGER.GETLOGGER();

V_START_TIME timestamp;
V_End_Time Timestamp;
Procedure Innertest Is
Begin
L_Log.Debug('inner hello');

For I In 1 .. Utl_Call_Stack.Dynamic_Depth Loop
Dbms_Output.Put_Line(I);
Dbms_Output.Put_Line('owner:'||Utl_Call_Stack.owner(I));
Dbms_Output.Put_Line('prog:'||Utl_Call_Stack.Concatenate_Subprogram(Utl_Call_Stack.Subprogram(I)));
Dbms_Output.Put_Line('line:'||Utl_Call_Stack.Unit_Line(I));
Dbms_Output.Put_Line('lex :'||Utl_Call_Stack.lexical_depth(I));

--
end loop;
End;


begin
V_START_TIME := systimestamp;

logmanager.ll_trace_enabled := true;
logmanager.ll_debug_enabled := true;
logmanager.ll_info_enabled := TRUE;
logmanager.ll_warn_enabled := TRUE;
logmanager.ll_error_enabled := TRUE;

L_LOG.entry;
L_Log.Trace('hello world');
L_Log.Debug('hello world');
L_LOG.debug('marker','hello world');
L_Log.Info('hello world');
L_LOG.info('marker','hello world');
L_LOG.warn('hello world warn');
L_LOG.error('hello world error');
L_LOG.fatal('hello world fatal');
--L_LOG.log(LogLevel(999),'hello world');

L_LOG.debug('about to trace all objects');
For X In (Select * From User_Objects  Order By Object_Name, Object_Type) Loop
Dbms_Output.Put_Line('object_name:'||X.Object_Name||' '||X.Object_Type);
--L_Log.Info('object_name:'||X.Object_Name||' type:'||X.Object_Type);
--LogManager.log(LogManager.ll_INFO,NULL,'object_name:'||X.Object_Name||' type:'||X.Object_Type);
end loop;

--for I in 1 .. C LOOP
--L_LOG.trace('object_name:'||I);
--end loop;

L_LOG.exit;
Innertest;

V_end_TIME := systimestamp;
dbms_output.put_line('elapsed:'||(v_end_time-v_start_time) );

END;
/
