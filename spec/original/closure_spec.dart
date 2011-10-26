class OriginalClosureSpec extends SpecMap_Bullseye {
  spec() {
    describe("Closure", {

      "has a function": (){
        Expect.equals("foo", new BullseyeClosure("", () => "foo").function());
        Expect.equals("foo", new BullseyeClosure(function: () => "foo").function());
      },

      "has a description": (){
        Expect.equals("foo", new BullseyeClosure("foo").description);
        Expect.equals("foo", new BullseyeClosure(description: "foo").description);
      },

      // "can get its parentGroups as a list of groups with the outermost first and this closure's immediate parent group last": (){
      //   var outer   = new BullseyeClosureGroup("outer");
      //   var inner1  = new BullseyeClosureGroup("inner");
      //   var inner2  = new BullseyeClosureGroup(); // make sure that nothing goes boom if one of the parents is un-descriptiond
      //   var inner3  = new BullseyeClosureGroup("innermost");
      //   var closure = new BullseyeClosure("my cool closure");

      //   outer.addGroup(
      //     inner1.addGroup(
      //       inner2.addGroup(
      //         inner3.addClosure(closure))));

      //   Expect.listEquals([outer, inner1, inner2, inner3], closure.parentGroups);
      // },

      // "has a fullDescription which includes the descriptions of all parent groups": (){
      //   var outer   = new BullseyeClosureGroup("outer");
      //   var inner1  = new BullseyeClosureGroup("inner");
      //   var inner2  = new BullseyeClosureGroup(); // make sure that nothing goes boom if one of the parents is un-descriptiond
      //   var inner3  = new BullseyeClosureGroup("innermost");
      //   var closure = new BullseyeClosure("my cool closure");

      //   outer.addGroup(
      //     inner1.addGroup(
      //       inner2.addGroup(
      //         inner3.addClosure(closure))));

      //   Expect.equals("outer inner innermost my cool closure", closure.fullDescription);
      // },

      // "has a reference to its parent group (if any)": (){
      //   var closure = new BullseyeClosure();
      //   var group   = new BullseyeClosureGroup();

      //   Expect.isNull(closure.group);

      //   group.addClosure(closure);

      //   Expect.isNotNull(closure.group);
      //   Expect.identical(group, closure.group);
      // },

      "has meta data": (){
        Expect.isNull(new BullseyeClosure().meta["hello"]);
        Expect.equals("foo", new BullseyeClosure(meta: { "hello": "foo" }).meta["hello"]);
      },

      "meta is magical (values accessible via methods via noSuchMethod)": (){
        var closure = new BullseyeClosure();
        Expect.equals(0, closure.meta.length);

        Expect.isNull(closure.meta.foo);
        Expect.isNull(closure.meta["foo"]);
        closure.meta.foo = "foo";
        Expect.equals("foo", closure.meta.foo);
        Expect.equals("foo", closure.meta["foo"]);
      },

      "has tags (which are stored in metadata['tags'])": (){
        var closure = new BullseyeClosure(tags: ["first", "second"]);
        Expect.listEquals(["first", "second"], closure.tags);
        Expect.listEquals(["first", "second"], closure.meta["tags"]);
      },

      "can pass a single tag via tag:": (){
        var closure = new BullseyeClosure(tag: "just one tag");
        Expect.listEquals(["just one tag"], closure.tags);
        Expect.listEquals(["just one tag"], closure.meta["tags"]);
      },
    
      "can pass both tags: and tag: and meta: without collisions": (){
        var closure = new BullseyeClosure(tag: "just one tag", tags: ["first", "second"]);
        Expect.listEquals(["just one tag", "first", "second"], closure.tags);
        Expect.listEquals(["just one tag", "first", "second"], closure.meta["tags"]);
      },

      "can be run()": (){
        var closure = new BullseyeClosure(function: (){});
        Expect.equals("not_run", closure.status);
        closure.run();
        Expect.notEquals("not_run", closure.status);
      },

      "saves the returnValue of the function when run()": (){
        var closure = new BullseyeClosure(function: () => "foo");
        Expect.isNull(closure.returnValue);
        closure.run();
        Expect.equals("foo", closure.returnValue);
      },

      "has a status of 'not_run' before being run()": (){
        Expect.equals("not_run", new BullseyeClosure(function: (){}).status);
      },

      "has a status of 'passed' if running the function results in no Exceptions being thrown": (){
        var closure = new BullseyeClosure(function: (){});
        closure.run();
        Expect.equals("passed", closure.status);
      },

      "has a status of 'pending' if no function given (even before being run())": (){
        Expect.equals("pending", new BullseyeClosure().status);
      },

      "has a status of 'error' if running the function results in an Exception being thrown (besides an ExpectException)": (){
        var closure = new BullseyeClosure(function: (){ throw new NotImplementedException(); });
        closure.run();
        Expect.equals("error", closure.status);
      },

      "has a status of 'failed' if running the function results in an ExpectException being thrown": (){
        var closure = new BullseyeClosure(function: (){ Expect.isTrue(false); });
        closure.run();
        Expect.equals("failed", closure.status);
      },

      "exception property gets set to the thrown exception if an Exception is thrown as a result of running the function" : (){
        var closure = new BullseyeClosure(function: (){ throw new NotImplementedException(); });
        Expect.isNull(closure.exception);
        closure.run();
        Expect.isTrue(closure.exception is NotImplementedException);
      },

      "exception property gets set to the thrown exception if an ExpectException is thrown as a result of running the function" : (){
        var closure = new BullseyeClosure(function: (){ Expect.fail("boom!"); });
        closure.run();
        Expect.isTrue(closure.exception is ExpectException);
        Expect.equals("Expect.fail('boom!')", closure.exception.toString());
      },

      "stackTrace property gets set to the thrown exception's stack trace if an Exception is thrown as a result of running the function" : (){
        var closure = new BullseyeClosure(function: (){ throw new NotImplementedException(); });
        Expect.isNull(closure.stackTrace);
        closure.run();
        Expect.isTrue(closure.stackTrace.toString().contains("url: 'spec/../src/bullseye/closure.dart'", 0));
        Expect.isTrue(closure.stackTrace.toString().contains("Function: 'OriginalClosureSpec.function' url: 'spec/original/closure_spec.dart'", 0));
      },

      "stackTrace property gets set to the thrown exception's stack trace if an ExpectException is thrown as a result of running the function" : (){
        var closure = new BullseyeClosure(function: (){ Expect.fail("boom!"); });
        Expect.isNull(closure.stackTrace);
        closure.run();
        Expect.isTrue(closure.stackTrace.toString().contains("url: 'spec/../src/bullseye/closure.dart'", 0));
        Expect.isTrue(closure.stackTrace.toString().contains("Function: 'OriginalClosureSpec.function' url: 'spec/original/closure_spec.dart'", 0));
      },

      "can be configured to let any thrown Exceptions bubble up (to see the correct stacktrace)": (){
        var closure = new BullseyeClosure(function: (){ Expect.fail("boom!"); });
        closure.throwExceptions = true;
        Expect.throws(() => closure.run(), check: (ex) => ex.toString() == "Expect.fail('boom!')");
      },

      "can globally be configured to let any thrown Exceptions bupple up (in all BullseyeClosures)": (){
        var closure = new BullseyeClosure(function: (){ Expect.fail("boom!"); });
        BullseyeClosure.closuresThrowExceptions = true;
        Expect.throws(() => closure.run(), check: (ex) => ex.toString() == "Expect.fail('boom!')");

        BullseyeClosure.closuresThrowExceptions = false; // reset!
      },

      "raises an Exception if you try to run() its function more than once": (){
        var closure = new BullseyeClosure(function: (){});
        closure.run();
        Expect.equals("passed", closure.status);

        Expect.throws(() => closure.run(), check: (ex) => ex.toString() == "UnsupportedOperationException: This cannot be run() more than once.  Try rerun() to explicitly run again.");
        Expect.equals("passed", closure.status);
      },

      "allows you to explicitly rerun() its function, allowing you to run it as many times are you'd like": (){
        var timesRun = 0;
        var closure  = new BullseyeClosure(function: () => ++timesRun);

        closure.run();
        Expect.equals("passed", closure.status);
        Expect.equals(1, timesRun);
        
        closure.rerun();
        Expect.equals("passed", closure.status);
        Expect.equals(2, timesRun);
      },

      "updates the returnValue of the function when rerun()": (){
        var timesRun = 0;
        var closure = new BullseyeClosure(function: (){ ++timesRun; return "$timesRun times run"; });

        Expect.isNull(closure.returnValue);
        closure.run();
        Expect.equals("1 times run", closure.returnValue);

        closure.rerun();
        Expect.equals("2 times run", closure.returnValue);
      },

      "rerun() resets exception and stackTrace (incase they change)": (){
        var throwException = false;
        var closure        = new BullseyeClosure(function: (){ if (throwException == true) throw new NotImplementedException(); });

        closure.run();
        Expect.isNull(closure.exception);
        Expect.isNull(closure.stackTrace);
        Expect.equals("passed", closure.status);

        throwException = true;
        closure.rerun();
        Expect.isNotNull(closure.exception);
        Expect.isNotNull(closure.stackTrace);
        Expect.equals("error", closure.status);

        throwException = false;
        closure.rerun();
        Expect.isNull(closure.exception);
        Expect.isNull(closure.stackTrace);
        Expect.equals("passed", closure.status);
      },

      "you can rerun() even if you haven't run() before": (){
        var closure = new BullseyeClosure(function: (){ throw new NotImplementedException(); });
        Expect.equals("not_run", closure.status);

        closure.rerun();

        Expect.equals("error", closure.status);
        Expect.isNotNull(closure.exception);
        Expect.isNotNull(closure.stackTrace);
      },

      "tracks the total time that it takes to run the function": (){
        var closure = new BullseyeClosure(function: (){ });
        Expect.isNull(closure.timeItTookToRunInUs);

        closure.run();

        Expect.isTrue(closure.timeItTookToRunInUs > 0);    // More than 0 Microseconds
        Expect.isTrue(closure.timeItTookToRunInUs < 2000); // Less than a 2 Milliseconds (just incase)
      }

    });
  }
}
