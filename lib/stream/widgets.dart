part of '../kablo.dart';

/// Default widget to display when there is no data.
Widget noDataDefault(BuildContext ctx, void value, Widget? child) =>
    Container();

/// Extension on `Snapshot` to provide widget builders for stream data.
extension SnapshotWidget<T> on Snapshot<T> {
  /// Creates a `StreamBuilder` with the given `AsyncWidgetBuilder`.
  StreamBuilder<T?> builderOld({
    Key? key,
    required AsyncWidgetBuilder<T?> builder,
  }) {
    return StreamBuilder<T?>(
        builder: builder, initialData: value, stream: this, key: key);
  }

  /// Creates a `StreamBuilder` with the given `ValueWidgetBuilder`.
  /// Displays a progress indicator while waiting for data, and a default widget when there is no data.
  StreamBuilder<T?> builder({
    Key? key,
    required ValueWidgetBuilder<T> builder,
    ValueWidgetBuilder<void> noData = noDataDefault,
    ProgressIndicator indicator = const CircularProgressIndicator(),
    Widget? child,
  }) =>
      StreamBuilder<T?>(
          builder: (ctx, snap) {
            if (snap.hasError) return ErrorWidget(snap.error!);
            if (snap.hasData) {
              return builder(ctx, snap.data as T, child);
            } else {
              return noData(ctx, null, child);
            }
          },
          initialData: value,
          stream: this,
          key: key);
}

/// Extension on `Aggragate` to provide widget builders for aggregated stream data.
extension AggragateWidget<K, V> on Aggragate<K, V> {
  /// Creates a `StreamBuilder` with the given `AsyncWidgetBuilder` for the aggregated set of values.
  StreamBuilder<Set<V>> builder({
    Key? key,
    required AsyncWidgetBuilder<Set<V>> builder,
  }) =>
      StreamBuilder<Set<V>>(builder: builder, stream: asSet(), key: key);
}

/// Default error widget to display when there is an error.
Widget defaultError(FlutterErrorDetails details) =>
    Text(details.exceptionAsString());

/// Creates an `AsyncWidgetBuilder` with the given parameters.
/// Displays a progress indicator while waiting for data, an error widget when there is an error, and a default widget when there is no data.
AsyncWidgetBuilder<T> asyncBuilder<T>({
  Widget waiting = const CircularProgressIndicator(),
  ErrorWidgetBuilder error = defaultError,
  Widget noData = const Text('No Data'),
  required ValueWidgetBuilder<T> builder,
  Widget? child,
}) {
  return (context, AsyncSnapshot<T> snapshot) {
    if (kDebugMode) {
      print('error: ${snapshot.error}');
      print('data: ${snapshot.data}');
    }
    if (snapshot.hasError) {
      return error(FlutterErrorDetails(exception: snapshot.error!));
    } else if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: waiting);
    } else if (!snapshot.hasData) {
      return noData;
    } else if (snapshot.connectionState == ConnectionState.done ||
        snapshot.connectionState == ConnectionState.active) {
      return builder(context, snapshot.data as T, child);
    }
    throw StateError('Unknown widget State');
  };
}
