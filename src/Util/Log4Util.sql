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
package Log4Util as
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
