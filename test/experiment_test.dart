import 'package:test/test.dart';
// ignore: depend_on_referenced_packages
import 'package:test_api/src/backend/invoker.dart';

// Question: Can setUpAlls() in sibling groups run after tests in another group?
// Answer: yes.

// Problem: All tests are *always executed*. Yes, they're skipped, but they're
// still executed. This means their setUpAll callbacks run.
// Question: How to know whether to skip execution of a setUpAll callbacks?

// Idea
//
// If, inside setUpAll calllback, the requestedTestName contains the whole
// parentGroupName, then execute the callbacks. Otherwise skip it.

void main() {
  group('A', () {
    setUpAll(_setUpAllBody);
    setUpAll(_setUpAllBody);

    test('testA', _testBody);
    test('testB', _testBody);
    test('testC', _testBody);
  });

  group('B', () {
    // Question: do the 2 setUpAlls below run before tests in group A?
    // Answer: no, of course not.

    setUpAll(_setUpAllBody);
    setUpAll(_setUpAllBody);

    test('testA', _testBody);
    test('testB', _testBody);
    test('testC', _testBody);
  });
}

Future<void> _testBody() async {
  print(Invoker.current!.fullCurrentTestName);
}

Future<void> _setUpAllBody() async {
  print('setUpAll in group ${Invoker.current!.currentGroupFullName}');
}

extension on Invoker {
  String get fullCurrentTestName {
    final parentGroupName = liveTest.groups.last.name;
    final testName = liveTest.individualName;

    return '$parentGroupName $testName';
  }

  String get currentGroupFullName => Invoker.current!.liveTest.groups.last.name;
}
