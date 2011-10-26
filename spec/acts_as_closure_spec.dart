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

      "can be run()": (){
        var has_been_run = false;
        var closure = newInstance();
        closure.fn = () => has_been_run = true;
        Expect.isFalse(has_been_run);
        Expect.equals(BullseyeTestStatus.not_run, closure.status);

        closure.run();

        Expect.isTrue(has_been_run);
        Expect.equals(BullseyeTestStatus.passed, closure.status);
      },

      "raises an Exception (and doesn't run) if you try to run() its function more than once": (){
        var times_run = 0;
        var closure = newInstance();
        closure.fn = () => ++times_run;
        Expect.equals(0, times_run);
        Expect.equals(BullseyeTestStatus.not_run, closure.status);

        closure.run();
        Expect.equals(1, times_run);
        Expect.equals(BullseyeTestStatus.passed, closure.status);

        Expect.throws(() => closure.run(),
          check: (ex) => ex.toString() == "UnsupportedOperationException: This cannot be run() more than once.  Try rerun() to explicitly run again.");
        Expect.equals(1, times_run);
        Expect.equals(BullseyeTestStatus.passed, closure.status);
      },

      "allows you to explicitly rerun() its function, allowing you to run it as many times are you'd like": (){
        var times_run = 0;
        var closure = newInstance();
        closure.fn = () => ++times_run;
        Expect.equals(0, times_run);
        Expect.equals(BullseyeTestStatus.not_run, closure.status);

        closure.run();
        Expect.equals(1, times_run);
        Expect.equals(BullseyeTestStatus.passed, closure.status);

        closure.rerun();
        Expect.equals(2, times_run);
        Expect.equals(BullseyeTestStatus.passed, closure.status);
      },

      "you can rerun() even if you haven't run() before": (){
        var times_run = 0;
        var closure = newInstance();
        closure.fn = () => ++times_run;
        Expect.equals(0, times_run);
        Expect.equals(BullseyeTestStatus.not_run, closure.status);

        closure.rerun();

        Expect.equals(1, times_run);
        Expect.equals(BullseyeTestStatus.passed, closure.status);
      },

      "saves the returnValue of the function when run()": (){
        var closure = newInstance();
        closure.fn = () => "foo";
        Expect.isNull(closure.returnValue);

        closure.run();

        Expect.equals("foo", closure.returnValue);
      },

      "updates the returnValue of the function when rerun()": (){
        var returnMe = "foo";
        var closure = newInstance();
        closure.fn = () => returnMe;
        Expect.isNull(closure.returnValue);

        closure.run();
        Expect.equals("foo", closure.returnValue);

        returnMe = "changed!";
        closure.rerun();
        Expect.equals("changed!", closure.returnValue);
      },

      "has a status of 'not_run' before being run()": (){
        var closure = newInstance();
        closure.fn = (){};
        Expect.equals(BullseyeTestStatus.not_run, closure.status);
      },

      "has a status of 'passed' if running the function statuss in no Exceptions being thrown": (){
        var closure = newInstance();
        closure.fn = (){};
        Expect.equals(BullseyeTestStatus.not_run, closure.status);
      
        closure.run();

        Expect.equals(BullseyeTestStatus.passed, closure.status);
      },

      "has a status of 'pending' if no function given (even before being run())": (){
        var closure = newInstance();
        Expect.equals(BullseyeTestStatus.pending, closure.status);
      },

      "has a status of 'pending' if BullseyePendingException is thrown when run()": (){
        var closure = newInstance();
        closure.fn = (){ throw new BullseyePendingException("Haven't gotten around to this yet"); };
        Expect.equals(BullseyeTestStatus.not_run, closure.status);
        Expect.isNull(closure.pendingReason);

        closure.run();
        Expect.equals(BullseyeTestStatus.pending, closure.status);
        Expect.equals("Haven't gotten around to this yet", closure.pendingReason);
      },

      "has a status of 'error' if running the function statuss in an Exception being thrown (besides an ExpectException)": (){
        var closure = newInstance();
        closure.fn = () => "oh noes".stringsDoNotHaveThisMethodSoItWillBlowUp();
        Expect.equals(BullseyeTestStatus.not_run, closure.status);

        closure.run();

        Expect.equals(BullseyeTestStatus.error, closure.status);
      },

      "has a status of 'failed' if running the function statuss in an ExpectException being thrown": (){
        var closure = newInstance();
        closure.fn = () => Expect.isTrue(false);
        Expect.equals(BullseyeTestStatus.not_run, closure.status);

        closure.run();

        Expect.equals(BullseyeTestStatus.failed, closure.status);
      },

      "exception property gets set to the thrown exception if an Exception is thrown as a status of running the function" : (){
        var closure = newInstance();
        closure.fn = () => "oh noes".stringsDoNotHaveThisMethodSoItWillBlowUp();
        Expect.isNull(closure.exception);

        closure.run();

        Expect.isTrue(closure.exception is NoSuchMethodException);
        Expect.equals("NoSuchMethodException - receiver: 'oh noes' function name: 'stringsDoNotHaveThisMethodSoItWillBlowUp' arguments: []]", closure.exception.toString());
      },

      "exception property gets set to the thrown exception if an ExpectException is thrown as a status of running the function" : (){
        var closure = newInstance();
        closure.fn = () => Expect.isTrue(false);
        Expect.isNull(closure.exception);

        closure.run();

        Expect.isTrue(closure.exception is ExpectException);
        Expect.equals("Expect.isTrue(false) fails.", closure.exception.toString());
      },

      "stackTrace property gets set to the thrown exception's stack trace if an Exception is thrown as a status of running the function" : (){
        var closure = newInstance();
        closure.fn = () => "oh noes".stringsDoNotHaveThisMethodSoItWillBlowUp();
        Expect.isNull(closure.stackTrace);

        closure.run();

        Expect.isNotNull(closure.stackTrace);
        Expect.isTrue(closure.stackTrace.toString().contains("Function: 'ActsAsClosureSpec.function' url: 'spec/acts_as_closure_spec.dart'", 0));
        Expect.isTrue(closure.stackTrace.toString().contains("Function: 'BullseyeClosure.run' url: 'spec/../src/bullseye/closure.dart'", 0));
      },

      "stackTrace property gets set to the thrown exception's stack trace if an ExpectException is thrown as a status of running the function" : (){
        var closure = newInstance();
        closure.fn = () => Expect.isTrue(false);
        Expect.isNull(closure.stackTrace);

        closure.run();

        Expect.isNotNull(closure.stackTrace);
        Expect.isTrue(closure.stackTrace.toString().contains("Function: 'Expect.isTrue'", 0));
        Expect.isTrue(closure.stackTrace.toString().contains("Function: 'ActsAsClosureSpec.function' url: 'spec/acts_as_closure_spec.dart'", 0));
      },

      "rerun() resets exception and stackTrace (incase they change)": (){
        var throwException = false;
        var closure = newInstance();
        closure.fn = (){ if (throwException == true) throw new NotImplementedException(); };

        closure.run();
        Expect.isNull(closure.exception);
        Expect.isNull(closure.stackTrace);
        Expect.equals(BullseyeTestStatus.passed, closure.status);

        throwException = true;
        closure.rerun();
        Expect.isNotNull(closure.exception);
        Expect.isNotNull(closure.stackTrace);
        Expect.equals(BullseyeTestStatus.error, closure.status);

        throwException = false;
        closure.rerun();
        Expect.isNull(closure.exception);
        Expect.isNull(closure.stackTrace);
        Expect.equals(BullseyeTestStatus.passed, closure.status);
      },

      "can be configured to let any thrown Exceptions bubble up (to see the correct stacktrace)": (){
        var closure = newInstance();
        closure.fn = (){ Expect.fail("boom!"); };
        closure.rerun();

        closure.throwExceptions = true;
        Expect.throws(() => closure.rerun(), check: (ex) => ex.toString() == "Expect.fail('boom!')");
      },

      "can globally be configured to let any thrown Exceptions bupple up (in all BullseyeClosures)": (){
        var closure = newInstance();
        closure.fn = (){ Expect.fail("boom!"); };
        closure.rerun();

        BullseyeClosure.closuresThrowExceptions = true;
        Expect.throws(() => closure.rerun(), check: (ex) => ex.toString() == "Expect.fail('boom!')");

        BullseyeClosure.closuresThrowExceptions = false; // reset!
      },

      "tracks the total time that it takes to run the function": (){
        var closure = newInstance();
        closure.fn = (){};
        Expect.isNull(closure.timeItTookToRunInUs);

        closure.run();

        Expect.isTrue(closure.timeItTookToRunInUs > 0);    // More than 0 Microseconds
        Expect.isTrue(closure.timeItTookToRunInUs < 3000); // Less than a 3 Milliseconds (just incase)
      },

      "has helpers for checking is the closure currently has a given status, eg. passed()": (){
        var closure = newInstance();
        Expect.isTrue(closure.pending);
        Expect.isFalse(closure.passed);
        Expect.isFalse(closure.failed);
        Expect.isFalse(closure.error);

        closure.fn = (){};
        Expect.isFalse(closure.pending);
        Expect.isFalse(closure.passed);
        Expect.isFalse(closure.failed);
        Expect.isFalse(closure.error);

        closure.run();
        Expect.isTrue(closure.passed);
        Expect.isFalse(closure.pending);
        Expect.isFalse(closure.failed);
        Expect.isFalse(closure.error);
      }

    });
  }
}
