spec.dart
=========

## THIS IS JUST A DRAFT!  HERE BE DRAGONS!

Spec.dart is a testing framework for Dart featuring:

 * xUnit inspired test DSL
 * RSpec inspired spec DSL
 * Test suite runner
 * Output formatters

Installing
----------

Usage
-----

### Hello World (bowling)

### More Complex

Submitting Bugs
---------------

Configuration
-------------

### Configuring the default formatter

 * throwing exceptions
 * disable colors
 * enable detailed time output

Customizing
-----------

### Customizing the DSL

### Using the available run() hooks

### Writing a custom formatter

### Writing a custom runner

Contributing
------------

 * downloading & running the tests
 * conventions
 * branching correctly and sending the pull request to the correct branch

Background
----------

**TODO kill this section and make xUnit support its own section, briefly 
noting how we can't support test() but we've got aliases geared towards 
making it look like it ...**

When Dart was released, one of the first things that I noticed 
was the inclusion of the `Expect` class, which contains useful 
assertion functions, and the `ExpectExpection` class, which is 
thrown by `Expect`'s assertions on failure.

I love the inclusion of basic assertions into Dart, but I felt that
an overall testing framework was missing.  The tests in Dart's source 
code are all very low-level and aren't written in a way that would 
allow you to easily write custom formatters, for example.

Initially, I wanted to start by implementng an [xUnit][] framework, 
allowing you to build simple classes with functions for test 
setup/teardown and 1 function for each testcase, conventionally 
beginning with "test", eg. `testSomeStuff()`.  Then I planned to 
build a BDD/Spec-style DSL ontop of that platform (which people 
could opt-in to).

Unfortunately, the currently lack of reflection in Dart makes is 
very tedious to write [xUnit][] style tests.  Because there's no way 
to reflect on your test class's function names to find all of the 
functions that start with "test," you have to explicitly call each 
of your test functions from your test, eg.

```actionscript
class MyTest {
  testOneThing(){}      // Assume these are your 
  testAnotherThing(){}  // actual tests

  // Because we can't lookup all of this class's functions 
  // to run each of them, we need to explicitly call them.
  runMe() {
    testOneThing();
    testAnotherThing();
  }
}
```

But even that is problematic because, how would you implement setup/teardown 
functions.  You would have to manually run them before and after you call 
each one of your test functions, or ... well, it wouldn't be ideal.

Once Dart has reflection, it's very likely that we'll add an [xUnit][] style 
syntax to Spec.dart.


Planned Features
---------------

 * Tagging (examples, describes, and (maybe?) specs)
 * Adding test execution time to formatter (with optional verbose output)
 * I want to look at adding explicit support for helping you test Isolates
 * Running tests asynchronously via Isolates?  And/or parallelizing tests across processes or ...?
 * Allowing it/before/after inside of spec() but outside of describe() blocks?
 * setup() / teardown() Spec instance methods to split this out / clean up test classes
 * Command line arguments, once Dart VM can get them

License
-------

spec.dart is released under the MIT license.


[Spec.dart]: https://github.com/remi/spec.dart
[xUnit]:     http://en.wikipedia.org/wiki/XUnit
