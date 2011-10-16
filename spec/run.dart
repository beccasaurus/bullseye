#import("../lib/specmap.dart");
#import("../pkg/spec.dart");

#source("spec_spec.dart");
#source("example_spec.dart");
#source("describe_spec.dart");
#source("running_examples_spec.dart");
#source("before_and_after_spec.dart");
#source("pending_example_spec.dart");
#source("run_hooks_spec.dart");
#source("specdoc_formatter_spec.dart");
#source("throwing_exceptions_spec.dart");
#source("samples_spec.dart");
#source("../samples/bowling_spec.dart");

int main() {
  SpecMap.raiseExceptions = true;
  return SpecMap.run([
    new SpecSpec(),
    new ExampleSpec(),
    new DescribeSpec(),
    new RunningExamplesSpec(),
    new BeforeAndAfterSpec(),
    new PendingExampleSpec(),
    new RunHooksSpec(),
    new SpecDocFormatterSpec(),
    new ThrowingExceptionsSpec(),
    new SamplesSpec()
  ]);
}

// Our custom SpecMap baseclass.
//
// All of our specs inherit from this so they 
// can use all of the helper methods defined here.
class SpecDartTest extends SpecMap {

}
