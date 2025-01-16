# InputCounter

## Purpose

The `InputCounter` mixin is used to count the number of input events in a stream. It provides a way to keep track of how many times an input event has been added to the input stream.

## Methods and Properties

### `inputCount`

- **Description**: The number of input events that have been added to the input stream.
- **Type**: `int`

### `inputCounts`

- **Description**: A stream of the input counts.
- **Type**: `Stream<int>`

### `initInputCounter()`

- **Description**: Initializes the input counter by listening to the input stream and incrementing the `inputCount` for each event.
- **Usage**:
  ```dart
  void initInputCounter() =>
      inputStream.stream.map((_) => ++inputCount).forEach(_inputCount.add);
  ```

## Usage Examples

### Example 1: Basic Usage

```dart
import 'package:kablo/kablo.dart';

class MyInputCounter with InputCounter<int> {
  MyInputCounter() {
    initInputCounter();
  }

  void addInput(int value) {
    inputStream.add(value);
  }
}

void main() {
  final counter = MyInputCounter();
  counter.inputCounts.listen((count) {
    print('Input count: $count');
  });

  counter.addInput(1);
  counter.addInput(2);
  counter.addInput(3);
}
```

In this example, the `MyInputCounter` class uses the `InputCounter` mixin to count the number of input events. The `initInputCounter` method is called in the constructor to initialize the input counter. The `inputCounts` stream is listened to in the `main` function to print the input count each time an input event is added.
