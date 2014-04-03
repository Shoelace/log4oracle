create or replace package body MessageFactory
as

	function newMessage(msg VARCHAR2) RETURN Message
	IS
	BEGIN
		return SimpleMessage(msg);
	end;
	function newMessage(msg log4_object) RETURN Message
	IS
	BEGIN
		return ObjectMessage(msg);
	end;

	function newMessage(msg VARCHAR2, params log4_array) RETURN Message
	IS
	begin
    return new ParameterizedMessage(msg, params);
	END;

END;
/
show errors
