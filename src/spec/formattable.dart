interface SpecFormattable {

  void header();

  void footer();

  void beforeDescribe(SpecDescribe describe);

  void afterDescribe(SpecDescribe describe);

  void beforeExample(SpecExample describe);

  void afterExample(SpecExample describe);

}
