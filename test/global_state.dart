// ignore: depend_on_referenced_packages
import 'package:test_api/src/backend/invoker.dart';

// Input
const String requestedTest = 'A testA';

/// A list holding IDs of all setUpAll callbacks.
///
/// This is basically the list of groupNames + an index appended.
List<String> setUpAlls = [];

String get currentTestFullName {
  final invoker = Invoker.current!;

  final parentGroupName = invoker.liveTest.groups.last.name;
  final testName = invoker.liveTest.individualName;

  var nameCandidate = '$parentGroupName $testName';
  if (nameCandidate.length > 190) {
    nameCandidate = nameCandidate.substring(0, 190);
  }
  return nameCandidate;
}

/// Returns the name of the current group.
///
/// Includes all ancestor groups.
String get currentGroupFullName {
  return Invoker.current!.liveTest.groups.last.name;
}

/// Returns the individual name of the current test.
///
/// Omits all ancestor groups.
String get currentTestIndividualName {
  return Invoker.current!.liveTest.individualName;
}
