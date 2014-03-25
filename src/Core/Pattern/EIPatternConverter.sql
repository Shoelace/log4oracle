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
type EIPatternConverter
under PatternConverter
(
	/**
	* @headcom
	*/
	
	member function Convert(event LogEvent, value varchar2) return varchar2,
	
	constructor function EIPatternConverter(key varchar2, value varchar2) return self as result,
	
	overriding member function Format(event LogEvent) return varchar2
	
) not final;
/
show errors
