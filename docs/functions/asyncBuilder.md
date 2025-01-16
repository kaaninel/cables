# `asyncBuilder` Function

The `asyncBuilder` function is a utility function that helps in building widgets asynchronously. It provides a convenient way to handle different states of an asynchronous operation, such as waiting, error, no data, and data received.

## Purpose

The purpose of the `asyncBuilder` function is to simplify the process of building widgets based on the state of an asynchronous operation. It handles the different states and provides appropriate widgets for each state.

## Methods and Properties

### `asyncBuilder`

```dart
AsyncWidgetBuilder<T> asyncBuilder<T>({
  Widget waiting = const CircularProgressIndicator(),
  ErrorWidgetBuilder error = defaultError,
  Widget noData = const Text('No Data'),
  required ValueWidgetBuilder<T> builder,
  Widget? child,
})
```

- `waiting`: A widget to display while the asynchronous operation is in progress. Defaults to `CircularProgressIndicator()`.
- `error`: A widget to display when an error occurs during the asynchronous operation. Defaults to `defaultError`.
- `noData`: A widget to display when there is no data available. Defaults to `Text('No Data')`.
- `builder`: A function that builds the widget based on the received data.
- `child`: An optional child widget to pass to the builder function.

## Usage Examples

Here are some examples of how to use the `asyncBuilder` function:

### Example 1: Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:kablo/kablo.dart';

class MyWidget extends StatelessWidget {
  final Stream<int> stream;

  MyWidget({required this.stream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: stream,
      builder: asyncBuilder<int>(
        builder: (context, data, child) {
          return Text('Data: $data');
        },
      ),
    );
  }
}
```

### Example 2: Custom Waiting and Error Widgets

```dart
import 'package:flutter/material.dart';
import 'package:kablo/kablo.dart';

class MyWidget extends StatelessWidget {
  final Stream<int> stream;

  MyWidget({required this.stream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: stream,
      builder: asyncBuilder<int>(
        waiting: CircularProgressIndicator(),
        error: (details) => Text('Error: ${details.exceptionAsString()}'),
        builder: (context, data, child) {
          return Text('Data: $data');
        },
      ),
    );
  }
}
```
