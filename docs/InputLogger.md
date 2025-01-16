# InputLogger

## Purpose

The `InputLogger` mixin is used to log input events in a stream. It provides a way to attach logging configurations to the input stream of a class that implements the `Input` mixin.

## Methods and Properties

### `inputLogger(LogConfig<T> config)`

- **Description**: Attaches a logging configuration to the input stream.
- **Parameters**:
  - `config`: An instance of `LogConfig<T>` that defines the logging behavior.
- **Usage**:
  ```dart
  void inputLogger(LogConfig<T> config) =>
      inputStream.stream.forEach(config.onLog);
  ```

## Usage Examples

### Example 1: Logging Input Events

```dart
import 'package:kablo/kablo.dart';

class MyController extends Controller<int, String> {
  MyController(String value) : super(value) {
    inputLogger(PrintLog<int>(name: 'InputLogger'));
  }

  @override
  Stream<String> onTask(int task) async* {
    yield 'Task $task';
  }
}

void main() {
  final controller = MyController('Initial Value');

  controller.add(1);
  controller.add(2);
  controller.add(3);
}
```

In this example, the `MyController` class extends the `Controller` class and uses the `InputLogger` mixin to log input events. The `PrintLog` class is used to define the logging behavior, and the `inputLogger` method attaches this logging configuration to the input stream.
