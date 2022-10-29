import 'dart:convert';

import 'package:flutter_assignment/model/test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageUseCase<T> {
  Future<bool> updateTestList(String key, List<Test> value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(key, encodeTest(value));
  }

  Future<List<Test>> getTestList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    List<Test> list = decode(prefs.getStringList(key) ?? []);
    return list;
  }

  Future delete(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  Future removeAllData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  List<Test> decode(List<String> tests) {
    List<Test> list = [];
    for (String s in tests) {
      list.add(Test.fromJson(jsonDecode(s)));
    }
    return list;
  }

  List<String> encodeTest(List<Test> tests) =>
      tests.map((test) => jsonEncode(test)).toList();
}
