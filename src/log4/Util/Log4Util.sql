/** 
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

column warnval new_value warning_value noprint
select regexp_substr(dbms_warning.get_warning_setting_num(05021),'(.*):',1,1,'',1) warnval from dual;

--disable warning about not setting a pragma for exceptions
exec dbms_warning.add_warning_setting_num(05021,'DISABLE','SESSION');


prompt create or replace package Log4Util
create or replace 
package Log4Util
AUTHID DEFINER
AS
	/** 
	* LogUtil
	* @headcom
	*/
	
	NotImplementedException exception;
	ArgumentNullException exception;
	
	CRLF                      CONSTANT VARCHAR2(2) := CHR(13)||CHR(10);


PROCEDURE who_called_me
(
    owner OUT VARCHAR2,
    name OUT VARCHAR2,
    lineno OUT NUMBER,
    caller_t OUT VARCHAR2 ,
    depth NUMBER DEFAULT 1)
;
	
end Log4Util;
/
show errors

--reset warnings
exec dbms_warning.add_warning_setting_num(05021,'&warning_value','SESSION');
