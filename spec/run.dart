#import("../lib/specmap.dart");
#import("../src/spec.dart");

#source("spec_spec.dart");
#source("example_spec.dart");
#source("describe_spec.dart");

int main() => SpecMap.run([
  new SpecSpec(), new ExampleSpec(), new DescribeSpec()
]);
