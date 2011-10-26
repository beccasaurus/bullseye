interface SpecFormattable {

  void header();

  void footer();

  void beforeDescribe(BullseyeTestFixture testFixture);

  void afterDescribe(BullseyeTestFixture testFixture);

  void beforeExample(SpecExample testFixture);

  void afterExample(SpecExample testFixture);

}
