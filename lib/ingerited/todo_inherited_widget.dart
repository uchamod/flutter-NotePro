import 'package:flutter/material.dart';
import 'package:note_sphere/models/todomodel.dart';

class ToDoData extends InheritedWidget {
  //when change the todo list call the  function
  final List<ToDoModel> todos;
  final Function() onToDoChanged;
  ToDoData({
    required this.todos,
    required this.onToDoChanged,
    required super.child,
  });

  //get the latest todo data
  static ToDoData? of(BuildContext context) {
    //provide the latest tododata
    return context.dependOnInheritedWidgetOfExactType<ToDoData>();
  }

  //notify when update the current tododata
  @override
  bool updateShouldNotify(covariant ToDoData oldWidget) {
    // TODO: implement updateShouldNotify
    //notify when old todos ant diff from current todos
    return todos != oldWidget.todos;
  }
}
