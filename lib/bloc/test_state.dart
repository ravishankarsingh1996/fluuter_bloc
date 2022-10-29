import 'package:flutter_assignment/model/test.dart';
import 'package:flutter_assignment/model/topic.dart';

class TestState {
  final List<Test>? testList;
  final bool? isLoading;
  final bool? showSuccessAlert;
  final bool? showTestNameAlert;
  final List<Topic>? topicList;
  final String? testName;

  TestState._({
    this.testList,
    this.topicList,
    this.testName = '',
    this.isLoading = false,
    this.showSuccessAlert = false,
    this.showTestNameAlert = false,
  });

  TestState.initialState()
      : this._(testList: [], isLoading: true, topicList: []);

  TestState.testListUpdatedState(List<Test> testList, TestState oldState)
      : this._(
            testList: testList,
            isLoading: false,
            showSuccessAlert: true,
            testName: oldState.testName,
            topicList: oldState.topicList);

  TestState.topicListLoadedState(
      List<Topic> topicList, String testName, TestState oldState)
      : this._(
            testList: oldState.testList,
            isLoading: false,
            testName: testName,
            topicList: topicList);

  TestState.testNameUpdatedState(String testName, TestState oldState)
      : this._(
            testList: oldState.testList,
            isLoading: false,
            showSuccessAlert: true,
            testName: testName,
            topicList: oldState.topicList);

  TestState.loadingState(bool isLoading, TestState oldState)
      : this._(
            testList: oldState.testList,
            isLoading: isLoading,
            testName: oldState.testName,
            topicList: oldState.topicList);

  TestState.showTestNameAlertState(TestState oldState)
      : this._(
            testList: oldState.testList,
            isLoading: false,
            testName: oldState.testName,
            showTestNameAlert: true,
            topicList: oldState.topicList);
}
