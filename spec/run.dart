#import("../lib/specmap.dart");
// #import("../pkg/bullseye.dart");
#import("../src/bullseye.dart");

#source("shared_examples_for_closure.dart");

#source("test_spec.dart");

#source("original/magic_map_spec.dart");
#source("original/closure_spec.dart");
#source("original/spec_spec.dart");
#source("original/test_spec.dart");
#source("original/test_fixture_spec.dart");
#source("original/running_tests_spec.dart");
#source("original/before_and_after_spec.dart");
#source("original/pending_test_spec.dart");
#source("original/run_hooks_spec.dart");
#source("original/specdoc_formatter_spec.dart");
#source("original/xunit_dsl_spec.dart");
#source("original/samples_spec.dart");
#source("../samples/bowling_spec.dart");

int main() {
  return SpecMap.run([

    new TestSpec(),

    new OriginalMagicMapSpec(),
    new OriginalClosureSpec(),
    new OriginalSpecSpec(),
    new OriginalTestSpec(),
    new OriginalTestFixtureSpec(),
    new OriginalRunningTestsSpec(),
    new OriginalBeforeAndAfterSpec(),
    new OriginalPendingTestSpec(),
    new OriginalRunHooksSpec(),
    new OriginalSpecDocFormatterSpec(),
    new OriginalxUnitDSLSpec(),
    new OriginalSamplesSpec()
  ]);
}

// Our custom SpecMap baseclass.
//
// All of our specs inherit from this so they 
// can use all of the helper methods defined here.
class SpecMap_Bullseye extends SpecMap {

  // Defines all of the shared behaviors that are available.
  // You must add your sharedBehaviors here!  Atleast for now.
  get sharedBehaviors() => {
    "BullseyeClosure": (newInstance) => new SharedExamplesForClosure(newInstance)
  };

  // Given the name of a shared behavior and a function that, when called, 
  // returns a new instance of the object that you want to test the behavior of, 
  // this adds a describe() to your SpecMap that tests the given behavior.
  //
  // Example:  shouldBehaveLike("Animal", () => new Dog());
  shouldBehaveLike(String sharedBehaviorName, Function newInstance) {
    if (! sharedBehaviors.containsKey(sharedBehaviorName))
      throw new UnsupportedOperationException("Unknown shared behavior: $sharedBehaviorName.  Register your shared behavior in spec/run.dart");

    var subject     = BullseyeUtils.getClassName(this) + " should behave like " + sharedBehaviorName;
    var examples    = sharedBehaviors[sharedBehaviorName](newInstance).examples;

    describe(subject, examples);
  }
}

// Little interface for making classes that provide shared examples.
interface HasSharedExamples {
  Function newInstance;

  // Your constructor should take a function that, when invoked, 
  // will give you a new instance of the object that these examples 
  // will test the behavior of.
  HasSharedExamples(Function newInstance);

  // Returns a Map that can be provides to a SpecMap describe 
  // with functions that test that the given object (via newInstance())
  // behave as expected.
  Map<String,Function> get examples();
}

// Base implementation of HasSharedExamples
class SharedExampleBase implements HasSharedExamples {
  Function newInstance;
  SharedExampleBase(this.newInstance);
  Map<String,Function> get examples() {
    throw new NotImplementedException();
  }
}
