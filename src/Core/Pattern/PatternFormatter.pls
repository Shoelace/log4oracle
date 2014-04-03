/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements. See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache license, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the license for the specific language governing permissions and
 * limitations under the license.
 */


/**
 * Modifies the output of a pattern converter for a specified minimum and maximum width and alignment.
 */
CREATE OR REPLACE TYPE patternFormatter 
AUTHID DEFINER
AS OBJECT
(
	converter logEventPatternConverter,
	field formattingInfo

    ,constructor function patternFormatter(c logEventPatternConverter, f formattingInfo)  return self as result
    

    ,member procedure format(event logEvent, buffer IN OUT NOCOPY VARCHAR2) 

    ,member function getConverter return  logEventPatternConverter
    ,member function getFormattingInfo return  formattingInfo

    ,member function handlesThrowable return  boolean
    /**
     * Returns a String suitable for debugging.
     * 
     * @return a String suitable for debugging.
    * @Override
     */
    ,member function toString return  varchar2

) not final instantiable;
/
show errors

create or replace type body PatternFormatter 
AS
    constructor function PatternFormatter(c LogEventPatternConverter, f FormattingInfo)  return self as result
	IS
	BEGIN
        self.converter := c;
        self.field := f;
		return;
	end;
    
	member procedure format(event LogEvent, buffer IN OUT NOCOPY VARCHAR2) 
	is
		startfield pls_integer := length(buffer);
	begin
		buffer := buffer || converter.format(event);
		field.format(startfield,buffer);
	end;
		

    member function getConverter return  LogEventPatternConverter
	is
	begin
		return converter;
	end;

    member function getFormattingInfo return  FormattingInfo
	is
	begin
		return field;
	end;

    member function handlesThrowable return  boolean
	is
	begin
		return converter.handlesThrowable();
	end;


    /**
     * Returns a String suitable for debugging.
     * 
     * @return a String suitable for debugging.
    * @Override
     */
    member function toString return  varchar2
    is
    begin
        return $$PLSQL_UNIT||'.tostring not implemented';
    end;

END;
/
show errors

/* vim: set tabstop=4 expandtab: */
