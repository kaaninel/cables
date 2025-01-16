# StateValue Mixin

The `StateValue` mixin is used to manage the state of a stream's output. It allows you to keep track of the latest value emitted by the stream and provides a way to access this value synchronously.

## Purpose

The purpose of the `StateValue` mixin is to provide a mechanism for managing the state of a stream's output. It ensures that the latest value emitted by the stream is always available and can be accessed synchronously.

## Methods and Properties

### Properties

- `value`: The latest value emitted by the stream. This property is updated whenever a new value is emitted by the stream.

### Methods

- `initState()`: Initializes the state management for the stream. This method sets up a subscription to the stream's output and updates the `value` property whenever a new value is emitted.
- `disposeState()`: Disposes of the state management for the stream. This method cancels the subscription to the stream's output.

## Usage Examples

Here is an example of how to use the `StateValue` mixin:

```dart
import 'package:kablo/kablo.dart';

class MyStream extends Stream<int> with StateValue<int, int> {
  MyStream() {
    initState();
  }

  @override
  StreamSubscription<int> listen(void Function(int event)? onData, {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    // Your stream implementation here
  }

  void dispose() {
    disposeState();
  }
}

void main() {
  final myStream = MyStream();

  myStream.listen((value) {
    print('Received: $value');
  });

  // Access the latest value synchronously
  print('Latest value: ${myStream.value}');
}
```

In this example, the `MyStream` class uses the `StateValue` mixin to manage the state of its output. The `initState` method is called in the constructor to set up the state management, and the `disposeState` method is called in the `dispose` method to clean up the state management. The `value` property is used to access the latest value emitted by the stream synchronously.
