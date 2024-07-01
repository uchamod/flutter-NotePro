import 'package:flutter/material.dart';
import 'package:note_sphere/models/todomodel.dart';
import 'package:note_sphere/services/todoservice.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/widget/todocard.dart';

class IncompleteToDo extends StatefulWidget {
  const IncompleteToDo({super.key});

  @override
  State<IncompleteToDo> createState() => _IncompleteToDoState();
}

class _IncompleteToDoState extends State<IncompleteToDo> {
  //instant for todo service
  final TodoService _todoService = TodoService();

  List<ToDoModel> alltodos = [];
  List<ToDoModel> incompletedtodos = [];

  @override
  void initState() {
    _isNewUser();
    _loadTodos();
    super.initState();
  }

  //check user is new and save the initial data in storage
  void _isNewUser() async {
    bool isUserNew = await _todoService.isNewUser();
    if (isUserNew) {
      await _todoService.saveInitialTodos();
    }
  }

  //load the current data
  Future<void> _loadTodos() async {
    List<ToDoModel> todos = await _todoService.loadTodos();
    setState(() {
      alltodos = todos;

      //incompleted todos
      incompletedtodos = alltodos.where((todo) => !todo.markAsDone).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: ConstantClass.kcDefultContainerPadV),
          child: Column(
            children: [
              //show to  do list
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: incompletedtodos.length,
                itemBuilder: (context, index) {
                  ToDoModel todo = incompletedtodos[index];
                  //todo card

                  return ToDoCard(
                    isDone: todo.markAsDone,
                    title: todo.title,
                    dateTime:
                        "${todo.date.day}/${todo.date.month}/${todo.date.year} ${todo.date.hour}:${todo.date.minute}",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
