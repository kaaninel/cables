# InspectLog Class

## Purpose

The `InspectLog` class is a type of `LogConfig` that uses the `inspect` function to log objects. This is useful for debugging purposes, as it allows you to inspect the state of an object at a specific point in time.

## Methods and Properties

### Constructor

```dart
const InspectLog({required super.name});
```

- `name`: The name of the log configuration.

### Methods

#### `onLog`

```dart
@override
void onLog(T? obj) {
  inspect(obj);
}
```

- `obj`: The object to be inspected.

## Usage Examples

Here is an example of how to use the `InspectLog` class:

```dart
import 'package:kablo/kablo.dart';

void main() {
  final log = InspectLog<int>(name: 'InspectLogExample');

  log.onLog(42); // This will inspect the integer 42
}
```
