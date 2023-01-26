part of '../cables.dart';

extension SnapshotExtension<T> on Stream<T> {
  Snapshot<T> asSnapshot() => Snapshot()..addStream(this);
}

extension PipeExtension<T> on Stream<T> {
  Pipe<T> asPipe() => Pipe()..addStream(this);
}

extension AggregateExtension<K, V> on Stream<MapEntry<K, V>> {
  Aggragate<K, V> asAggragate() => Aggragate()..addStream(this);
}

extension AggregateListExtension<V> on List<Stream<V>> {
  Aggragate<int, V> asAggragate() => Aggragate.fromStreams(this);
}

extension MergeExtension<T> on Stream<T> {
  Merge<T> asMerge() => Merge()..addStream(this);
}

extension MergeIterableExtension<T> on Iterable<Stream<T>> {
  Merge<T> asMerge() => Merge.fromList(this);
}

extension GroupByListExtension<V> on List<V> {
  GroupBy<int, V> asGroupBy(Stream<int> Function(V e) builder) =>
      GroupBy.fromList(this, builder);
}

extension GroupByListsExtension<V> on Stream<List<V>> {
  Stream<GroupBy<int, V>> asGroupBy(Stream<int> Function(V e) builder) =>
      GroupBy.fromLists(this, builder);
}
