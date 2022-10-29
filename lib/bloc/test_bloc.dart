// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_assignment/bloc/test_event.dart';
import 'package:flutter_assignment/bloc/test_state.dart';
import 'package:flutter_assignment/model/test.dart';
import 'package:flutter_assignment/model/topic.dart';
import 'package:flutter_assignment/repository/topic_repository.dart';
import 'package:flutter_assignment/storage/local_storage_keys.dart';
import 'package:flutter_assignment/storage/local_storage_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  final LocalStorageUseCase _localStorageUseCase;
  final TopicRepository _topicRepository;

  TestBloc(this._localStorageUseCase, this._topicRepository)
      : super(TestState.initialState()) {
    initEventListeners();
    getTestList();
  }

  initEventListeners() {
    on<TestEvent>((event, emit) {
      switch (event.runtimeType) {
        case CreateTestEvent:
          var castedEvent = event as CreateTestEvent;
          updateLocalStorageTestList(castedEvent);
          break;
        case FetchTopicsListEvent:
          fetchTopicList();
          break;
        case UpdateTopicListEvent:
          var castedEvent = event as UpdateTopicListEvent;
          emit.call(TestState.topicListLoadedState(
              castedEvent.topics, event.testName ?? '', state));
          break;
      }
    });
  }

  getTestList() async{
    List<Test> testList = await _localStorageUseCase.getTestList(
      LocalStorageKeys.testList,
    );

    emit(TestState.testListUpdatedState(testList, state));
  }

  fetchTopicList() async {
    emit(TestState.loadingState(true, state));
    var topicList = await _topicRepository.getTopicsList();
    emit(TestState.topicListLoadedState(topicList, '', state));
  }

  updateLocalStorageTestList(CreateTestEvent event) async {
    if (event.testName?.isEmpty == true) {
      emit(TestState.showTestNameAlertState(state));
      return;
    }
    List<Test> testList = await _localStorageUseCase.getTestList(
      LocalStorageKeys.testList,
    );

    List<Topic?> selectedTopics = event.topics.where((e) {
      if (e.isSelected ?? false) {
        return true;
      }

      try {
        if (e.concepts?.firstWhere(
              (Concept element) {
                return element.isSelected ?? false;
              },
            ) !=
            null) {
          return true;
        }
      } catch (e) {
        debugPrint(e.toString());
      }
      return false;
    }).toList();

    var formattedDateTime =
        DateFormat('MMM dd, yyyy kk:mm a').format(DateTime.now());
    testList.add(Test(
        testName: event.testName,
        topics: selectedTopics,
        createdAt: formattedDateTime));

    await _localStorageUseCase.updateTestList(
        LocalStorageKeys.testList, testList);

    emit(TestState.testListUpdatedState(testList, state));
  }
}
