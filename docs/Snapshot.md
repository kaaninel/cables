# Snapshot Class

The `Snapshot` class is a useful utility for managing state in a stream-based architecture. It extends the `Point` class and provides additional functionality for caching values and counting input events.

## Purpose

The `Snapshot` class is designed to hold a value that can be updated through a stream. It provides methods to access the current value, count input events, and check if the value is null or not.

## Methods and Properties

### Properties

- `value`: The current value of the `Snapshot`. It can be `null`.
- `inputCount`: The number of input events received by the `Snapshot`.
- `hasData`: A boolean indicating whether the `Snapshot` has received any data.

### Methods

- `firstNotNull`: Returns the first non-null value received by the `Snapshot`.
- `whereNotNull`: Returns a `Pipe` that filters out null values from the `Snapshot`.

## Usage Examples

### Basic Usage

```dart
import 'package:kablo/kablo.dart';

void main() {
  final snapshot = Snapshot<int>();

  snapshot.listen((value) {
    print('Received: $value');
  });

  snapshot.add(1);
  snapshot.add(2);
  snapshot.add(null);
  snapshot.add(3);
}
```

### Filtering Non-Null Values

```dart
import 'package:kablo/kablo.dart';

void main() {
  final snapshot = Snapshot<int>();

  final nonNullValues = snapshot.whereNotNull();

  nonNullValues.listen((value) {
    print('Non-null value: $value');
  });

  snapshot.add(1);
  snapshot.add(null);
  snapshot.add(2);
}
```
