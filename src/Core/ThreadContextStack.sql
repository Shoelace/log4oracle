
CREATE OR REPLACE TYPE ThreadContextStack AS TABLE OF VARCHAR2(32767)
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
        ,member function pop(self in out nocopy ThreadContextContextStack) return varchar2

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
        
        ,constructor function ThreadContextContextStack return self as result
);
/
show errors

CREATE OR REPLACE TYPE BODY ThreadContextContextStack 
AS

  constructor function ThreadContextContextStack return self as result
        IS
        BEGIN
        self.m_stack := ThreadContextStack();
        return;
        END;

        MEMBER PROCEDURE CLEAR
        IS
        BEGIN
        m_stack.trim(m_stack.count);
        END;

        /**
         * Returns the element at the top of the stack.
         * @return The element at the top of the stack.
         * @throws java.util.NoSuchElementException if the stack is empty.
         */
        member function pop(self in out nocopy ThreadContextContextStack) return varchar2
        IS
          retval VARCHAR2(32000);
        BEGIN
          retval := self.m_stack(self.m_stack.LAST);
          self.m_stack.trim;
          return retval; 
        END;

        /**
         * Returns the element at the top of the stack without removing it or null if the stack is empty.
         * @return the element at the top of the stack or null if the stack is empty.
         */
        member function peek return varchar2
        IS
        BEGIN
        return m_stack(m_stack.last);
        END;

        /**
         * Add an element to the stack.
         * @param message The element to add.
         */
        --void push(String message);
        member procedure push(message varchar2)
        IS
        BEGIN
        m_stack.extend;
        m_stack(m_stack.last) := message;
        END;

        /**
         * Returns the number of elements in the stack.
         * @return the number of elements in the stack.
         */
        --INT getDepth();
        member function getDepth return INTEGER
        IS
        BEGIN
        return m_stack.count;
        END;

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
        member procedure trim(depth INTEGER)
        IS
        BEGIN
        m_stack.trim(depth);
        END;

        /**
         * Returns a copy of the ContextStack.
         * @return a copy of the ContextStack.s
         */
        --ContextStack copy();
END;
/
show errors
