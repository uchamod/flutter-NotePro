import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_sphere/models/todomodel.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/textstyle.dart';
import 'package:uuid/uuid.dart';

class TodoService {
  //initial todos
  List<ToDoModel> allTodos = [
    ToDoModel(
      id: const Uuid().v4(),
      time: DateTime.now(),
      title: "Walk",
      date: DateTime.now(),
      markAsDone: false,
    ),
    ToDoModel(
      id: const Uuid().v4(),
      time: DateTime.now(),
      title: "Read book",
      date: DateTime.now(),
      markAsDone: false,
    ),
    ToDoModel(
      id: const Uuid().v4(),
      time: DateTime.now(),
      title: "Cook",
      date: DateTime.now(),
      markAsDone: true,
    ),
  ];

  final _todoBox = Hive.box("todobox");

//check current todos are empty
  Future<bool> isNewUser() async {
    return _todoBox.isEmpty;
  }

  //method to save initial data in local database if user is new
  Future<void> saveInitialTodos() async {
    await _todoBox.put("todos", allTodos);
  }

  //method to load data from local database
  Future<List<ToDoModel>> loadTodos() async {
    //get the values
    final dynamic notes = await _todoBox.get("todos");
    if (notes != null && notes is List<dynamic>) {
      return notes.cast<ToDoModel>().toList();
    }
    return [];
  }

  //change the state of todos
  Future<void> changeMarkState(
      ToDoModel checkedTodo, BuildContext context) async {
    try {
      dynamic todos = await _todoBox.get("todos");
      List<ToDoModel> allTodos = [];
      for (final todo in todos) {
        if (todo.id == checkedTodo.id) {
          todo.markAsDone = !todo.markAsDone;
          allTodos.add(todo);
        } else {
          allTodos.add(todo);
        }
      }
      await _todoBox.put("todos", allTodos);
    } catch (err) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: AppColors.kcCardBlackColor,
            duration: Duration(seconds: 1),
            content: Text(
              "something went wrong",
              style: TextStyleClass.appSubTittleStyle,
            )));
      }
    }
  }

  //delete a todo
  Future<void> deleteTodo(ToDoModel todo, BuildContext context) async {
    try {
      dynamic alltodos = await _todoBox.get("todos");
      int index = alltodos.indexWhere((ele) => ele.id == todo.id);
      alltodos.removeAt(index);
      await _todoBox.put("todos", alltodos);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.kcCardBlackColor,
            duration: Duration(seconds: 1),
            content: Text(
              "Todo is deleted",
              style: TextStyleClass.appSubTittleStyle,
            ),
          ),
        );
      }
    } catch (err) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.kcCardBlackColor,
            duration: Duration(seconds: 1),
            content: Text(
              "something went wrong",
              style: TextStyleClass.appSubTittleStyle,
            ),
          ),
        );
      }
    }
  }

  //add new todo
  Future<void> addNewTodo(ToDoModel todo, BuildContext context) async {
    try {
      dynamic alltodos = await _todoBox.get("todos");
      alltodos.add(todo);
      await _todoBox.put("todos", alltodos);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: AppColors.kcCardBlackColor,
            duration: Duration(seconds: 1),
            content: Text(
              "New ToDo is Added",
              style: TextStyleClass.appSubTittleStyle,
            )));
      }
    } catch (err) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: AppColors.kcCardBlackColor,
            duration: Duration(seconds: 1),
            content: Text(
              "something went wrong",
              style: TextStyleClass.appSubTittleStyle,
            )));
      }
    }
  }
}
