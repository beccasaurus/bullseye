#import("../lib/specmap.dart");
// #import("../pkg/bullseye.dart");
#import("../src/bullseye.dart");

#source("magic_map_spec.dart");
#source("closure_spec.dart");
#source("spec_spec.dart");
#source("test_spec.dart");
#source("test_fixture_spec.dart");
#source("running_tests_spec.dart");
#source("before_and_after_spec.dart");
#source("pending_test_spec.dart");
#source("run_hooks_spec.dart");
#source("specdoc_formatter_spec.dart");
#source("throwing_exceptions_spec.dart");
#source("xunit_dsl_spec.dart");
#source("samples_spec.dart");
#source("../samples/bowling_spec.dart");

int main() {
  return SpecMap.run([
    new MagicMapSpec(),
    new ClosureSpec(),
    new SpecSpec(),
    new TestSpec(),
    new TestFixtureSpec(),
    new RunningTestsSpec(),
    new BeforeAndAfterSpec(),
    new PendingTestSpec(),
    new RunHooksSpec(),
    new SpecDocFormatterSpec(),
    new ThrowingExceptionsSpec(),
    new xUnitDSLSpec(),
    new SamplesSpec()
  ]);
}

// Our custom SpecMap baseclass.
//
// All of our specs inherit from this so they 
// can use all of the helper methods defined here.
class SpecMap_Bullseye extends SpecMap {

}
