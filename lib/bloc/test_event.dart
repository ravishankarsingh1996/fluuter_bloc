import 'package:flutter_assignment/model/topic.dart';

abstract class TestEvent {}

class CreateTestEvent extends TestEvent {
  final List<Topic> topics;
  final String? testName;

  CreateTestEvent(
    this.testName,
    this.topics,
  );
}

class UpdateTopicListEvent extends TestEvent {
  final List<Topic> topics;
  final String? testName;

  UpdateTopicListEvent(
    this.testName,
    this.topics,
  );
}



class FetchTopicsListEvent extends TestEvent {}

