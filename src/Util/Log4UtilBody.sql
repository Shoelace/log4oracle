/** 
* Copyright 2011 Juergen Lipp
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
* 
*     http://www.apache.org/licenses/LICENSE-2.0
* 
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

create or replace 
package body Log4Util as

PROCEDURE who_called_me
(
    owner OUT VARCHAR2,
    name OUT VARCHAR2,
    lineno OUT NUMBER,
    caller_t OUT VARCHAR2 ,
    depth NUMBER DEFAULT 1)
AS
--depth based version
  call_stack  VARCHAR2(4096) DEFAULT dbms_utility.format_call_stack;
  n           NUMBER;
  found_stack BOOLEAN DEFAULT FALSE;
  line        VARCHAR2(255);
  cnt         NUMBER := 0;
BEGIN
  --dbms_output.put_line(call_stack);
  --
  LOOP
    n := instr( call_stack, chr(10) );
    EXIT
  WHEN ( n IS NULL OR n = 0 );
    --
    line       := SUBSTR( call_stack, 1, n-1 );
    call_stack := SUBSTR( call_stack, n   +1 );
    --
    IF ( NOT found_stack ) THEN
      IF ( line LIKE '%handle%number%name%' ) THEN
        found_stack := TRUE;
      END IF;
    ELSE
      cnt := cnt + 1;
      -- cnt = 1 is ME
      -- cnt = 2 is MY Caller
      -- cnt = 3 is Their Caller
      IF ( cnt = (2+depth) ) THEN
        --dbms_output.put_line('         1         2         3');
        --dbms_output.put_line('123456789012345678901234567890');
        --dbms_output.put_line(line);
        --format '0x70165ba0       104  package body S06DP3.LOGMANAGER'
        lineno := to_number(SUBSTR( line, 13, 8 ));
        line   := SUBSTR( line, 23 ); --set to rest of line .. change from 21 to 23
        IF ( line LIKE 'pr%' ) THEN
          n := LENGTH( 'procedure ' );
        elsif ( line LIKE 'fun%' ) THEN
          n := LENGTH( 'function ' );
        elsif ( line LIKE 'package body%' ) THEN
          n := LENGTH( 'package body ' );
        elsif ( line LIKE 'pack%' ) THEN
          n := LENGTH( 'package ' );
        elsif ( line LIKE 'anonymous%' ) THEN
          n := LENGTH( 'anonymous block ' );
        ELSE
          n := NULL;
        END IF;
        IF ( n     IS NOT NULL ) THEN
          caller_t := ltrim(rtrim(upper(SUBSTR( line, 1, n-1 ))));
        ELSE
          caller_t := 'TRIGGER';
        END IF;
        line  := SUBSTR( line, NVL(n,1) );
        n     := instr( line, '.' );
        owner := ltrim(rtrim(SUBSTR( line, 1, n-1 )));
        name  := LTRIM(RTRIM(SUBSTR( LINE, N   +1 )));
        EXIT;
      END IF;
    END IF;
  END LOOP;
END who_called_me;

end Log4Util;
/
