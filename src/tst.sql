set serveroutput on size unlimited
--alter package logimpl compile;
--alter package threadcontext compile;
--alter package patternparser compile;
--exec dbms_session.modify_package_state(DBMS_SESSION.REINITIALIZE);

declare
    --get instance of logger
    l Logger := logmanager.getlogger('mytestlogger');
    m log4.Marker := log4.markermanager.getmarker('lastrundate');
procedure mydolog is
procedure dolog is
v number;
begin
    l.entry;
    l.trace('hello world trace');
    L.debug('hello world debug');
    L.DEBUG('{} {} {}', 'hello' ,'parameter','world');
    l.INFO('hello world info');
    l.INFO(m,'hello world info with a marker');
    l.WARN('hello world warn');
    l.error('hello world error');
    l.FATAL('hello world fatal');
    L.DEBUG('hello world debug');
    L.DEBUG(m,'hello world debug with a marker');
    v := l.exit(3);
end;
BEGIN
ThreadContext.push('level1');
ThreadContext.put('level','1');
ThreadContext.put('batch_id','crap');
--print_call_stack;
dolog;
--raise no_data_found;
end;

BEGIN
dbms_output.put_line('begin'); 
--  dolog;
  mydolog;
dbms_output.put_line('end'); 

exception
when others then
l.catching();
 dbms_output.put_line(SQLERRM); 
end;
/
/*
DECLARE
      cs utl_call_stack.callstack;
    --Depth pls_integer := UTL_Call_Stack.Dynamic_Depth();
  BEGIN
  dbms_output.put_line(dbms_utility.format_call_stack);  
 --dbms_output.put_line('depth:'||Depth);  
    cs := utl_call_stack.getcallstack;
       FOR j IN  cs.FIRST..cs.LAST loop
         DBMS_Output.Put_Line( utl_lms.format_message('%s - %s - %s - %s', cs(j).handle , to_char(cs(j).line), cs(j).caller_type, cs(j).object_name ) );
      
       end loop;
end;

*/
