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
package body PatternParser as
	
	m_converterRules PatternConverterMap;
  
	m_converters PatternConverterArray;
	

	procedure ProcessConverter(converterName varchar2, options varchar2, leftAlign boolean, minLength number, maxLength number) is
	  i number;
	  align number;
	BEGIN
  /*
		if leftAlign then
			align := 1;
		else
			align := 0;
		end if;
	
		--LogLog.Debug('Converter ['||converterName||'] Option ['||options||'] Format [min='||minLength||',max='||maxLength||',leftAlign='||align||']');
		
		m_converters.EXTEND(1);
		i := m_converters.LAST;
		m_converters(i) := new EIPatternConverter(converterName, options);
		
		m_converters(i).m_min := minLength;
		m_converters(i).m_max := maxLength;
		m_converters(i).m_leftAlign := align;
	*/
  null;
	end;
  
	procedure ProcessLiteral(text varchar2) is
	begin
		if length(text) > 0 then
			ProcessConverter('literal', ''''||text||'''', false, 0, 2147483647);
		end if;
	end;
	
	function ParseInternal(pattern varchar2) return PatternConverterArray is
		offset number := 1;
		i number;
		remainingStringLength number;
		LeftAlign boolean;
		MinTextWidth number := 0;
		MaxTextWidth number := 2147483647;
	begin
		-- Initialize new pattern
		m_converters := new PatternConverterArray();
		
		while offset < length(pattern) loop
			i := instr(pattern, '%', offset);
			if (i < 1 or i = length(pattern)) then
				ProcessLiteral(substr(pattern, offset));
				offset := length(pattern);
			else
				if substr(pattern, i+1, 1) = '%' then
					-- Escaped
					ProcessLiteral(substr(pattern, offset, i - offset + 1));
					offset := i + 2;
				else
					ProcessLiteral(substr(pattern, offset, i - offset));
					offset := i + 1;
					
					LeftAlign := false;
					MinTextWidth := 0;
					MaxTextwidth := 2147483647;
					-- Process formatting options

					-- Look for the align flag
					if offset <= length(pattern) then
						if substr(pattern, offset, 1) = '-' then
							LeftAlign := true;
							offset := offset + 1;
						end if;
					end if;
					
					-- Look for the minimum length
					while (offset <= length(pattern) and 
					       translate(substr(pattern, offset, 1), 'a1234567890', 'a') is null) loop
						-- Seen digit
						if MinTextWidth < 0 then
							MinTextWidth := 0;
						end if;
						MinTextWidth := (MinTextWidth * 10) + to_number(substr(pattern, offset, 1));
						offset := offset + 1;
					end loop;
					
					-- Look for the separator between min and max
					if offset <= length(pattern) then
						if substr(pattern, offset, 1) = '.' then
							offset := offset + 1;
						end if;
					end if;
					
					-- Look for the maximum length
					while (offset <= length(pattern) and 
					       translate(substr(pattern, offset, 1), 'a1234567890', 'a') is null) loop
						-- Seen digit
						if MaxTextWidth >= 2147483647 then
							MaxTextWidth := 0;
						end if;
						MaxTextWidth := (MaxTextWidth * 10) + to_number(substr(pattern, offset, 1));
						offset := offset + 1;
					end loop;

					remainingStringLength := length(pattern) - (offset - 1);
					
					-- Look for pattern
					for m in m_converterRules.FIRST..m_converterRules.LAST loop
						if length(m_converterRules(m).Key) <= remainingStringLength then
							if substr(pattern, offset, length(m_converterRules(m).Key)) = m_converterRules(m).Key then
								-- Found match
								offset := offset + length(m_converterRules(m).Key);
								
								-- Look for option
								/** TODO */
                dbms_output.put_line('look for options:'||substr(pattern,offset) );
                
                IF substr(pattern, offset, 1) = '{' THEN
                i := instr(pattern, '}', offset);
                dbms_output.put_line('FOUND OPTIONS:'||substr(pattern, offset, i - offset+1 ));
                offset := i+1;
                
                end if;
								
--								ProcessConverter(matches(m).Key, matches(m).Value, LeftAlign, MinTextWidth, MaxTextWidth);
	--m_converters.EXTEND(1);
--		i := m_converters.LAST;
		--m_converters(i) := m_converterRules(m);
		
		--m_converters(i).m_min := MinTextWidth;
		--m_converters(i).m_max := MaxTextWidth;
		--m_converters(i).m_leftAlign := LeftAlign;

								exit;
								
							end if;
						end if;
					end loop;
				end if;
			end if;
		end loop;
		
		-- Remove ending newline pattern due to usage of PUT_LINE
		--if m_converters IS NOT NULL AND m_converters(m_converters.LAST).Key in ('n', 'newline') then
--			m_converters.DELETE(m_converters.LAST);
		--end if;
		
		return m_converters;
	end;

	
	function Parse(pattern varchar2) return PatternConverterArray is
	begin
	
		return ParseInternal(pattern);
	end;
	
BEGIN
m_converterRules := PatternConverterMap();

	--a list of all availabel patter convertes with their key
  DECLARE
k VARCHAR2(2000);
offset number :=1;
BEGIN

for pc in (SELECT type_name
FROM user_types
WHERE INSTANTIABLE = 'YES'
CONNECT BY  supertype_name = PRIOR type_name
START WITH type_name = 'PATTERNCONVERTER') LOOP

execute immediate 'begin :k := '||pc.type_name||'.converterkeys(); end;' using out k;

while k IS NOT NULL loop

offset := instr(k,' ');
IF offset  = 0 THEN
offset := LENGTH(k);
end if;

m_converterRules.EXTEND;
m_converterRules(m_converterRules.LAST).KEY := substr(k,1,offset-1);
m_converterRules(m_converterRules.LAST).value := pc.type_name;

dbms_output.put_line(substr(k,1,offset)||','||pc.type_name);
k := substr(k,offset+1);

end loop;
END LOOP;

END;


/*
	m_globalRulesRegistry := NEW PatternConverterArray(
		NEW EIPatternConverter('literal',  NULL),
		new EIPatternConverter('newline',  'chr(13)||chr(10)'),
		new EIPatternConverter('n',        'chr(13)||chr(10)'),
		
		NEW EIPatternConverter('c',        'event.getLoggername()'),
		new EIPatternConverter('logger',   'event.getLoggername()'),
		
		new EIPatternConverter('date',     'to_char(event.getTimestamp(), ''yyyy-mm-dd hh24:mi:ss,ff3'')'),
		NEW EIPatternConverter('d',        'to_char(event.getTimestamp(), ''yyyy-mm-dd hh24:mi:ss,ff3'')'),
		
		NEW EIPatternConverter('exception', 'event.ExceptionString.Format()'),
		NEW EIPatternConverter('ex',        'event.ExceptionString.Format()'),
		NEW EIPatternConverter('throwable', 'event.ExceptionString.Format()'),

		NEW EIPatternConverter('f',        '''filename'''),

		new EIPatternConverter('p',         'event.getLevel().m_name'),
		NEW EIPatternConverter('level',     'event.getLevel().m_Name'),

		NEW EIPatternConverter('location',  q'[(case when event is null or event.getSource() is null then '?1' else event.getSource().toString() end)]'),
		NEW EIPatternConverter('L',         q'[(case when event is null or event.getSource() is null then '?2' else event.getSource().getLineNumber() end)]'),
		NEW EIPatternConverter('line',      q'[(case when event is null or event.getSource() is null then '?3' else event.getSource().getLineNumber() end)]'),
		NEW EIPatternConverter('l',         q'[(case when event is null or event.getSource() is null then '?4' else event.getSource().toString() end)]'),
    
		
		NEW EIPatternConverter('msg',       q'[(case when event is null or event.getMessage() is null then '' else event.getMessage().getFormattedMessage() end)]'),
		new EIPatternConverter('message',   q'[(case when event is null or event.getMessage() is null then '' else event.getMessage().getFormattedMessage() end)]'),

		NEW EIPatternConverter('M',         '''Method'''),
		NEW EIPatternConverter('method',         '''Method'''),
		
		NEW EIPatternConverter('marker',         q'[(case when event is null or event.getMarker() is null then '' else event.getMarker().toString() end)]'),
--need to put single char last
		NEW EIPatternConverter('m',         q'[(case when event is null or event.getMessage() is null then '' else event.getMessage().getFormattedMessage() end)]'),



		NEW EIPatternConverter('r',         '0'),
		NEW EIPatternConverter('relative',         '0'),

		NEW EIPatternConverter('t',         'event.getThreadName()'),
		
		NEW EIPatternConverter('utcdate',   q'[to_char(event.getTimestamp() at time zone 'UTC', 'yyyy-mm-dd hh24:mi:ss,ff3')]'),
		NEW EIPatternConverter('utcDate',   q'[to_char(event.getTimestamp() at time zone 'UTC', 'yyyy-mm-dd hh24:mi:ss,ff3')]'),
		new EIPatternConverter('UtcDate',   q'[to_char(event.getTimestamp() at time zone 'UTC', 'yyyy-mm-dd hh24:mi:ss,ff3')]'),
		
    NEW NDCPatternConverter('x'),
    NEW NDCPatternConverter('NDC'),

    NEW MDCPatternConverter('X'),
    NEW MDCPatternConverter('MDC'),
    NEW MDCPatternConverter('mdc'),
    
		new EIPatternConverter('w',         'event.UserName'),
		NEW EIPatternConverter('username',  'event.UserName'));
*/

end PatternParser;
/
