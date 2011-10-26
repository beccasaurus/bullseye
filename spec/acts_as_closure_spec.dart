class ActsAsClosureSpec extends SpecMap_Bullseye {
  Function newInstance;

  ActsAsClosureSpec(this.newInstance);

  spec() {
    var instance  = newInstance();
    var className = BullseyeUtils.getClassName(instance);

    describe("$className acts as BullseyeClosure", {

      "has a function": null,
      // "has a description": null,
      // "can get its parentGroups as a list of groups with the outermost first and this closure's immediate parent group last": null,
      // "has a fullDescription which includes the descriptions of all parent groups": null,
      // "has a reference to its parent group (if any)": null,
      // "has meta data": null,
      // "meta is magical (values accessible via methods via noSuchMethod)": null,
      // "has tags (which are stored in metadata['tags'])": null,
      // "can pass a single tag via tag:": null,
      // "can pass both tags: and tag: and meta: without collisions": null,
      // "can be run()": null,
      // "saves the returnValue of the function when run()": null,
      // "has a status of 'not_run' before being run()": null,
      // "has a status of 'passed' if running the function results in no Exceptions being thrown": null,
      // "has a status of 'pending' if no function given (even before being run())": null,
      // "has a status of 'error' if running the function results in an Exception being thrown (besides an ExpectException)": null,
      // "has a status of 'failed' if running the function results in an ExpectException being thrown": null,
      // "exception property gets set to the thrown exception if an Exception is thrown as a result of running the function" : null,
      // "exception property gets set to the thrown exception if an ExpectException is thrown as a result of running the function" : null,
      // "stackTrace property gets set to the thrown exception's stack trace if an Exception is thrown as a result of running the function" : null,
      // "stackTrace property gets set to the thrown exception's stack trace if an ExpectException is thrown as a result of running the function" : null,
      // "can be configured to let any thrown Exceptions bubble up (to see the correct stacktrace)": null,
      // "can globally be configured to let any thrown Exceptions bupple up (in all BullseyeClosures)": null,
      // "raises an Exception if you try to run() its function more than once": null,
      // "allows you to explicitly rerun() its function, allowing you to run it as many times are you'd like": null,
      // "updates the returnValue of the function when rerun()": null,
      // "rerun() resets exception and stackTrace (incase they change)": null,
      // "you can rerun() even if you haven't run() before": null,
      // "tracks the total time that it takes to run the function": null

    });
  }
}
