# Output Mixin

The `Output` mixin is used to provide an output stream for a class. It allows other classes to listen to the output stream and receive events.

## Methods and Properties

### `listen`

```dart
StreamSubscription<T> listen(
  void Function(T event)? onData, {
  Function? onError,
  void Function()? onDone,
  bool? cancelOnError,
})
```

Listens to the output stream and calls the provided callbacks when events are received.

### `outputStream`

```dart
final StreamController<T> outputStream
```

The `StreamController` that manages the output stream.

## Usage Examples

### Example 1: Basic Usage

```dart
import 'package:kablo/kablo.dart';

class MyOutputClass with Output<int> {
  void emit(int value) {
    outputStream.add(value);
  }
}

void main() {
  final myOutput = MyOutputClass();

  myOutput.listen((value) {
    print('Received: $value');
  });

  myOutput.emit(1);
  myOutput.emit(2);
  myOutput.emit(3);
}
```

In this example, the `MyOutputClass` class uses the `Output` mixin to provide an output stream. The `emit` method adds values to the output stream, and the `listen` method listens for events and prints them.

### Example 2: Error Handling

```dart
import 'package:kablo/kablo.dart';

class MyOutputClass with Output<int> {
  void emit(int value) {
    outputStream.add(value);
  }

  void emitError(Object error) {
    outputStream.addError(error);
  }
}

void main() {
  final myOutput = MyOutputClass();

  myOutput.listen(
    (value) {
      print('Received: $value');
    },
    onError: (error) {
      print('Error: $error');
    },
  );

  myOutput.emit(1);
  myOutput.emitError('An error occurred');
  myOutput.emit(2);
}
```

In this example, the `MyOutputClass` class uses the `Output` mixin to provide an output stream and handle errors. The `emitError` method adds an error to the output stream, and the `listen` method listens for events and errors, printing them accordingly.
