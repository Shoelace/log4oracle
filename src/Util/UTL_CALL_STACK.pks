create or replace PACKAGE utl_call_stack IS

/** 
* this is a pre 12c implementauyion of utl_call_stack.
*
* @headcom
*/

  /**
    Exception: BAD_DEPTH_INDICATOR

    This exception is raised when a provided depth is out of bounds.
        - Dynamic and lexical depth are positive integer values.
        - Error and backtrace depths are non-negative integer values
        and are zero only in the absence of an exception.

  */
  BAD_DEPTH_INDICATOR EXCEPTION;
    pragma EXCEPTION_INIT(BAD_DEPTH_INDICATOR, -64610);

  /**
    Type: UNIT_QUALIFIED_NAME

    This data structure is a varray whose individual elements are, in order,
    the unit name, any lexical parents of the subprogram, and the subprogram
    name.

<pre>
    For example, consider the following contrived PL/SQL procedure.

    > procedure topLevel is
    >   function localFunction(...) returns varchar2 is
    >     function innerFunction(...) returns varchar2 is
    >       begin
    >         declare
    >           localVar pls_integer;
    >         begin
    >           ... (1)
    >         end;
    >       end;
    >   begin
    >     ...
    >   end;

   The unit qualified name at (1) would be

   >    ["topLevel", "localFunction", "innerFunction"]
</pre>

   Note that the block enclosing (1) does not figure in the unit qualified
   name.

   If the unit were an anonymous block, the unit name would be "__anonymous_block"

  */
  TYPE UNIT_QUALIFIED_NAME IS VARRAY(256) OF VARCHAR2(32767);

  /*
*    Function: subprogram
*
*    Returns the unit-qualified name of the subprogram at the specified dynamic
*    depth.
*
*    Parameters:
*
*      @param dynamic_depth - The depth in the call stack.
*
*    Returns:
*
*      @return The unit-qualified name of the subprogram at the specified dynamic depth.
*
*    Exception:
*
*     @throws  BAD_DEPTH_INDICATOR
   */
  FUNCTION subprogram(dynamic_depth IN PLS_INTEGER) RETURN UNIT_QUALIFIED_NAME;

  /*
    Function: concatenate_subprogram

    Convenience function to concatenate a unit-qualified name, a varray, into
    a varchar2 comprising the names in the unit-qualified name, separated by
    dots.

    Parameters:

      qualified_name - A unit-qualified name.

    Returns:

      A string of the form "UNIT.SUBPROGRAM.SUBPROGRAM...LOCAL_SUBPROGRAM".

   */
  FUNCTION concatenate_subprogram(qualified_name IN UNIT_QUALIFIED_NAME)
           RETURN VARCHAR2;

  /*
    Function: owner

    Returns the owner name of the unit of the subprogram at the specified
    dynamic depth.

    Parameters:

      dynamic_depth - The depth in the call stack.

    Returns:

      The owner name of the unit of the subprogram at the specified dynamic
      depth.

    Exception:

      Raises <BAD_DEPTH_INDICATOR>.
   */
  FUNCTION owner(dynamic_depth IN PLS_INTEGER) RETURN VARCHAR2;

  /*
    Function: current_edition

    Returns the current edition name of the unit of the subprogram at the
    specified dynamic depth.

    Parameters:

      dynamic_depth - The depth in the call stack.

    Returns:

      The current edition name of the unit of the subprogram at the specified
      dynamic depth.

    Exception:

      Raises <BAD_DEPTH_INDICATOR>.
   */
  FUNCTION current_edition(dynamic_depth IN PLS_INTEGER) RETURN VARCHAR2;

  /*
    Function: unit_line

    Returns the line number of the unit of the subprogram at the specified
    dynamic depth.

    Parameters:

      dynamic_depth - The depth in the call stack.

    Returns:

      The line number of the unit of the subprogram at the specified dynamic
      depth.

    Exception:

      Raises <BAD_DEPTH_INDICATOR>.
   */
  FUNCTION unit_line(dynamic_depth IN PLS_INTEGER) RETURN PLS_INTEGER;

  /*
    Function: dynamic_depth

    Returns the number of subprograms on the call stack.

    Parameters:

    Returns:

      The number of subprograms on the call stack.

   */
  FUNCTION dynamic_depth RETURN PLS_INTEGER;

  /*
    Function: lexical_depth

    Returns the lexical nesting depth of the subprogram at the specified dynamic
    depth.

    Parameters:

      dynamic_depth - The depth in the call stack.

    Returns:

      The lexical nesting depth of the subprogram at the specified dynamic
      depth.

    Exception:

      Raises <BAD_DEPTH_INDICATOR>.
   */
  FUNCTION lexical_depth(dynamic_depth IN PLS_INTEGER) RETURN PLS_INTEGER;

  /*
    Function: error_depth

    Returns the number of errors on the error stack.

    Parameters:

    Returns:

      The number of errors on the error stack.

   */
  FUNCTION error_depth RETURN PLS_INTEGER;

  /*
    Function: error_number

    Returns the error number of the error at the specified error depth.

    Parameters:

      error_depth - The depth in the error stack.

    Returns:

      The error number of the error at the specified error depth.

    Exception:

      Raises <BAD_DEPTH_INDICATOR>.
   */
  FUNCTION error_number(error_depth IN PLS_INTEGER) RETURN PLS_INTEGER;

  /*
    Function: error_msg

    Returns the error message of the error at the specified error depth.

    Parameters:

      error_depth - The depth in the error stack.

    Returns:

      The error message of the error at the specified error depth.

    Exception:

      Raises <BAD_DEPTH_INDICATOR>.
   */
  FUNCTION error_msg(error_depth IN PLS_INTEGER) RETURN VARCHAR2;

  /*
    Function: backtrace_depth

    Returns the number of backtrace items in the backtrace.

    Parameters:

    Returns:

      The number of backtrace items in the backtrace, zero in the absence of
      an exception.

   */
  FUNCTION backtrace_depth RETURN PLS_INTEGER;

  /*
    Function: backtrace_unit

    Returns the name of the unit at the specified backtrace depth.

    Parameters:

      backtrace_depth - The depth in the backtrace.

    Returns:

      The name of the unit at the specified backtrace depth.

    Exception:

      Raises <BAD_DEPTH_INDICATOR>. Note that backtrace_unit(0); always raises
      this exception.

   */
  FUNCTION backtrace_unit(backtrace_depth IN PLS_INTEGER) RETURN VARCHAR2;

  /*
    Function: backtrace_line

    Returns the line number of the unit at the specified backtrace depth.

    Parameters:

      backtrace_depth - The depth in the backtrace.

    Returns:

      The line number of the unit at the specified backtrace depth.

    Exception:

      Raises <BAD_DEPTH_INDICATOR>. Note that backtrace_line(0); always raises
      this exception.
   */
  FUNCTION backtrace_line(backtrace_depth IN PLS_INTEGER) RETURN PLS_INTEGER;

END;
/
