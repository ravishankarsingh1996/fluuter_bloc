import 'dart:convert';

import 'package:flutter_assignment/model/topic.dart';
import 'package:flutter_assignment/model/topics_list.dart';
import 'package:http/http.dart' as http;

class TopicRepository {
  Future<List<Topic>> getTopicsList() async {
    try {
      var response = await http.get(
          Uri.parse(
            'https://utkwwq6r95.execute-api.us-east-1.amazonaws.com/assignment/topics',
          ),
          headers: {
            "userid": "25794905-2dd4-40bd-97b9-9d5d69294b86",
            "token": "d61036c6-5ffd-4964-b7ff-8d5ba8ca0262"
          });

      var topics = TopicsList.fromJson(jsonDecode(response.body));
      return topics.data ?? [];
    } catch (e) {
      rethrow;
    }
  }
}
