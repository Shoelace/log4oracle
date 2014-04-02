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
type  LiteralPatternConverter 
under    LogEventPatternConverter 
(
	value VARCHAR2(2000),
	--static function Convert(event LogEvent, value varchar2) return varchar2,
	
	constructor function LiteralPatternConverter(options varchar2) return self as result,
	
	overriding MEMBER FUNCTION Format(event LogEvent) RETURN VARCHAR2
	, static FUNCTION ConverterKeys RETURN VARCHAR2
  
);
/
show errors


create or replace 
type body LiteralPatternConverter as

  static FUNCTION ConverterKeys RETURN VARCHAR2
  IS
  BEGIN
    RETURN 'literal';
  end;

	constructor function LiteralPatternConverter(options varchar2) return self as result is
	begin
		self.name := $$PLSQL_UNIT;
		self.value := options;
		return;
	end;

	overriding member function Format(event LogEvent) return varchar2 is
	begin
		return value;
	end;
end;
/
show errors

