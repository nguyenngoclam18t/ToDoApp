import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tododb {
  List toDoList = [];

  Future<void> createInitData() async {
    toDoList = [
      ["Make tutorial", false],
      ["Do exercice", true],
      ["sleep", false],
      ["eat", false]
    ];
    await saveData();
  }

  Future<void> loadData() async {
    //123
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('toDoList');
    if (jsonString != null) {
      toDoList = jsonDecode(jsonString);
    }
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(toDoList);
    await prefs.setString('toDoList', jsonString);
  }
}
