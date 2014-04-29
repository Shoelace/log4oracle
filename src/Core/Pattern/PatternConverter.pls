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
	
	name varchar2(255),
	style varchar2(2000)
	
	
	,member function Format(obj log4_object) return varchar2
	,member procedure Format(obj log4_object, buffer IN OUT NOCOPY VARCHAR2)
	,member function getName return varchar2
	,member function getStyleClass return varchar2
	,static function converterkeys return varchar2
	
) not final not instantiable;
/
show errors

create or replace 
type body PatternConverter
as

  static FUNCTION ConverterKeys RETURN VARCHAR2
  IS
  BEGIN
    RETURN NULL;
  end;
	
	member function Format(obj log4_object) return varchar2
	is
	begin
		return obj.tostring();
	end;
	member procedure Format(obj log4_object, buffer IN OUT NOCOPY VARCHAR2) 
	is
	begin
		buffer := buffer||obj.tostring();
	end;

	member function getName return varchar2
	is
	begin
		return name;
	end;
	member function getStyleClass return varchar2
	is
	begin
		return style;
	end;
	
end;
/

