import 'package:test/test.dart';
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

      await Future.delayed(Duration(milliseconds: 100));

      expect(groupBy.value, {
        5: ['apple'],
        6: ['banana'],
        6: ['cherry'],
      });
    });

    test('fromList method', () async {
      final groupBy = GroupBy.fromList(
        ['apple', 'banana', 'cherry'],
        (value) async* {
          yield value.length;
        },
      );

      await Future.delayed(Duration(milliseconds: 100));

      expect(groupBy.value, {
        5: ['apple'],
        6: ['banana'],
        6: ['cherry'],
      });
    });

    test('fromLists method', () async {
      final groupByStream = GroupBy.fromLists(
        Stream.fromIterable([
          ['apple', 'banana'],
          ['cherry', 'date'],
        ]),
        (value) async* {
          yield value.length;
        },
      );

      await Future.delayed(Duration(milliseconds: 100));

      await for (final groupBy in groupByStream) {
        expect(groupBy.value, {
          5: ['apple'],
          6: ['banana'],
          6: ['cherry'],
          4: ['date'],
        });
      }
    });
  });
}
