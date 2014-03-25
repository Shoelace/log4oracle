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

prompt create or replace type Layout 

create or replace 
type Layout 
authid definer
as object
(
	/**
	* Extend this abstract class to create your own log layout format.
	* @headcom
	*/
	
	/**
	* The header for the layout format.
	* The Header text will be appended before any logging events
	* are formatted and appended.
	*/
	Header varchar2(2000),

	/**
	* The footer for the layout format.
	* The Footer text will be appended after all the logging events
	* have been formatted and appended.
	*/
	Footer varchar2(2000),

	/**
	* Flag indicating if this layout handles exceptions
	* If this layout handles the exception object contained within
	* <see cref="LoggingEvent"/>, then the layout should return
	* <c>false</c>. Otherwise, if the layout ignores the exception
	* object, then the layout should return <c>true</c>.
	*/
	IgnoresException number,
	
	/**
	* Activate component options
	* This is part of the <see cref="IOptionHandler"/> delayed object
	* activation scheme. The <see cref="ActivateOptions"/> method must 
	* be called on this object after the configuration properties have
	* been set. Until <see cref="ActivateOptions"/> is called this
	* object is in an undefined state and must not be used. 
	* If any of the configuration properties are modified then 
	* <see cref="ActivateOptions"/> must be called again.
 	* This method must be implemented by the subclass.
    * @deprecated
	*/
	not final member procedure ActivateOptions,
	
	/**
	*Implement this method to create your own layout format.
	* @param event The event to format
	* @return The formatted logging event
	*/
	not final member function Format(event LogEvent) return varchar2,
	
	/**
	* The content type output by this layout. 
	* This base class uses the value <c>"text/plain"</c>.
	* To change this value a subclass must override this
	* property.
	* @return The content type is <c>"text/plain"
	*/
	member function GetContentType return varchar2,
	
	--member function GetHeader return varchar2,
	--member function GetFooter return varchar2,
	/**
	* Empty default constructor
	*/
	constructor function Layout return self as result
	
)
not final not instantiable;
/

show errors
