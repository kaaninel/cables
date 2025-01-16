# OutputCounter

## Purpose

The `OutputCounter` mixin is used to count the number of output events in a stream. It provides a way to keep track of how many times an output event has been added to the output stream.

## Methods and Properties

### `outputCount`

- **Description**: The number of output events that have been added to the output stream.
- **Type**: `int`

### `outputCounts`

- **Description**: A stream of the output counts.
- **Type**: `Stream<int>`

### `initOutputCounter()`

- **Description**: Initializes the output counter by listening to the output stream and incrementing the `outputCount` for each event.
- **Usage**:
  ```dart
  void initOutputCounter() =>
      outputStream.stream.map((_) => ++outputCount).forEach(_outputCount.add);
  ```

## Usage Examples

### Example 1: Basic Usage

```dart
import 'package:kablo/kablo.dart';

class MyOutputCounter with OutputCounter<int> {
  MyOutputCounter() {
    initOutputCounter();
  }

  void addOutput(int value) {
    outputStream.add(value);
  }
}

void main() {
  final counter = MyOutputCounter();
  counter.outputCounts.listen((count) {
    print('Output count: $count');
  });

  counter.addOutput(1);
  counter.addOutput(2);
  counter.addOutput(3);
}
```

In this example, the `MyOutputCounter` class uses the `OutputCounter` mixin to count the number of output events. The `initOutputCounter` method is called in the constructor to initialize the output counter. The `outputCounts` stream is listened to in the `main` function to print the output count each time an output event is added.
