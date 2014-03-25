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
type  NDCPatternConverter 
under    PatternConverter 
(
	--static function Convert(event LogEvent, value varchar2) return varchar2,
	
	constructor function NDCPatternConverter(key varchar2) return self as result,
	
	overriding member function Format(event LogEvent) return varchar2
	
);
/
show errors


create or replace 
type body NDCPatternConverter as

	constructor function NDCPatternConverter(key varchar2) return self as result is
	begin
		self.Key := key;
		return;
	end;

	overriding member function Format(event LogEvent) return varchar2 is
		msg varchar2(32767);
		len number;
		stk ThreadContextContextStack := event.getContextStack();
	begin
		LOOP
			exit when stk.getDepth() = 0;
			msg := msg ||','||stk.pop();
		end loop;

		return ltrim(msg,',');
	exception
		when others then
			return 'NDC:error!'||self.key||'@'||'#'||sqlerrm;
	end;
end;
/
show errors

