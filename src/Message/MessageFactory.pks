
create or replace package MessageFactory
authid definer
as

 /**
     * Creates a new message based on an Object.
     *
     * @param message
     *            a message object
     * @return a new message
     */
	function newMessage(msg log4_object) RETURN Message;

 /**
     * Creates a new message based on a String.
     *
     * @param message
     *            a message String
     * @return a new message
     */

	function newMessage(msg VARCHAR2) RETURN Message;

 /**
     * Creates a new parameterized message.
     *
     * @param message
     *            a message template, the kind of message template depends on the implementation.
     * @param params
     *            the message parameters
     * @return a new message
     * @see ParameterizedMessageFactory
     * @see StringFormatterMessageFactory
     */
	function newMessage(msg VARCHAR2, params log4_array) RETURN Message;

END;
/
show errors
