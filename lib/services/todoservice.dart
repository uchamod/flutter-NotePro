import 'package:hive/hive.dart';
import 'package:note_sphere/models/todomodel.dart';
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
}
