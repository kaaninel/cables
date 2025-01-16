# MergeIterableExtension Extension

## Purpose

The `MergeIterableExtension` extension provides a convenient way to merge multiple streams into a single `Merge` instance. This allows you to easily combine multiple streams into a single stream of events.

## Methods and Properties

### `Merge<T> asMerge()`

Converts the iterable of streams into a `Merge` instance and adds each stream as a source.

## Usage Examples

### Example 1: Basic Usage

```dart
import 'package:kablo/kablo.dart';

void main() {
  final stream1 = Stream.fromIterable([1, 2, 3]);
  final stream2 = Stream.fromIterable([4, 5, 6]);
  final stream3 = Stream.fromIterable([7, 8, 9]);

  final merge = [stream1, stream2, stream3].asMerge();

  merge.listen((value) {
    print('Received: $value');
  });
}
```

### Example 2: Using `asMerge` with Different Stream Types

```dart
import 'package:kablo/kablo.dart';

void main() {
  final stream1 = Stream<int>.fromIterable([1, 2, 3]);
  final stream2 = Stream<int>.fromIterable([4, 5, 6]);
  final stream3 = Stream<int>.fromIterable([7, 8, 9]);

  final merge = [stream1, stream2, stream3].asMerge();

  merge.listen((value) {
    print('Received: $value');
  });
}
```
