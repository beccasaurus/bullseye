#import("../lib/specmap.dart");
// #import("../pkg/bullseye.dart");
#import("../src/bullseye.dart");

#source("spec_spec.dart");
#source("test_spec.dart");
#source("test_fixture_spec.dart");
#source("running_examples_spec.dart");
#source("before_and_after_spec.dart");
#source("pending_example_spec.dart");
#source("run_hooks_spec.dart");
#source("specdoc_formatter_spec.dart");
#source("throwing_exceptions_spec.dart");
#source("xunit_dsl_spec.dart");
#source("samples_spec.dart");
#source("../samples/bowling_spec.dart");

int main() {
  return SpecMap.run([
    new SpecSpec(),
    new TestSpec(),
    new TestFixtureSpec(),
    new RunningExamplesSpec(),
    new BeforeAndAfterSpec(),
    new PendingExampleSpec(),
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
class SpecDartTest extends SpecMap {

}
