class TestSpec extends SpecMap_Bullseye {
  spec() {
    shouldBehaveLike("BullseyeClosure", () => new BullseyeTest());
  }
}
