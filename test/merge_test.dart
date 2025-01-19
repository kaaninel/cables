import 'package:test/test.dart';
import 'package:kablo/kablo.dart';

void main() {
  group('Merge', () {
    test('addSource', () async {
      final merge = Merge<int>();
      final source1 = Stream<int>.fromIterable([1, 2, 3]);
      final source2 = Stream<int>.fromIterable([4, 5, 6]);

      await merge.addSource(source1);
      await merge.addSource(source2);

      final result = await merge.toList();
      expect(result, [1, 2, 3, 4, 5, 6]);
    });

    test('fromList', () async {
      final source1 = Stream<int>.fromIterable([1, 2, 3]);
      final source2 = Stream<int>.fromIterable([4, 5, 6]);
      final merge = Merge<int>.fromList([source1, source2]);

      final result = await merge.toList();
      expect(result, [1, 2, 3, 4, 5, 6]);
    });
  });
}
