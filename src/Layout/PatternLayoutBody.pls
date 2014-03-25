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
prompt create or replace type body PatternLayout 

create or replace 
type body PatternLayout as
	
	overriding member procedure ActivateOptions is
	begin
		self.m_converters := PatternParser.Parse(self.ConversionPattern);
		null;
	end;
	
	overriding member function Format(event LogEvent) return varchar2 is
		l_converters PatternConverterArray := self.m_converters;
		l_index number;
		l_message varchar2(32767);
	begin
		if event is null then
			raise Log4Util.ArgumentNullException;
		end if;
		
		l_index := l_converters.FIRST;
		while l_index is not null loop
			l_message := l_message||l_converters(l_index).Format(event);
			l_index := l_converters.NEXT(l_index);
		end loop;
		
		return l_message;
	end;
	
	constructor function PatternLayout return self as result is
	begin
--self.ConversionPattern := '%message%newline';
self.ConversionPattern := '%d %-5level - %m%newline';
		self.IgnoresException := 1;
		return;
	end;
  
  constructor FUNCTION PatternLayout(pattern VARCHAR2) RETURN self AS result
  IS
		BEGIN
    --self.ConversionPattern := '%message%newline';
    self.ConversionPattern := pattern;
		self.IgnoresException := 1;
		RETURN;
	end;
end;
/
show errors
