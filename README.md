This library helps you use full potential of dart's streams for state
management. It provides primitives for duplex streams such as Input, Output and
Passthrough. You can describe a module's inputs, outputs and basic behaivor via
these primitives.

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

- [Controller](docs/Controller.md)
- [Waiter](docs/Waiter.md)
- [Input](docs/Input.md)
- [Output](docs/Output.md)
- [Passthrough](docs/Passthrough.md)
- [Disposable](docs/Disposable.md)
- [Processor](docs/Processor.md)
- [StateValue](docs/StateValue.md)
- [InputLogger](docs/InputLogger.md)
- [OutputLogger](docs/OutputLogger.md)
- [InputCounter](docs/InputCounter.md)
- [OutputCounter](docs/OutputCounter.md)
- [LogConfig](docs/LogConfig.md)
- [PrintLog](docs/PrintLog.md)
- [InspectLog](docs/InspectLog.md)
- [Lag](docs/Lag.md)
- [Pipe](docs/Pipe.md)
- [Snapshot](docs/Snapshot.md)
- [Point](docs/Point.md)
- [Aggragate](docs/Aggragate.md)
- [Merge](docs/Merge.md)
- [GroupBy](docs/GroupBy.md)
- [SnapshotExtension](docs/SnapshotExtension.md)
- [PipeExtension](docs/PipeExtension.md)
- [AggregateExtension](docs/AggregateExtension.md)
- [AggregateListExtension](docs/AggregateListExtension.md)
- [MergeExtension](docs/MergeExtension.md)
- [MergeIterableExtension](docs/MergeIterableExtension.md)
- [GroupByListExtension](docs/GroupByListExtension.md)
- [GroupByListsExtension](docs/GroupByListsExtension.md)
- [asyncBuilder](docs/asyncBuilder.md)
