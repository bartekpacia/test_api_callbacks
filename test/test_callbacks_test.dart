import 'package:test/test.dart';

// ignore: depend_on_referenced_packages

import 'boilerplate.dart';

void main() {
  group('A', () {
    customSetUpAll(setUpAllBody);

    customSetUpAll(setUpAllBody);

    group('B', () {
      customSetUpAll(setUpAllBody);
      customSetUpAll(setUpAllBody);
      customSetUpAll(setUpAllBody);
      customSetUpAll(setUpAllBody);

      group('C', () {
        customSetUpAll(setUpAllBody);
        customSetUpAll(setUpAllBody);
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
