import 'package:flutter_test/flutter_test.dart';
import 'package:kablo/kablo.dart';

void main() {
  group('GroupBy', () {
    test('add method', () async {
      final groupBy = GroupBy<int, String>(builder: (value) async* {
        yield value.length;
      });

      groupBy.add('apple');
      groupBy.add('banana');
      groupBy.add('cherry');

      await Future.delayed(const Duration(milliseconds: 100));

      expect(groupBy.value, {
        5: ['apple'],
        6: ['banana', 'cherry'],
      });
    });

    test('fromList method', () async {
      final groupBy = GroupBy.fromList(
        ['apple', 'banana', 'cherry'],
        (value) async* {
          yield value.length;
        },
      );

      await Future.delayed(const Duration(milliseconds: 100));

      expect(groupBy.value, {
        5: ['apple'],
        6: ['banana', 'cherry'],
      });
    });
  });
}
