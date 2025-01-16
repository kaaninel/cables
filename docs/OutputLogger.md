# OutputLogger Mixin

## Purpose

The `OutputLogger` mixin is used to log the output events of a stream. It provides a mechanism to attach logging configurations to the output stream, allowing developers to monitor and debug the output events.

## Methods and Properties

### `outputLogger(LogConfig<T> config)`

- **Description**: Attaches a logging configuration to the output stream.
- **Parameters**:
  - `config`: An instance of `LogConfig<T>` that defines the logging behavior.
- **Usage**:
  ```dart
  void outputLogger(LogConfig<T> config) =>
      outputStream.stream.forEach(config.onLog);
  ```

## Usage Examples

### Example 1: Basic Usage

```dart
import 'package:kablo/kablo.dart';

class MyOutputLogger with OutputLogger<int> {
  MyOutputLogger() {
    outputLogger(PrintLog<int>(name: 'MyOutputLogger'));
  }

  void addOutput(int value) {
    outputStream.add(value);
  }
}

void main() {
  final logger = MyOutputLogger();
  logger.addOutput(1);
  logger.addOutput(2);
  logger.addOutput(3);
}
```

### Example 2: Custom Logging Configuration

```dart
import 'package:kablo/kablo.dart';

class CustomLogConfig extends LogConfig<int> {
  CustomLogConfig() : super(name: 'CustomLogger');

  @override
  void onLog(int? obj) {
    print('Custom log: $obj');
  }
}

class MyOutputLogger with OutputLogger<int> {
  MyOutputLogger() {
    outputLogger(CustomLogConfig());
  }

  void addOutput(int value) {
    outputStream.add(value);
  }
}

void main() {
  final logger = MyOutputLogger();
  logger.addOutput(1);
  logger.addOutput(2);
  logger.addOutput(3);
}
```
