part of '../kablo.dart';

mixin Waiter<T> {
  int _waiterPendings = 0;
  final List<StreamSubscription<T>> subs = [];

  void waitFor(Future<void> task) {
    _waiterPendings++;
    _applyWaiter2Subs();
    task.whenComplete(() {
      _waiterPendings--;
      _applyWaiter2Subs();
    });
  }

  void initWaiter(StreamSubscription<T> sub) {
    subs.add(sub);
    _applyWaiter2Subs();
  }

  void _applyWaiter2Subs() {
    for (var sub in subs) {
      _applyWaiter(sub, _waiterPendings);
    }
  }

  void _applyWaiter(StreamSubscription<T> sub, int counter) {
    if (counter > 0) {
      sub.pause();
    } else if (counter == 0) {
      sub.resume();
    } else {
      throw StateError('Subscription have $counter active futures.');
    }
  }
}
