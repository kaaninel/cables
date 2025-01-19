part of '../kablo.dart';

/// The `Waiter` mixin is used to manage asynchronous tasks and control the flow of stream subscriptions.
/// It allows you to pause and resume stream subscriptions based on the number of pending asynchronous tasks.
mixin Waiter<T> {
  int _waiterPendings = 0;
  final List<StreamSubscription<T>> subs = [];

  /// Adds a task to the waiter and pauses the stream subscriptions.
  /// The stream subscriptions are resumed when the task is completed.
  void waitFor(Future<void> task) {
    _waiterPendings++;
    _applyWaiter2Subs();
    task.whenComplete(() {
      _waiterPendings--;
      _applyWaiter2Subs();
    });
  }

  /// Initializes the waiter with a stream subscription.
  /// The stream subscription is added to the list of subscriptions managed by the waiter.
  void initWaiter(StreamSubscription<T> sub) {
    subs.add(sub);
    _applyWaiter2Subs();
  }

  /// Applies the waiter state to all stream subscriptions.
  /// Pauses or resumes the stream subscriptions based on the number of pending tasks.
  void _applyWaiter2Subs() {
    for (var sub in subs) {
      _applyWaiter(sub, _waiterPendings);
    }
  }

  /// Applies the waiter state to a single stream subscription.
  /// Pauses or resumes the stream subscription based on the number of pending tasks.
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
