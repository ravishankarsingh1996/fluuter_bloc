import 'package:flutter_assignment/model/topic.dart';

class Test {
  String? testName;
  List<Topic?>? topics;
  String? createdAt;

  Test({this.testName, this.topics, this.createdAt});

  Test.fromJson(Map<String, dynamic> json) {
    testName = json['testName'];
    createdAt = json['createdAt'];
    if(json['topics'] != null){
      topics = <Topic>[];
      for (var v in json['topics']) {
        topics!.add(Topic.fromJson(v));
      }
    }
  }

  Map toJson() {
    List<Map>? topics =this.topics?.map((i) => i!.toJson()).toList();
    return {'testName': testName, 'createdAt': createdAt, 'topics': topics};
  }

  static Map<String, dynamic> toMap(Test test) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['testName'] = test.testName;
    data['createdAt'] = test.createdAt;
    return data;
  }

  @override
  String toString() {
    return 'Test{testName: $testName, topics: $topics, createdAt: $createdAt}';
  }
}
