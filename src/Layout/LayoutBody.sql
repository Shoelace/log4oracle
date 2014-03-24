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

--this is really Abstract Layout but its called Layout because PL/SQL does not have interface types
prompt create or replace type body Layout 

create or replace 
type body Layout as
	
	not final member procedure ActivateOptions is
	begin
		null;
	end;
	
	not final member function Format(event LogEvent) return varchar2 is
	begin
		null;
		return 'not implemented';
	end;
	
	member function GetContentType return varchar2 is
	begin
		return 'text/plain';
	end;
	
	constructor function Layout return self as result is
	begin
		self.IgnoresException := 1;
		return;
	end;
	
end;
/
show errors
