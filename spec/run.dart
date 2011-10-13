#import("../lib/specmap.dart");
#import("../src/spec.dart");

#source("spec_spec.dart");
#source("example_spec.dart");
#source("describe_spec.dart");
#source("running_examples_spec.dart");
#source("before_and_after_spec.dart");

int main() {
  SpecMap.raiseExceptions = true;
  return SpecMap.run([
    new SpecSpec(),
    new ExampleSpec(),
    new DescribeSpec(),
    new RunningExamplesSpec(),
    new BeforeAndAfterSpec()
  ]);
}
