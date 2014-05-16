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
package PatternParser as
	/** 
	* Most of the work of the <see cref="PatternLayout"/> class
	* is delegated to the PatternParser class.
	* The <c>PatternParser</c> processes a pattern string and
	* returns a chain of <see cref="PatternConverter"/> objects.
	* @headcom
	*/
  type map_entry is record ( key varchar2(200), value varchar2(200));
	
  type PatternConverterMap is table of map_entry index by varchar2(200);
  
	/**
	* @return List of global pattern rules.
	*/
	--function GlobalRulesRegistry return PatternConverterArray;
	
	/**
	* Parses the pattern into a chain of pattern converters.
	* @return The head of a chain of pattern converters.
	*/
	function Parse(pattern varchar2) return PatternConverterArray;
	
end PatternParser;
/
