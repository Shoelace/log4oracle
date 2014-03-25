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
CREATE OR REPLACE TYPE FormattingInfo 
AUTHID DEFINER
AS OBJECT
(
    /**
     * Minimum length.
     */
    minLength integer,

    /**
     * Maximum length.
     */
    maxLength integer,

    /**
     * Alignment.
     */
    leftAlign integer

    /**
     * Creates new instance.
     * 
     * @param leftAlign
     *            left align if true.
     * @param minLength
     *            minimum length.
     * @param maxLength
     *            maximum length.
     */
    ,constructor function FormattingInfo(leftAlign boolean, minLength INTEGER, maxLength INTEGER) return self as result
    

    /**
     * Gets default instance.
     * 
     * @return default instance.
     */
    --public static FormattingInfo getDefault() {
        --return DEFAULT;
    --}

    /**
     * Determine if left aligned.
     * 
     * @return true if left aligned.
     */
    ,member function isLeftAligned return boolean

    /**
     * Get minimum length.
     * 
     * @return minimum length.
     */
    ,member function getMinLength return integer
    

    /**
     * Get maximum length.
     * 
     * @return maximum length.
     */
    ,member function getMaxLength return integer

    /**
     * Adjust the content of the buffer based on the specified lengths and alignment.
     * 
     * @param fieldStart
     *            start of field in buffer.
     * @param buffer
     *            buffer to be modified.
     */
    ,member procedure format(fieldStart INTEGER, buffer IN OUT NOCOPY VARCHAR2) 

    /**
     * Returns a String suitable for debugging.
     * 
     * @return a String suitable for debugging.
    * @Override
     */
/*
    public String toString() {
*/

);
/
show errors

create or replace type body FormattingInfo 
AS
    constructor function FormattingInfo(leftAlign boolean, minLength INTEGER, maxLength INTEGER) return self as result
	IS
	BEGIN
        self.leftAlign := (case when leftAlign then 1 else 0 end);
        self.minLength := minLength;
        self.maxLength := maxLength;
		return;
	end;
    

    /**
     * Gets default instance.
     * 
     * @return default instance.
     */
    --public static FormattingInfo getDefault() {
        --return DEFAULT;
    --}

    /**
     * Determine if left aligned.
     * 
     * @return true if left aligned.
     */
    member function isLeftAligned return boolean
	is
	begin
        return leftAlign =1;
    end;

    /**
     * Get minimum length.
     * 
     * @return minimum length.
     */
    member function getMinLength return integer
	is
	begin
        return minLength;
	end;
    

    /**
     * Get maximum length.
     * 
     * @return maximum length.
     */
    member function getMaxLength return integer
	is
	begin
        return maxLength;
	end;

    /**
     * Adjust the content of the buffer based on the specified lengths and alignment.
     * 
     * @param fieldStart
     *            start of field in buffer.
     * @param buffer
     *            buffer to be modified.
     */
    member procedure format(fieldStart INTEGER, buffer IN OUT NOCOPY VARCHAR2) 
	is
		rawlength pls_integer := length(buffer) - fieldStart;
	begin

        if (rawLength > maxLength) then
			buffer := substr(buffer,1,fieldstart+ maxLength-1 ) ;

		elsif (rawLength < minLength) then
            if (isleftAligned()) then
				buffer := rpad(buffer, fieldstart+minLength);
            else 
				buffer := substr(buffer,1,fieldstart-1) || LPAD(substr(buffer,fieldstart), minLength);
            end if;
        end if;
    end;

    /**
     * Returns a String suitable for debugging.
     * 
     * @return a String suitable for debugging.
    * @Override
     */
/*
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(super.toString());
        sb.append("[leftAlign=");
        sb.append(leftAlign);
        sb.append(", maxLength=");
        sb.append(maxLength);
        sb.append(", minLength=");
        sb.append(minLength);
        sb.append("]");
        return sb.toString();
    }
*/

END;
/
show errors

