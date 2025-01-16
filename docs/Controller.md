# Controller Class

The `Controller` class is an abstract class that extends `Stream` and is a key component of the library. It is designed to manage the flow of data between input and output streams, providing various mixins for additional functionality.

## Purpose

The `Controller` class is used to process tasks and manage the state of the output stream. It combines several mixins to provide features such as input and output handling, state management, logging, and more.

## Methods and Properties

### Properties

- `S value`: The current state value of the output stream.

### Methods

- `Controller(S value, {List<LogConfig<T>>? inputLogs, List<LogConfig<S>>? outputLogs})`: Constructor to initialize the `Controller` with an initial state value and optional input and output log configurations.
- `void dispose()`: Disposes of the resources used by the `Controller`.
- `Stream<S> onTask(T task)`: Abstract method to process a task and return a stream of output values.
- `Stream<S> processor(Stream<T> input)`: Processes the input stream and yields the output stream.

## Usage Examples

Here is an example of how to use the `Controller` class:

```dart
import 'package:kablo/kablo.dart';

class MyController extends Controller<int, String> {
  MyController(String initialValue) : super(initialValue);

  @override
  Stream<String> onTask(int task) async* {
    yield 'Task $task processed';
  }
}

void main() {
  final controller = MyController('Initial Value');

  controller.listen((value) {
    print('Received: $value');
  });

  controller.add(1);
  controller.add(2);
  controller.add(3);
}
```
