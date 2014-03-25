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
type PatternConverter
AUTHID DEFINER
as object
(
	/**
	* @headcom
	*/
	
	Key varchar2(255),
	Value varchar2(2000),
	
	/** formatting info */
	m_min number,
	m_max number,
	m_leftAlign number

	
	
	,member function Format(event LogEvent) return varchar2
	,member function getName return varchar2
	
) not final not instantiable;
/
show errors
