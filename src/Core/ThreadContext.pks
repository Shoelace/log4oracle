--prompt CREATE OR REPLACE PACKAGE ThreadContext 
CREATE OR REPLACE PACKAGE ThreadContext
AUTHID DEFINER
AS
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
 
 --EMPTY_MAP CONSTANT ThreadContextContextMap := ThreadContextContextMapIndex(null,null);

/**
 * The ThreadContext allows applications to store information either in a Map or a Stack.
 * <p>
 * <b><em>The MDC is managed on a per thread basis</em></b>. A child thread automatically inherits a <em>copy</em> of
 * the mapped diagnostic context of its parent.
 * </p>
 */

 /**
     * Put a context value (the <code>value</code> parameter) as identified
     * with the <code>key</code> parameter into the current thread's
     * context map.
     * <p/>
     * <p>If the current thread does not have a context map it is
     * created as a side effect.
     * @param key The key name.
     * @param value The key value.
     */
    procedure put(key VARCHAR2, value VARCHAR2);

 /**
     * Get the context value identified by the <code>key</code> parameter.
     * <p/>
     * <p>This method has no side effects.
     * @param key The key to locate.
     * @return The value associated with the key or null.
     */
    function get(KEY Varchar2) return varchar2;

  /**
     * Remove the context value identified by the <code>key</code> parameter.
     * @param key The key to remove.
     */
    procedure remove(KEY varchar2);

  /**
     * Clear the context.
     */
    PROCEDURE clear;

    /**
     * Determine if the key is in the context.
     * @param key The key to locate.
     * @return True if the key is in the context, false otherwise.
     */
    FUNCTION containsKey(KEY VARCHAR2) return BOOLEAN;

  /**
     * Returns true if the Map is empty.
     * @return true if the Map is empty, false otherwise.
     */
    function isEmpty return boolean ;
    
    
   /**
     * Clear the stack for this thread.
     */
    procedure clearStack;

    /**
     * Returns a copy of this thread's stack.
     * @return A copy of this thread's stack.
     */
    --PUBLIC STATIC ContextStack cloneStack() {
    function cloneStack return ThreadContextContextStack;

   /**
     * Set this thread's stack.
     * @param stack The stack to use.
     */
    --PUBLIC STATIC void setStack(FINAL Collection<String> stack) {

   /**
     * Get the current nesting depth of this thread's stack.
     * @return the number of items in the stack.
     *
     * @see #trim
     */
    function getDepth return integer;

    /**
     * Returns the value of the last item placed on the stack.
     * <p/>
     * <p>The returned value is the value that was pushed last. If no
     * context is available, then the empty string "" is returned.
     *
     * @return String The innermost diagnostic context.
     */
    function pop return VARCHAR2;
    
   /**
     * Push new diagnostic context information for the current thread.
     * <p/>
     * <p>The contents of the <code>message</code> parameter is
     * determined solely by the client.
     *
     * @param message The new diagnostic context information.
     */
   PROCEDURE push(message VARCHAR2);
    
      /**
     * Remove the diagnostic context for this thread.
     * <p/>
     * <p>Each thread that created a diagnostic context by calling
     * {@link #push} should call this method before exiting. Otherwise,
     * the memory used by the <b>thread</b> cannot be reclaimed by the
     * VM.
     * <p/>
     * <p>As this is such an important problem in heavy duty systems and
     * because it is difficult to always guarantee that the remove
     * method is called before exiting a thread, this method has been
     * augmented to lazily remove references to dead threads. In
     * practice, this means that you can be a little sloppy and
     * occasionally forget to call {@link #remove} before exiting a
     * thread. However, you must call <code>remove</code> sometime. If
     * you never call it, then your application is sure to run out of
     * memory.
     */
    procedure removeStack ;

  /**
     * Trims elements from this diagnostic context. If the current
     * depth is smaller or equal to <code>maxDepth</code>, then no
     * action is taken. If the current depth is larger than newDepth
     * then all elements at maxDepth or higher are discarded.
     * <p/>
     * <p>This method is a convenient alternative to multiple {@link
     * #pop} calls. Moreover, it is often the case that at the end of
     * complex call sequences, the depth of the ThreadContext is
     * unpredictable. The <code>trim</code> method circumvents
     * this problem.
     * <p/>
     * <p>For example, the combination
     * <pre>
     * void foo() {
     *   int depth = ThreadContext.getDepth();
     * <p/>
     *   ... complex sequence of calls
     * <p/>
     *   ThreadContext.trim(depth);
     * }
     * </pre>
     * <p/>
     * ensures that between the entry and exit of foo the depth of the
     * diagnostic stack is conserved.
     *
     * @see #getDepth
     * @param depth The number of elements to keep.
     */
   procedure trim(depth INTEGER) ;
    


END ThreadContext;
/
show errors