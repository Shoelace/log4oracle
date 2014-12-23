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
type LogEventPatternConverter
under PatternConverter
(
	/**
	* @headcom
	*/
	
	
	member function Format(event LogEvent) return varchar2
	,overriding member function Format(obj log4_object) return varchar2
	--,member function getName return varchar2
	--,member function getStyleClass return varchar2
	,member function handlesThrowable return boolean
	
) not final not instantiable;
/
show errors

create or replace 
type body LogEventPatternConverter
as
	overriding member function Format(obj log4_object) return varchar2
	is
	begin
		if obj is of (LogEvent) then
			return Format(treat (obj as LogEvent));
		end if;
		return null;
	end;

	member function Format(event LogEvent) return varchar2
	is
	begin
		raise log4util.notimplementedexception;
	end;
	--,member function getName return varchar2
	--,member function getStyleClass return varchar2
	member function handlesThrowable return boolean
	is
	begin
		return false;
	end;
end;
/
show errors
