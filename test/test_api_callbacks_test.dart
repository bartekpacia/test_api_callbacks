import 'package:meta/meta.dart';
import 'package:test/test.dart';
// ignore: depend_on_referenced_packages
import 'package:test_api/src/backend/invoker.dart';

// Input:
const String requestedTest = 'A testA';

/// A list holding IDs of all setUpAll callbacks.
///
/// This is basically the list of groupNames + an index appended.
List<String> setUpAlls = [];

/// Adds a setUpAll callback to the list of all setUpAll callbacks.
///
/// Returns the name under which this setUpAll callback was added.
String addSetUpAll(String group) {
  // Not optimal, but good enough for now.

  // Go over all groups, checking if the group is already in the list.
  var groupIndex = 0;
  for (final setUpAll in setUpAlls) {
    final parts = setUpAll.split(' ');
    final groupName = parts.sublist(0, parts.length - 1).join(' ');

    if (groupName == group) {
      groupIndex++;
    }
  }

  final name = '$group $groupIndex';

  setUpAlls.add(name);
  return name;
}

void printSetUpAlls() {
  print('setUpAlls:');
  for (final setUpAll in setUpAlls) {
    print('  $setUpAll');
  }
}

void main() {
  group('A', () {
    customSetUpAll(_setUpAllBody);

    customSetUpAll(_setUpAllBody);

    group('B', () {
      customSetUpAll(_setUpAllBody);
      customSetUpAll(_setUpAllBody);
      customSetUpAll(_setUpAllBody);
      customSetUpAll(_setUpAllBody);

      group('C', () {
        customSetUpAll(_setUpAllBody);
        customSetUpAll(_setUpAllBody);
      });
    });

    patrolTest('testA', _testBody);
    patrolTest('testB', _testBody);
    patrolTest('testC', _testBody);
  });

  tearDownAll(() {
    print('Reporting status!');
    printSetUpAlls();
  });
}

Future<void> _testBody() async {
  print(Invoker.current!.fullCurrentTestName);
}

Future<void> _setUpAllBody() async {
  print(Invoker.current!.currentGroupFullName);
}

void patrolTest(String name, Future<void> Function() body) {
  test(name, () async {
    final currentTest = Invoker.current!.fullCurrentTestName;

    if (currentTest == requestedTest) {
      print('Requested test $currentTest, will execute it');
      await body();
    }
  });
}

/// A modification of [setUpAll] that works with Patrol's native automation.
///
/// It keeps track of calls made to setUpAll.
void customSetUpAll(Future<void> Function() body) {
  setUpAll(() async {
    final parentGroupsName = Invoker.current!.liveTest.groups.last.name;

    final name = addSetUpAll(parentGroupsName);

    // Skip calling body if is in test discovery phase

    // Skip calling body if it was already executed

    body();
  });
}

/// Provides convenience methods for [Invoker].
@internal
extension InvokerX on Invoker {
  /// Returns the full name of the current test (names of all ancestor groups +
  /// name of the current test).
  String get fullCurrentTestName {
    final parentGroupName = liveTest.groups.last.name;
    final testName = liveTest.individualName;

    return '$parentGroupName $testName';
  }

  /// Returns the name of the current test only. No group prefixes.
  String get currentTestName => liveTest.individualName;

  String get currentGroupFullName => Invoker.current!.liveTest.groups.last.name;
}
