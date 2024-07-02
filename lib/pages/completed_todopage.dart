import 'package:flutter/material.dart';
import 'package:note_sphere/models/todomodel.dart';
import 'package:note_sphere/services/todoservice.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';
import 'package:note_sphere/widget/todocard.dart';

class CompletedToDo extends StatefulWidget {
  const CompletedToDo({super.key});

  @override
  State<CompletedToDo> createState() => _CompletedToDoState();
}

class _CompletedToDoState extends State<CompletedToDo> {
  //instant for todo service
  final TodoService _todoService = TodoService();

  List<ToDoModel> alltodos = [];
  List<ToDoModel> completedtodos = [];

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
      //completted todos
      completedtodos = alltodos.where((todo) => todo.markAsDone).toList();
    });
  }

  //update todo
  void _updateToDo(ToDoModel todo) async {
    await _todoService.changeMarkState(todo, context);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: AppColors.kcCardBlackColor,
          duration: Duration(seconds: 1),
          content: Text(
            "UnMarked",
            style: TextStyleClass.appSubTittleStyle,
          )));
    }
    setState(() {
      completedtodos.remove(todo);
    });
  }

  //delete the todo
  void _deletedTodo(ToDoModel todo) async {
    await _todoService.deleteTodo(todo, context);
    setState(() {
      completedtodos.remove(todo);
    });
  }

  @override
  Widget build(BuildContext context) {
    //sort according to time
    setState(() {
      completedtodos.sort((a, b) => a.time.compareTo(b.time));
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: ConstantClass.kcDefultContainerPadV),
          child: Column(
            children: [
              completedtodos.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 200,
                        ),
                        Center(
                          child: Text(
                            "No Completed Todos",
                            style: TextStyleClass.appHeadingStyle.copyWith(
                              color: AppColors.kcTextWhiteColorShadow,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.edit_note_outlined,
                          size: 150,
                          color:
                              AppColors.kcTextWhiteColorShadow.withOpacity(0.2),
                        )
                      ],
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: completedtodos.length,
                      itemBuilder: (context, index) {
                        ToDoModel todo = completedtodos[index];
                        //todo card

                        return Dismissible(
                          key: ValueKey(todo),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) async {
                            _deletedTodo(todo);
                          },
                          child: ToDoCard(
                            changeState: () async {
                              _updateToDo(todo);
                            },
                            isDone: todo.markAsDone,
                            title: todo.title,
                            dateTime:
                                "${todo.date.day}/${todo.date.month}/${todo.date.year} ${todo.time.hour}:${todo.time.minute}",
                          ),
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
