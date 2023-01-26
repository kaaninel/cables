part of '../cables.dart';

Widget noDataDefault(BuildContext ctx, void value, Widget? child) =>
    Container();

extension SnapshotWidget<T> on Snapshot<T> {
  StreamBuilder<T?> builderOld({
    Key? key,
    required AsyncWidgetBuilder<T?> builder,
  }) {
    return StreamBuilder<T?>(
        builder: builder, initialData: value, stream: this, key: key);
  }

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

extension AggragateWidget<K, V> on Aggragate<K, V> {
  StreamBuilder<Set<V>> builder({
    Key? key,
    required AsyncWidgetBuilder<Set<V>> builder,
  }) =>
      StreamBuilder<Set<V>>(builder: builder, stream: asSet(), key: key);
}

Widget defaultError(FlutterErrorDetails details) =>
    Text(details.exceptionAsString());

AsyncWidgetBuilder<T> asyncBuilder<T>({
  Widget waiting = const CircularProgressIndicator(),
  ErrorWidgetBuilder error = defaultError,
  Widget noData = const Text('No Data'),
  required ValueWidgetBuilder<T> builder,
  Widget? child,
}) {
  return (context, AsyncSnapshot<T> snapshot) {
    print('error: ${snapshot.error}');
    print('data: ${snapshot.data}');
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
