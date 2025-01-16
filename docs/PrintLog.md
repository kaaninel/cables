# PrintLog

## Purpose

The `PrintLog` class is a concrete implementation of the `LogConfig` class that logs events to the console. It provides options to format the log messages, apply conditions for logging, and sequence the log entries.

## Methods and Properties

### `formatter`

- **Description**: A function that formats the log message.
- **Type**: `Formatter<T, String>?`
- **Usage**:
  ```dart
  final Formatter<T, String>? formatter;
  ```

### `condition`

- **Description**: A function that determines whether the log entry should be logged.
- **Type**: `Condition<T>?`
- **Usage**:
  ```dart
  final Condition<T>? condition;
  ```

### `sequencer`

- **Description**: A function that provides a sequence number for the log entry.
- **Type**: `Sequencer<T>?`
- **Usage**:
  ```dart
  final Sequencer<T>? sequencer;
  ```

### `debugOnly`

- **Description**: A flag indicating whether the log entry should be logged only in debug mode.
- **Type**: `bool`
- **Usage**:
  ```dart
  final bool debugOnly;
  ```

### `format(T? obj)`

- **Description**: Formats the log message using the provided formatter function.
- **Parameters**:
  - `obj`: The event to be logged.
- **Usage**:
  ```dart
  String format(T? obj) => formatter != null ? formatter!(obj) : obj.toString();
  ```

### `onLog(T? obj)`

- **Description**: Logs the event to the console.
- **Parameters**:
  - `obj`: The event to be logged.
- **Usage**:
  ```dart
  @override
  void onLog(T? obj) {
    final seq = sequencer != null ? sequencer!(obj) : null;
    if (condition == null || condition!(obj)) {
      if (!debugOnly || kDebugMode) {
        log(format(obj), time: DateTime.now(), sequenceNumber: seq, name: name);
      }
    }
  }
  ```

## Usage Examples

### Example 1: Basic Usage

```dart
import 'package:kablo/kablo.dart';

void main() {
  final logConfig = PrintLog<int>(name: 'BasicLogger');

  logConfig.onLog(42);
}
```

### Example 2: Custom Formatter and Condition

```dart
import 'package:kablo/kablo.dart';

void main() {
  final logConfig = PrintLog<int>(
    name: 'CustomLogger',
    formatter: (obj) => 'Custom log: $obj',
    condition: (obj) => obj != null && obj > 10,
  );

  logConfig.onLog(5);  // This will not be logged
  logConfig.onLog(15); // This will be logged
}
```
