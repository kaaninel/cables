# Input Mixin

## Purpose

The `Input` mixin is used to define the input stream for a class. It provides a `StreamSink` interface for adding events to the input stream.

## Methods and Properties

### `add(T event)`

Adds an event to the input stream.

### `addError(Object error, [StackTrace? stackTrace])`

Adds an error to the input stream.

### `addStream(Stream<T> stream)`

Adds a stream of events to the input stream.

### `close()`

Closes the input stream.

### `done`

A `Future` that completes when the input stream is closed.

## Usage Examples

Here is an example of how to use the `Input` mixin:

```dart
import 'package:kablo/kablo.dart';

class MyInputClass with Input<int> {
  void addEvent(int event) {
    add(event);
  }
}

void main() {
  final myInput = MyInputClass();

  myInput.addEvent(1);
  myInput.addEvent(2);
  myInput.addEvent(3);

  myInput.inputStream.stream.listen((event) {
    print('Received: $event');
  });
}
```
