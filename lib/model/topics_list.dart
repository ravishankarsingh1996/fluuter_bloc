import 'package:flutter_assignment/model/topic.dart';

class TopicsList {
  List<Topic>? data;

  TopicsList({this.data});

  TopicsList.fromJson(List<dynamic> jsonList) {
      data = <Topic>[];
      for (var v in jsonList) {
        data!.add(Topic.fromJson(v));
      }
  }

  @override
  String toString() {
    return 'TopicsList{data: $data}';
  }
}
