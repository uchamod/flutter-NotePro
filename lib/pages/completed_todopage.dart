import 'package:flutter/material.dart';
import 'package:note_sphere/models/todomodel.dart';
import 'package:note_sphere/providers/todo_provider.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';
import 'package:note_sphere/widget/todocard.dart';
import 'package:provider/provider.dart';

class CompletedToDo extends StatefulWidget {
  const CompletedToDo({super.key});

  @override
  State<CompletedToDo> createState() => _CompletedToDoState();
}

class _CompletedToDoState extends State<CompletedToDo> {
  //update todo
  void _updateToDo(ToDoModel todo, TodoProvider provider) async {
    await provider.updateTodoState(todo, context);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: AppColors.kcCardBlackColor,
        duration: Duration(seconds: 1),
        content: Text(
          "UnMarked",
          style: TextStyleClass.appSubTittleStyle,
        )));
  }

  //delete the todo
  void _deletedTodo(ToDoModel todo, TodoProvider provider) async {
    await provider.deleteTodo(todo, context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, provider, child) {
        List<ToDoModel> completedtodos = provider.completedTodos;
        //sort according to time
        completedtodos.sort((a, b) => a.time.compareTo(b.time));
        
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
                                _deletedTodo(todo, provider);
                              },
                              child: ToDoCard(
                                changeState: () async {
                                  _updateToDo(todo, provider);
                                },
                                onDelete: () async {
                                  _deletedTodo(todo, provider);
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
      },
    );
  }
}
