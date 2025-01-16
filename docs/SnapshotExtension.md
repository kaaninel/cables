# SnapshotExtension

## Purpose

The `SnapshotExtension` extension provides a convenient way to convert a `Stream` into a `Snapshot` object. This extension is useful when you want to work with streams and need to capture the latest value emitted by the stream.

## Methods and Properties

### asSnapshot

```dart
Snapshot<T> asSnapshot()
```

Converts the stream into a `Snapshot` object.

#### Returns

- `Snapshot<T>`: A `Snapshot` object that captures the latest value emitted by the stream.

## Usage Examples

### Example 1: Converting a Stream to a Snapshot

```dart
import 'package:kablo/kablo.dart';

void main() {
  final stream = Stream<int>.periodic(Duration(seconds: 1), (count) => count).take(5);
  final snapshot = stream.asSnapshot();

  snapshot.listen((value) {
    print('Snapshot value: $value');
  });
}
```

In this example, a periodic stream is created that emits an integer value every second. The `asSnapshot` method is used to convert the stream into a `Snapshot` object. The `Snapshot` object captures the latest value emitted by the stream and prints it to the console.
