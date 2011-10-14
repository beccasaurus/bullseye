#import("../src/spec.dart");

#source("bowling_spec.dart");

int main() => Specs.run([ new BowlingSpec() ]);
