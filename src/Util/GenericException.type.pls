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

prompt create or replace type GenericException 

create or replace
type GenericException 
under log4_object
(
	/**
	* Generic exception object to handle Oracle exception with more details. 
	* The details of the exception are created from return values of the
	* DBMS_UTILITY methods FORMAT_ERROR_STACK, FORMAT_ERROR_BACKTRACE and
	* FORMAT_CALL_STACK.
	* @head
	*/

	m_sqlcode number,
	m_sqlerrm varchar2(512),
	
	/**
	* Error stack/message of the exception object.
	*/
	ErrorStack clob, --varchar2(32767),
	
	/**
	* Call Stack at the point where an exception was raised.
	*/
	ErrorBacktrace clob, --varchar2(32767),
	
	/**
	* Detailed call stack where the exception was raised.
	*/
	CallStack clob, --varchar2(32767),
	
	/**
	* Additional message text for the exception.
	*/
	Message clob, --varchar2(32767),
	
	/**
	* Creates a new exception.
	* @param message Additional exception message.
	* @return A new exeption.
	*/
	constructor function GenericException(message varchar2 default null) return self as result,
	
	/**
	* Converts the exception object into a string.
	* @return Exception representation as string.
	*/
	member function Format return varchar2
	
)
instantiable final;
/
