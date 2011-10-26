class BullseyeClosure {

  static bool closuresThrowExceptions = false;
  String description;
  Function fn;
  var returnValue;
  int timeItTookToRunInUs;
  BullseyeMagicMap<String,Object> meta;
  Exception exception;
  var stackTrace;
  bool throwExceptions;

  StopWatch _stopWatch;
  String    _status;
  bool      _run;

  // TestGroup group;

  BullseyeClosure([
     String description = null, Function fn = null, Map<String,Object> meta = null, 
     Iterable<String> tags = null, String tag = null]) 
  {
    this.fn        = fn;
    this.description     = description;
    this.meta            = new BullseyeMagicMap<String,Object>(meta);
    this.throwExceptions = false;
    this._run            = false;

    if (tags != null) this.tags = tags;
    if (tag  != null) this.tags.insertRange(0, 1, tag);
  }

  // // Returns a list of all of this closure's parent groups, starting with 
  // // the outer-most group and ending with this closure's immediate parent group.
  // List<TestGroup> get parentGroups() {
  //   List<TestGroup> allParents = (group == null) ? new List<TestGroup>() : group.parentGroups;
  //   if (group != null) allParents.add(group);
  //   return allParents;
  // }

  // // Returns this closure's "full" description by joining together 
  // // this closure's description with all of its parent groups' descriptions.
  // String get fullDescription() {
  //   String desc = (group == null) ? "" : group.fullDescription;
  //   if (description != null)
  //     desc = desc + " " + description;
  //   return desc;
  // }

  void rerun() {
    _run       = false;
    exception  = null;
    stackTrace = null;
    run();
  }

  void run() {
    if (_run == true)
      throw new UnsupportedOperationException("This cannot be run() more than once.  Try rerun() to explicitly run again.");

    _run = true;

    if (throwExceptions == true || closuresThrowExceptions == true) {
      _startTimer();
      returnValue = fn();
      _stopTimerAndRecordDuration();
      _status = 'passed';
    } else {
      try {
        _startTimer();
        returnValue = fn();
        _status = 'passed';
      } catch (ExpectException ex, var trace) {
        _status    = 'failed';
        exception  = ex;
        stackTrace = trace;
      } catch (Exception ex, var trace) {
        _status    = 'error';
        exception  = ex;
        stackTrace = trace;
      } finally {
        _stopTimerAndRecordDuration();
      }
    }
  }

  String get status() {
    if (_status != null)
      return _status;
    else if (fn == null)
      return "pending";
    else if (_run == true)
      return "run";
    else
      return "not_run";
  }

  Iterable<String> get tags() {
    if (meta["tags"] == null)
      meta["tags"] = new List<String>();
    return meta["tags"];
  }

  void set tags(List<String> values) => meta["tags"] = values;

  void _startTimer() {
    if (_stopWatch == null)
      _stopWatch = new StopWatch();
    _stopWatch.start();
  }

  void _stopTimerAndRecordDuration() {
    _stopWatch.stop();
    timeItTookToRunInUs = _stopWatch.elapsedInUs();
  }
}
