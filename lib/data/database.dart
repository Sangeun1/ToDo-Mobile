import 'package:hive/hive.dart';

class ToDoDataBase {

  List toDoList = [];

  //  reference the hive box

  final _myBox = Hive.box('mybox');


  void createInitialData() {
    toDoList = [
      ["Read tutorial", false],
      ["Enjoy it", false]
    ];
  }

  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }


  void updateDataBasse() {
    _myBox.put("TODOLIST", toDoList);
  }


}