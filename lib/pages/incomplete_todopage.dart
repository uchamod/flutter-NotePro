import 'package:flutter/material.dart';
import 'package:note_sphere/models/todomodel.dart';
import 'package:note_sphere/providers/todo_provider.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';
import 'package:note_sphere/widget/todocard.dart';
import 'package:provider/provider.dart';

class IncompleteToDo extends StatefulWidget {
  const IncompleteToDo({super.key});

  @override
  State<IncompleteToDo> createState() => _IncompleteToDoState();
}

class _IncompleteToDoState extends State<IncompleteToDo> {
  //update the todo
  void _updateToDo(ToDoModel todo, TodoProvider provider) async {
    await provider.updateTodoState(todo, context);
    //alert massage
    if (!mounted) return;
    
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

  //delete the todo
  void _deletedTodo(ToDoModel todo, TodoProvider provider) async {
    await provider.deleteTodo(todo, context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, provider, child) {
        List<ToDoModel> incompletedtodos = provider.incompletedTodos;
        //sort according to time
        incompletedtodos.sort((a, b) => a.time.compareTo(b.time));

        return Scaffold(
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
                                    "${todo.date.day}/${todo.date.month}/${todo.date.year} ${todo.date.hour}:${todo.date.minute}",
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
