# PipeExtension Extension

The `PipeExtension` extension provides a convenient way to convert a `Stream` into a `Pipe` in the `kablo` library.

## Purpose

The `PipeExtension` extension is designed to simplify the process of converting a `Stream` into a `Pipe`, allowing you to leverage the additional functionality provided by the `Pipe` class.

## Methods and Properties

### Methods

- `asPipe()`: Converts the `Stream` into a `Pipe`.

## Usage Examples

### Basic Usage

```dart
import 'package:kablo/kablo.dart';

void main() {
  final stream = Stream.fromIterable([1, 2, 3]);
  final pipe = stream.asPipe();

  pipe.listen((value) {
    print('Received: $value');
  });
}
```
