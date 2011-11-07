class Bowling {
  hit(var pins){}
  get score() => 0;
}

class BowlingSpec extends BullseyeSpec {
  spec() {
    it("#score returns 0 for all gutter game", (){
      var bowling = new Bowling();
      for (var i = 0; i < 20; i++)
        bowling.hit(0);
      Expect.equals(0, bowling.score);
    });
  }
}
