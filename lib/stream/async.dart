part of '../kablo.dart';

mixin Waiter<T> on Stream<T> {
  int _waiterPending = 0;
  final StreamController<int> _waiterPendings = StreamController<int>();

  void waitFor(Future<void> task) {
    _waiterPendings.add(++_waiterPending);
    task.whenComplete(() => _waiterPendings.add(--_waiterPending));
  }

  StreamSubscription<T> initWaiter(StreamSubscription<T> sub) {
    _waiterPendings.stream.forEach((element) {
      if (element > 0) {
        sub.pause();
      } else if (element == 0) {
        sub.resume();
      } else {
        throw StateError('Subscription have $element active futures.');
      }
    });
    return sub;
  }
}
