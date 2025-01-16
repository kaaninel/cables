# Waiter Mixin

The `Waiter` mixin is used to manage the state of asynchronous tasks within a stream. It allows you to pause and resume stream subscriptions based on the number of pending asynchronous tasks.

## Methods and Properties

### `_waiterPendings`

```dart
int _waiterPendings = 0;
```

This private property keeps track of the number of pending asynchronous tasks.

### `subs`

```dart
final List<StreamSubscription<T>> subs = [];
```

This property holds a list of stream subscriptions that are managed by the `Waiter` mixin.

### `waitFor`

```dart
void waitFor(Future<void> task)
```

This method increments the `_waiterPendings` counter and pauses the stream subscriptions. When the task is complete, it decrements the counter and resumes the subscriptions if there are no pending tasks.

### `initWaiter`

```dart
void initWaiter(StreamSubscription<T> sub)
```

This method initializes the `Waiter` mixin by adding a stream subscription to the `subs` list and applying the current state of `_waiterPendings` to the subscription.

### `_applyWaiter2Subs`

```dart
void _applyWaiter2Subs()
```

This private method applies the current state of `_waiterPendings` to all stream subscriptions in the `subs` list.

### `_applyWaiter`

```dart
void _applyWaiter(StreamSubscription<T> sub, int counter)
```

This private method pauses or resumes a stream subscription based on the value of the `counter`.

## Usage Examples

Here is an example of how to use the `Waiter` mixin:

```dart
import 'dart:async';

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

class Example with Waiter<int> {
  final StreamController<int> _controller = StreamController<int>();

  Example() {
    initWaiter(_controller.stream.listen((event) {
      print('Received: $event');
    }));
  }

  void add(int value) {
    _controller.add(value);
  }

  void performAsyncTask() {
    waitFor(Future.delayed(Duration(seconds: 2)));
  }
}

void main() {
  final example = Example();

  example.add(1);
  example.performAsyncTask();
  example.add(2);
  example.add(3);
}
```

In this example, the `Example` class uses the `Waiter` mixin to manage the state of asynchronous tasks. When `performAsyncTask` is called, the stream subscription is paused for 2 seconds and then resumed.
