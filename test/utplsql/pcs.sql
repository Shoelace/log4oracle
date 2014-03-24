create or replace
  procedure Print_Call_Stack
  as
    Depth pls_integer := sys.UTL_Call_Stack.Dynamic_Depth();
   procedure headers
   is
   begin
       dbms_output.put_line( 'Lexical   Depth   Line    Name' );
       dbms_output.put_line( 'Depth             Number      ' );
       dbms_output.put_line( '-------   -----   ----    ----' );
   end headers;
   procedure print
   is
   begin
       headers;
       for j in reverse 1..Depth loop
         DBMS_Output.Put_Line(
           rpad( sys.utl_call_stack.lexical_depth(j), 10 ) ||
                   rpad( j, 7) ||
           rpad( To_Char(sys.UTL_Call_Stack.Unit_Line(j), '99'), 9 ) ||
           sys.UTL_Call_Stack.Concatenate_Subprogram
                      (sys.UTL_Call_Stack.Subprogram(j)));
       end loop;
   end;
 begin
   print;
 end;
/
