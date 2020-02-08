class Ticker {
  Stream<int> tick() {
    return Stream.periodic(Duration(minutes: 1), (x) => null);
  }
}
