class DateTest {
  static String foo = "bar";

  static testNow()             { /* test code */ }
  static testFarAwayDates()    { Expect.equals("foo", DateTest.foo); }
  static testEquivalentYears() { /* test code */ }

  static testMain() {
    testNow();
    testFarAwayDates();
    testEquivalentYears();
  }
}

main() => DateTest.testMain();
