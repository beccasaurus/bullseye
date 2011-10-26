#import("../src/spec.dart");

#source("bowling_spec.dart");

int main() => Bullseye.run([ new BowlingSpec() ]);
