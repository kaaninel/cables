# MergeExtension Extension

## Purpose

The `MergeExtension` extension provides a convenient way to convert a stream into a `Merge` instance. This allows you to easily merge multiple streams into a single stream of events.

## Methods and Properties

### `Merge<T> asMerge()`

Converts the stream into a `Merge` instance and adds the current stream as a source.

## Usage Examples

### Example 1: Basic Usage

```dart
import 'package:kablo/kablo.dart';

void main() {
  final stream1 = Stream.fromIterable([1, 2, 3]);
  final stream2 = Stream.fromIterable([4, 5, 6]);

  final merge = stream1.asMerge();
  merge.addSource(stream2);

  merge.listen((value) {
    print('Received: $value');
  });
}
```

### Example 2: Using `asMerge` with Multiple Streams

```dart
import 'package:kablo/kablo.dart';

void main() {
  final stream1 = Stream.fromIterable([1, 2, 3]);
  final stream2 = Stream.fromIterable([4, 5, 6]);
  final stream3 = Stream.fromIterable([7, 8, 9]);

  final merge = stream1.asMerge();
  merge.addSource(stream2);
  merge.addSource(stream3);

  merge.listen((value) {
    print('Received: $value');
  });
}
```
