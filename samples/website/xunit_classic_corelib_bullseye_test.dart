#import("../../src/bullseye.dart");

class DateTest extends TestCase {
  defineTests() => [testNow, testFarAwayDates, testEquivalentYears];

  static String foo = "bar";

  testNow()             { /* test code */ }
  testFarAwayDates()    { Expect.equals("foo", DateTest.foo); }
  testEquivalentYears() { /* test code */ }
}

main() => Bullseye.run([new DateTest()]);
