import 'package:flutter/material.dart';
import 'package:note_sphere/models/todomodel.dart';
import 'package:note_sphere/services/todoservice.dart';

class TodoProvider extends ChangeNotifier {
  final TodoService _todoService = TodoService();
  
  List<ToDoModel> _todos = [];
  List<ToDoModel> get todos => _todos;

  List<ToDoModel> get incompletedTodos => _todos.where((t) => !t.markAsDone).toList();
  List<ToDoModel> get completedTodos => _todos.where((t) => t.markAsDone).toList();

  Future<void> initData() async {
    bool isNew = await _todoService.isNewUser();
    if (isNew) {
      await _todoService.saveInitialTodos();
    }
    await loadTodos();
  }

  Future<void> loadTodos() async {
    _todos = await _todoService.loadTodos();
    notifyListeners();
  }

  Future<void> addNewTodo(ToDoModel todo, BuildContext context) async {
    await _todoService.addNewTodo(todo, context);
    await loadTodos();
  }

  Future<void> updateTodoState(ToDoModel todo, BuildContext context) async {
    await _todoService.changeMarkState(todo, context);
    await loadTodos();
  }

  Future<void> deleteTodo(ToDoModel todo, BuildContext context) async {
    await _todoService.deleteTodo(todo, context);
    await loadTodos();
  }
}
