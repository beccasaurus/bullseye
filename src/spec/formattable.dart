interface SpecFormattable {

  void header();

  void footer();

  void beforeSpec(Spec spec);

  void afterSpec(Spec spec);

  void beforeDescribe(SpecDescribe describe);

  void afterDescribe(SpecDescribe describe);

  void beforeExample(SpecExample describe);

  void afterExample(SpecExample describe);

}
