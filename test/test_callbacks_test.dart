import 'package:test/test.dart';

import 'boilerplate.dart';

void main() {
  group('A', () {
    patrolSetUpAll(setUpAllBody);

    patrolSetUpAll(setUpAllBody);

    group('B', () {
      patrolSetUpAll(setUpAllBody);
      patrolSetUpAll(setUpAllBody);
      patrolSetUpAll(setUpAllBody);
      patrolSetUpAll(setUpAllBody);

      group('C', () {
        patrolSetUpAll(setUpAllBody);
        patrolSetUpAll(setUpAllBody);
      });
    });

    patrolTest('testA', testBody);
    patrolTest('testB', testBody);
    patrolTest('testC', testBody);
  });

  tearDownAll(() {
    print('Reporting status!');
    printSetUpAlls();
  });
}
