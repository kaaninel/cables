# Lag Mixin

The `Lag` mixin is used to calculate the lag between the input and output counts in a stream. It extends the functionality of `InputCounter`, `OutputCounter`, and `Passthrough` mixins.

## Purpose

The purpose of the `Lag` mixin is to provide a way to measure the difference between the number of input events and the number of output events in a stream. This can be useful for monitoring the performance and efficiency of a stream processing system.

## Methods and Properties

### Properties

- `int lag`: The current lag value, which is the difference between the input count and the output count.
- `Stream<int> lags`: A stream of lag values that can be listened to for updates.

### Methods

- `void initLag()`: Initializes the lag calculation by merging the input and output counts and updating the lag value accordingly.

## Usage Examples

Here is an example of how to use the `Lag` mixin in a custom stream class:

```dart
import 'package:kablo/kablo.dart';

class CustomStream<T> extends Stream<T> with Input<T>, Output<T>, Passthrough<T>, InputCounter<T>, OutputCounter<T>, Lag<T> {
  CustomStream() {
    initInputCounter();
    initOutputCounter();
    initLag();
    initPassthrough();
  }

  @override
  StreamSubscription<T> listen(void Function(T event)? onData, {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return outputStream.stream.listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }
}

void main() {
  final customStream = CustomStream<int>();

  customStream.lags.listen((lag) {
    print('Current lag: $lag');
  });

  customStream.add(1);
  customStream.add(2);
  customStream.add(3);
}
```

In this example, the `CustomStream` class uses the `Lag` mixin to calculate and print the lag between the input and output events.
