prompt CREATE FUNCTION get_log_level

create or replace  FUNCTION get_log_level
(
    pFQCN IN VARCHAR2
) 
RETURN log_levels%rowtype
AUTHID DEFINER
RESULT_CACHE 
IS

/************************************************************************
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

************************************************************************/

	rLog_level log_levels%rowtype;
BEGIN
	--DBMS_OUTPUT.PUT_LINE('looking for:'||pFQCN);

WITH lname AS (SELECT pFQCN logname from dual )
,lvls AS (SELECT LEVEL l, logname logname FROM lname  CONNECT BY   LEVEL <= regexp_count (logname, '\.', 1) + 1)
SELECT *
INTO rLog_Level 
FROM log_levels
WHERE logger_name IN ( SELECT substr(logname,1,instr(logname||'.','.',1,l)-1)  FROM lvls ) OR logger_name ='.'
ORDER BY LENGTH(logger_name) DESC
;

	--SELECT * 
	--FROM log_levels
	--WHERE logger_name = pFQCN;

	--DBMS_OUTPUT.PUT_LINE('got level:'||pFQCN);
	RETURN rLog_level;
EXCEPTION 
	WHEN no_data_found THEN
	--DBMS_OUTPUT.PUT_LINE('got NO level');
		RETURN rLog_level;
	WHEN others THEN 
		raise;      
END get_log_level;
/
show errors
