#import("../lib/specmap.dart");
// #import("../pkg/bullseye.dart");
#import("../src/bullseye.dart");

#source("acts_as_closure_spec.dart");
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

    new ActsAsClosureSpec(() => new BullseyeClosure()),
    new ActsAsClosureSpec(() => new BullseyeTest()),
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

}
