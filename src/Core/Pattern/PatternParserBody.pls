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

create or replace package body PatternParser as

	m_converterRules PatternConverterMap;

	m_PatternFormatters PatternFormatterArray;


	procedure ProcessConverter(converter map_entry, options varchar2, leftAlign boolean, minLength number, maxLength number) is
	  i number;
	  align NUMBER;
    fi formattinginfo;
	BEGIN

		if leftAlign then
			align := 1;
		else
			align := 0;
		END IF;
fi := formattinginfo(leftAlign,minlength,maxlength);

--dbms_output.put_line('create instance of:'||converter.VALUE ||' for '||converter.KEY ||' '||fi.toString());
	  --m_converters.EXTEND(1);
    m_PatternFormatters.EXTEND(1);
--dbms_output.put_line('begin :a := PatternFormatter('||converter.VALUE||'(:b) , :c); end;');

EXECUTE IMMEDIATE 'begin :a := PatternFormatter('||converter.VALUE||'(:b) , :c); end;' USING IN OUT m_PatternFormatters(m_PatternFormatters.LAST), options, fi;

--patternFormatter( converter, formatting info)

--TODO create format info

--								ProcessConverter(matches(m).Key, matches(m).Value, LeftAlign, MinTextWidth, MaxTextWidth);
--		i := m_converters.LAST;
		--m_converters(i) := m_converterRules(m);

		--m_converters(i).m_min := MinTextWidth;
		--m_converters(i).m_max := MaxTextWidth;
		--m_converters(i).m_leftAlign := LeftAlign;

	end;

	procedure ProcessLiteral(text varchar2) is
	begin
		IF LENGTH(text) > 0 THEN
			ProcessConverter(m_converterRules('literal'),text, false, 0, 2147483647);
		end if;
	end;

	function ParseInternal(pattern varchar2) return PatternFormatterArray is
		offset number := 1;
		i number;
		remainingStringLength number;
		LeftAlign boolean;
		MinTextWidth number := 0;
		MaxTextWidth NUMBER := 2147483647;
    m varchar2(200);
	begin
		-- Initialize new pattern
		--m_converters := new PatternConverterArray();
    m_PatternFormatters := new PatternFormatterArray();

		while offset < LENGTH(pattern) loop
			i := instr(pattern, '%', offset);
			if (i < 1 or i = length(pattern)) then
				ProcessLiteral(substr(pattern, offset));
				offset := length(pattern);
			ELSE

				IF substr(pattern, i+1, 1) = '%' THEN
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

					remainingStringLength := LENGTH(pattern) - (offset - 1);

					-- Look for pattern
					--FOR m IN m_converterRules.FIRST..m_converterRules.LAST loop
          m := m_converterRules.LAST;
          while (m IS NOT NULL) LOOP
						if length(m) <= remainingStringLength then
							if substr(pattern, offset, length(m)) = m then
								-- Found match
								offset := offset + length(m);

								-- Look for option
								/** TODO */
                --dbms_output.put_line('look for options:'||substr(pattern,offset) );

                IF substr(pattern, offset, 1) = '{' THEN
                  i := instr(pattern, '}', offset);
                 -- dbms_output.put_line('FOUND OPTIONS:'||substr(pattern, offset, i - offset+1 ));
                  processconverter(m_converterRules(m), substr(pattern, offset+1, i - offset ), LeftAlign, MinTextWidth,MaxTextWidth);
                  offset := i+1;
                ELSE
                 processconverter(m_converterRules(m), NULL, LeftAlign, MinTextWidth,MaxTextWidth);

                END IF;


								exit;

							end if;
						END IF;
            m := m_converterRules.prior(m);

					end loop;
				end if;
			end if;
		end loop;

    --FOR z IN m_converters.FIRST .. m_converters.LAST LOOP
    --dbms_output.put_line(z||':'||m_converters(z).getName());
    --end loop;

		-- Remove ending newline pattern due to usage of PUT_LINE
		--IF m_converters IS NOT NULL AND m_converters(m_converters.LAST).NAME IN ('LINESEPARATORPATTERNCONVERTER') THEN
--			m_converters.DELETE(m_converters.LAST);
		--END IF;

		return m_PatternFormatters;
	end;


	function Parse(pattern varchar2) return PatternFormatterArray is
	begin

		return ParseInternal(pattern);
	end;

BEGIN
--m_converterRules := PatternConverterMap();

--make sure literal is id:1
--m_converterRules.extend;
--m_converterRules('literal').KEY := 'literal';
--m_converterRules('literal').value := 'EIPatternConverter';


	--a list of all available pattern converters with their key
  DECLARE
k VARCHAR2(2000);
key varchar2(2000);
offset number :=1;
BEGIN

for pc in (SELECT type_name
FROM all_types
WHERE INSTANTIABLE = 'YES'
CONNECT BY  supertype_name = PRIOR type_name
START WITH type_name = 'PATTERNCONVERTER'
) LOOP

execute immediate 'begin :k := '||pc.type_name||'.converterkeys(); end;' using out k;

while k IS NOT NULL loop

offset := instr(k,' ');
IF offset  = 0 THEN
offset := LENGTH(k)+1;
end if;

KEY := substr(k,1,offset-1);

m_converterRules(key).KEY := key;
m_converterRules(key).value := pc.type_name;

--dbms_output.put_line(m_converterRules(key).KEY||','||m_converterRules(key).value);
k := substr(k,offset+1); --pass over seperator

end loop;
END LOOP;

END;

--these should all be replace by individual objects
/*
	m_globalRulesRegistry := NEW PatternConverterArray(

		NEW EIPatternConverter('c',        'event.getLoggername()'),
		new EIPatternConverter('logger',   'event.getLoggername()'),

		NEW EIPatternConverter('f',        '''filename'''),


		NEW EIPatternConverter('L',         q'[(case when event is null or event.getSource() is null then '?2' else event.getSource().getLineNumber() end)]'),
		NEW EIPatternConverter('line',      q'[(case when event is null or event.getSource() is null then '?3' else event.getSource().getLineNumber() end)]'),

		NEW EIPatternConverter('M',         '''Method'''),
		NEW EIPatternConverter('method',         '''Method'''),

		NEW EIPatternConverter('r',         '0'),
		NEW EIPatternConverter('relative',         '0'),

		NEW EIPatternConverter('t',         'event.getThreadName()'),

		NEW EIPatternConverter('utcdate',   q'[to_char(event.getTimestamp() at time zone 'UTC', 'yyyy-mm-dd hh24:mi:ss,ff3')]'),
		NEW EIPatternConverter('utcDate',   q'[to_char(event.getTimestamp() at time zone 'UTC', 'yyyy-mm-dd hh24:mi:ss,ff3')]'),
		new EIPatternConverter('UtcDate',   q'[to_char(event.getTimestamp() at time zone 'UTC', 'yyyy-mm-dd hh24:mi:ss,ff3')]'),

		new EIPatternConverter('w',         'event.UserName'),
		NEW EIPatternConverter('username',  'event.UserName'));
*/

END PatternParser;
/
show errors