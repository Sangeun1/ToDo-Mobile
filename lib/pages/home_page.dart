// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/util/dialog.dart';
import '../util/todo_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();


  @override
  void initState() {
    // if this is the first time opening the app, create a default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }


    super.initState();
  }

  final _controller = TextEditingController();



  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBasse();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBasse();
  }


  void createNewTask() {
    showDialog(
      context: context, 
      builder: (context) {
      return DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: () => Navigator.of(context).pop(),
      );
    });
  }


  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBasse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],

      appBar: AppBar(
        title: Text("To Do"),          
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),

      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoItem(
            taskName: db.toDoList[index][0], 
            taskCompleted: db.toDoList[index][1], 
            onChanged: (value) => checkboxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),

      );
  }
}