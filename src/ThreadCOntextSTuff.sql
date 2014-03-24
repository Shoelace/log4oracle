
CREATE OR REPLACE TYPE ThreadContextStack AS TABLE OF VARCHAR2(32767)
/
CREATE OR REPLACE TYPE ThreadContextContextMapIndex AS TABLE OF INTEGER
/

CREATE OR REPLACE TYPE ThreadContextContextMap 
AS OBJECT
(
m_values ThreadContextStack,
m_indexes ThreadContextContextMapIndex

, MEMBER PROCEDURE clear
, MEMBER FUNCTION containsKey(KEY VARCHAR2) RETURN boolean
, MEMBER FUNCTION get(KEY VARCHAR2) RETURN VARCHAR2
, MEMBER PROCEDURE put(KEY VARCHAR2, value VARCHAR2) 
--, MEMBER FUNCTION put(KEY VARCHAR2, value VARCHAR2) RETURN VARCHAR2
, MEMBER FUNCTION remove(KEY VARCHAR2) RETURN VARCHAR2
, MEMBER PROCEDURE remove(KEY VARCHAR2)
, MEMBER FUNCTION getsize RETURN INTEGER
, MEMBER FUNCTION isEmpty RETURN BOOLEAN
);
/

CREATE or replace TYPE ThreadContextContextStack AS OBJECT
(
m_stack ThreadContextStack
 /**
         * Clears all elements from the stack.
         */
        ,member procedure clear

        /**
         * Returns the element at the top of the stack.
         * @return The element at the top of the stack.
         * @throws java.util.NoSuchElementException if the stack is empty.
         */
        ,member function pop return varchar2

        /**
         * Returns the element at the top of the stack without removing it or null if the stack is empty.
         * @return the element at the top of the stack or null if the stack is empty.
         */
        ,member function peek return varchar2

        /**
         * Add an element to the stack.
         * @param message The element to add.
         */
        --void push(String message);
        ,member procedure push(message varchar2)

        /**
         * Returns the number of elements in the stack.
         * @return the number of elements in the stack.
         */
        --INT getDepth();
        ,member function getDepth return INTEGER

        /**
         * Returns all the elements in the stack in a List.
         * @return all the elements in the stack in a List.
         */
        --List<String> asList();

        /**
         * Trims elements from the end of the stack.
         * @param depth The maximum number of items in the stack to keep.
         */
        --void trim(int depth);
        ,member procedure trim(depth INTEGER)

        /**
         * Returns a copy of the ContextStack.
         * @return a copy of the ContextStack.s
         */
        --ContextStack copy();
);
/