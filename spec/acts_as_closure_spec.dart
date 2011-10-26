class ActsAsClosureSpec extends SpecMap_Bullseye {
  Function newInstance;

  ActsAsClosureSpec(this.newInstance);

  spec() {
    var className = BullseyeUtils.getClassName(newInstance());

    describe("$className acts as BullseyeClosure", {

      "has a closure fn()": (){
        var closure = newInstance();
        Expect.isNull(closure.fn);
        
        var fn = (){};
        closure.fn = fn;
        Expect.identical(fn, closure.fn);
      },

      "has a description()": (){
        var closure = newInstance();
        Expect.isNull(closure.description);
        
        closure.description = "Cool closure";
        Expect.identical("Cool closure", closure.description);
      },

      "can get parents() - a list of parent BullseyeTestFixture, starting with the outermost and ending with this closure's parent": (){
        var closure = newInstance();
        Expect.equals(0, closure.parents.length);

        var fixture = new BullseyeTestFixture();
        closure.parent = fixture;
        Expect.equals(1, closure.parents.length);
        Expect.identical(fixture, closure.parents[0]);

        var outerFixture = new BullseyeTestFixture();
        fixture.parent = outerFixture;
        Expect.equals(2, closure.parents.length);
        Expect.identical(outerFixture, closure.parents[0]);
        Expect.identical(fixture, closure.parents[1]);
      },

      "has a fullDescription which includes the descriptions of all parent groups": (){
        var outer = new BullseyeTestFixture(description: "outer");
        var blank = new BullseyeTestFixture(description: null,    parent: outer);
        var inner = new BullseyeTestFixture(description: "inner", parent: blank);
        var last  = new BullseyeTestFixture(description: null,    parent: inner);

        var closure = newInstance();
        closure.description = "foo";
        Expect.equals("foo", closure.fullDescription);

        closure.parent = last;
        Expect.equals("outer inner foo", closure.fullDescription);

        closure.description = null;
        Expect.equals("outer inner", closure.fullDescription);
      },

      "has a reference to its parent() BullseyeTestFixture (if any)": (){
        var closure = newInstance();
        Expect.isNull(closure.parent);
        
        var fixture = new BullseyeTestFixture();
        closure.parent = fixture;
        Expect.identical(fixture, closure.parent);
      },

      "has meta() data": (){
        var closure = newInstance();
        Expect.isNull(closure.meta["hello"]);

        closure.setMeta({ "hello": "foo" });
        Expect.equals("foo", closure.meta["hello"]);
      },

      "meta() is magical (values accessible via methods via noSuchMethod)": (){
        var closure = newInstance();
        Expect.equals(0, closure.meta.length);

        Expect.isNull(closure.meta.foo);
        Expect.isNull(closure.meta["foo"]);
        closure.meta.foo = "foo";
        Expect.equals("foo", closure.meta.foo);
        Expect.equals("foo", closure.meta["foo"]);
      },

      "has tags() (which are stored in metadata['tags'])": (){
        var closure = newInstance();
        Expect.equals(0, closure.tags.length);

        closure.tags = ["first", "second"];
        Expect.listEquals(["first", "second"], closure.tags);
        Expect.listEquals(["first", "second"], closure.meta["tags"]);
      },

      // "can be run()": null,
      // "raises an Exception if you try to run() its function more than once": null,
      // "allows you to explicitly rerun() its function, allowing you to run it as many times are you'd like": null,
      // "you can rerun() even if you haven't run() before": null,
      // "saves the returnValue of the function when run()": null,
      // "updates the returnValue of the function when rerun()": null,
      // "has a status of 'not_run' before being run()": null,
      // "has a status of 'passed' if running the function results in no Exceptions being thrown": null,
      // "has a status of 'pending' if no function given (even before being run())": null,
      // "has a status of 'error' if running the function results in an Exception being thrown (besides an ExpectException)": null,
      // "has a status of 'failed' if running the function results in an ExpectException being thrown": null,

      // "exception property gets set to the thrown exception if an Exception is thrown as a result of running the function" : null,
      // "exception property gets set to the thrown exception if an ExpectException is thrown as a result of running the function" : null,
      // "stackTrace property gets set to the thrown exception's stack trace if an Exception is thrown as a result of running the function" : null,
      // "stackTrace property gets set to the thrown exception's stack trace if an ExpectException is thrown as a result of running the function" : null,
      // "rerun() resets exception and stackTrace (incase they change)": null,

      // "can be configured to let any thrown Exceptions bubble up (to see the correct stacktrace)": null,
      // "can globally be configured to let any thrown Exceptions bupple up (in all BullseyeClosures)": null,

      // "tracks the total time that it takes to run the function": null

    });
  }
}
