# LogConfig

## Purpose

The `LogConfig` class is an abstract class that defines the configuration for logging events in a stream. It provides a way to specify the name and log level for the logging configuration and requires the implementation of the `onLog` method to handle the logging of events.

## Methods and Properties

### `name`

- **Description**: The name of the logging configuration.
- **Type**: `String`
- **Usage**:
  ```dart
  final String name;
  ```

### `level`

- **Description**: The log level of the logging configuration.
- **Type**: `LogLevel`
- **Usage**:
  ```dart
  final LogLevel level;
  ```

### `onLog(T? obj)`

- **Description**: Abstract method that handles the logging of events.
- **Parameters**:
  - `obj`: The event to be logged.
- **Usage**:
  ```dart
  void onLog(T? obj);
  ```

## Usage Examples

### Example 1: Custom Log Configuration

```dart
import 'package:kablo/kablo.dart';

class CustomLogConfig extends LogConfig<int> {
  CustomLogConfig() : super(name: 'CustomLogger');

  @override
  void onLog(int? obj) {
    print('Custom log: $obj');
  }
}

void main() {
  final logConfig = CustomLogConfig();
  logConfig.onLog(42);
}
```

In this example, the `CustomLogConfig` class extends the `LogConfig` class and implements the `onLog` method to handle the logging of events. The `CustomLogConfig` class is then used to log an event with the value `42`.
