# Merge Class

## Purpose

The `Merge` class is used to merge multiple streams into a single stream. It provides a way to combine multiple sources of data into a single stream of events.

## Methods and Properties

### `Merge({List<LogConfig<T>>? loggers})`

Constructor to create a new `Merge` instance. Optionally, you can provide a list of loggers to log the input events.

### `Future<void> addSource(Stream<T> source, {bool blocking = false, bool wait = true})`

Adds a new source stream to the `Merge` instance. You can specify whether the source should be blocking and whether to wait for the current blocking sources to complete.

### `static Merge<T> fromList<T>(Iterable<Stream<T>> inputs)`

Creates a new `Merge` instance from a list of input streams.

### `StreamSubscription<T> listen(void Function(T event)? onData, {Function? onError, void Function()? onDone, bool? cancelOnError})`

Overrides the `listen` method to listen to the merged stream of events.

## Usage Examples

### Example 1: Basic Usage

```dart
import 'package:kablo/kablo.dart';

void main() {
  final stream1 = Stream.fromIterable([1, 2, 3]);
  final stream2 = Stream.fromIterable([4, 5, 6]);

  final merge = Merge<int>();
  merge.addSource(stream1);
  merge.addSource(stream2);

  merge.listen((value) {
    print('Received: $value');
  });
}
```

### Example 2: Using `fromList` Method

```dart
import 'package:kablo/kablo.dart';

void main() {
  final stream1 = Stream.fromIterable([1, 2, 3]);
  final stream2 = Stream.fromIterable([4, 5, 6]);

  final merge = Merge.fromList([stream1, stream2]);

  merge.listen((value) {
    print('Received: $value');
  });
}
```
