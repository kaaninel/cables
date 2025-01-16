# Kablo

Welcome to Kablo, a powerful library that helps you harness the full potential of Dart's streams for state management. With Kablo, you can easily create and manage duplex streams, define module inputs and outputs, and leverage various mixins for additional functionality.

## Installation

To use this library, add `kablo` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  kablo: ^1.0.1
```

Then, run `flutter pub get` to install the package.

## Basic Usage

Here is a simple example of how to use the `Pipe` class:

```dart
import 'package:kablo/kablo.dart';

void main() {
  final pipe = Pipe<int>();

  pipe.listen((value) {
    print('Received: $value');
  });

  pipe.add(1);
  pipe.add(2);
  pipe.add(3);
}
```

## Detailed Class Documentation

For detailed documentation on each class, please refer to the following files:

### Classes
- [Aggragate](docs/classes/Aggragate.md)
- [Controller](docs/classes/Controller.md)
- [GroupBy](docs/classes/GroupBy.md)
- [Merge](docs/classes/Merge.md)
- [Pipe](docs/classes/Pipe.md)
- [asyncBuilder](docs/functions/asyncBuilder.md)

### Mixins
- [Disposable](docs/mixins/Disposable.md)
- [Input](docs/mixins/Input.md)
- [InputCounter](docs/mixins/InputCounter.md)
- [InputLogger](docs/mixins/InputLogger.md)
- [Lag](docs/mixins/Lag.md)
- [LogConfig](docs/mixins/LogConfig.md)
- [Output](docs/mixins/Output.md)

### Extensions
- [AggregateExtension](docs/extensions/AggregateExtension.md)
- [AggregateListExtension](docs/extensions/AggregateListExtension.md)
- [GroupByListExtension](docs/extensions/GroupByListExtension.md)
- [GroupByListsExtension](docs/extensions/GroupByListsExtension.md)
- [MergeExtension](docs/extensions/MergeExtension.md)
- [MergeIterableExtension](docs/extensions/MergeIterableExtension.md)
- [PipeExtension](docs/extensions/PipeExtension.md)

## Note

This documentation is AI-generated and may contain inaccuracies. Please refer to the source code and official documentation for the most accurate and up-to-date information.
