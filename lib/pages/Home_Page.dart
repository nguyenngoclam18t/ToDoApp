import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/data/ToDoDB.dart';
import 'package:to_do_app/util/ToDotile.dart';
import 'package:to_do_app/util/dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Tododb tododb = Tododb();
  final _controller = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await tododb.loadData();
    if (tododb.toDoList.isEmpty) {
      await tododb.createInitData();
    }
    setState(() {});
  }

  void checkboxChanged(bool? value, int index) {
    setState(() {
      tododb.toDoList[index][1] = !tododb.toDoList[index][1]!;
      tododb.saveData();
    });
  }

  void CreateNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onCancel: () => Navigator.of(context).pop(),
            onSave: SaveNewTask,
          );
        });
  }

  void SaveNewTask() {
    setState(() {
      tododb.toDoList.add([_controller.text, false]);
      _controller.clear();
      tododb.saveData();
    });
    Navigator.of(context).pop();
  }

  void deleteTask(int index) {
    setState(() {
      tododb.toDoList.removeAt(index);
      tododb.saveData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Center(child: Text("TO DO")),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: CreateNewTask,
        backgroundColor: Colors.yellow,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: tododb.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            TaskName: tododb.toDoList[index][0],
            TaskComplete: tododb.toDoList[index][1],
            onChanged: (value) => checkboxChanged(value, index),
            deleleFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
