import 'package:hive/hive.dart';
import 'package:note_sphere/models/todomodel.dart';
import 'package:uuid/uuid.dart';

class TodoService {
  //initial todos
  List<ToDoModel> initialTodoList = [
    ToDoModel(
      id:const Uuid().v4(),
      time: DateTime.now(),
      title: "Walk",
      date: DateTime.now(),
      markAsDone: false,
    ),
    ToDoModel(
      id:const Uuid().v4(),
      time: DateTime.now(),
      title: "Read book",
      date: DateTime.now(),
      markAsDone: false,
    ),
    ToDoModel(
      id:const Uuid().v4(),
      time: DateTime.now(),
      title: "Cook",
      date: DateTime.now(),
      markAsDone: true,
    ),
  ];

final _todoBox=Hive.box("");

}
