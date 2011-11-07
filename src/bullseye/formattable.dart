interface BullseyeSpecFormattable {

  void header();

  void footer();

  void beforeDescribe(BullseyeTestFixture testFixture);

  void afterDescribe(BullseyeTestFixture testFixture);

  void beforeTest(BullseyeTest testFixture);

  void afterTest(BullseyeTest testFixture);

}
