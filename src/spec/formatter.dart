class SpecFormatter {

  Function _loggingFunction;

  bool printToStdout;

  void logger(Function fn) {
    _loggingFunction = fn;
  }

  void header(){}
  void footer(){}
  void beforeSpec(Spec spec){}
  void afterSpec(Spec Spec){}
  void beforeDescribe(SpecDescribe describe){}
  void afterDescribe(SpecDescribe describe){}
  void beforeExample(SpecExample example){}
  void afterExample(SpecExample example){}

  void write(String text) {
    if (printToStdout)
      print(text);
    if (_loggingFunction != null)
      _loggingFunction(text);
  }
}
