import 'package:flutter/material.dart';
import 'package:note_sphere/ingerited/todo_inherited_widget.dart';
import 'package:note_sphere/models/todomodel.dart';
import 'package:note_sphere/pages/homepage.dart';
import 'package:note_sphere/services/todoservice.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';
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
  //update the todo

  void _updateToDo(ToDoModel todo) async {
    await _todoService.changeMarkState(todo, context);
    //alert massage
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: AppColors.kcCardBlackColor,
          duration: Duration(seconds: 1),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.check,
                color: AppColors.kcTextWhiteColor,
                size: 20,
                weight: 20,
                opticalSize: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Done",
                style: TextStyleClass.appSubTittleStyle,
              ),
            ],
          )));
    }

    //update the state
    setState(() {
      incompletedtodos.remove(todo);
    });
    if (ToDoData.of(context) != null) {
      ToDoData.of(context)!.onToDoChanged;
    }
  }

  //delete the todo
  void _deletedTodo(ToDoModel todo) async {
    await _todoService.deleteTodo(todo, context);
    setState(() {
      incompletedtodos.remove(todo);
    });
    if (ToDoData.of(context) != null) {
      ToDoData.of(context)!.onToDoChanged;
    }
  }

  @override
  Widget build(BuildContext context) {
    //sort according to time
    setState(() {
      incompletedtodos.sort((a, b) => a.time.compareTo(b.time));
    });
    //wrap with inherit widget
    return ToDoData(
      todos: alltodos,
      onToDoChanged: _loadTodos,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: ConstantClass.kcDefultContainerPadV),
            child: Column(
              children: [
                //show to  do list
                incompletedtodos.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 200,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Add Your ",
                                style: TextStyleClass.appHeadingStyle.copyWith(
                                  color: AppColors.kcTextWhiteColorShadow,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "ToDos ",
                                style: TextStyleClass.appTittleStyle.copyWith(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "Here",
                                style: TextStyleClass.appHeadingStyle.copyWith(
                                  color: AppColors.kcTextWhiteColorShadow,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Icon(
                            Icons.today_outlined,
                            size: 150,
                            color: AppColors.kcTextWhiteColorShadow
                                .withOpacity(0.2),
                          )
                        ],
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: incompletedtodos.length,
                        itemBuilder: (context, index) {
                          ToDoModel todo = incompletedtodos[index];
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
                                setState(() {
                                  HomePage();
                                });
                              },
                              isDone: todo.markAsDone,
                              title: todo.title,
                              dateTime:
                                  "${todo.date.day}/${todo.date.month}/${todo.date.year} ${todo.date.hour}:${todo.date.minute}",
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
