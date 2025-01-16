# Pipe Class

The `Pipe` class is a fundamental building block in the `kablo` library. It provides a way to create a duplex stream with input and output capabilities, along with various mixins for additional functionality.

## Purpose

The `Pipe` class is designed to facilitate the creation of duplex streams, allowing data to flow in both directions. It combines several mixins to provide input, output, passthrough, logging, and lag tracking capabilities.

## Methods and Properties

### Properties

- `inputStream`: A `StreamController` for handling input events.
- `outputStream`: A `StreamController` for handling output events.
- `inputCount`: An integer representing the number of input events.
- `outputCount`: An integer representing the number of output events.
- `lag`: An integer representing the lag between input and output events.

### Methods

- `add(T event)`: Adds an event to the input stream.
- `addError(Object error, [StackTrace? stackTrace])`: Adds an error to the input stream.
- `addStream(Stream<T> stream)`: Adds a stream of events to the input stream.
- `close()`: Closes the input stream.
- `done`: A future that completes when the input stream is closed.
- `listen(void Function(T event)? onData, {Function? onError, void Function()? onDone, bool? cancelOnError})`: Listens to the output stream.
- `initPassthrough()`: Initializes the passthrough functionality.
- `disposePassthrough()`: Disposes of the passthrough functionality.
- `initInputCounter()`: Initializes the input counter.
- `initOutputCounter()`: Initializes the output counter.
- `initLag()`: Initializes the lag tracking.
- `inputLogger(LogConfig<T> config)`: Logs input events based on the provided configuration.

## Usage Examples

### Basic Usage

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

### Using Lag Tracking

```dart
import 'package:kablo/kablo.dart';

void main() {
  final pipe = Pipe<int>();

  pipe.lags.listen((lag) {
    print('Current lag: $lag');
  });

  pipe.add(1);
  pipe.add(2);
  pipe.add(3);
}
```

### Logging Input Events

```dart
import 'package:kablo/kablo.dart';

void main() {
  final pipe = Pipe<int>(
    loggers: [PrintLog(name: 'InputLogger')],
  );

  pipe.add(1);
  pipe.add(2);
  pipe.add(3);
}
```
