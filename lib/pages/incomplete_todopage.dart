import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sphere/models/todomodel.dart';
import 'package:note_sphere/routes/routenames.dart';
import 'package:note_sphere/services/todoservice.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';
import 'package:note_sphere/widget/todocard.dart';

class IncompleteToDo extends StatefulWidget {
  final List<ToDoModel> inCompletedToDos;
  const IncompleteToDo({super.key, required this.inCompletedToDos});

  @override
  State<IncompleteToDo> createState() => _IncompleteToDoState();
}

class _IncompleteToDoState extends State<IncompleteToDo> {
  //instant for todo service
  final TodoService _todoService = TodoService();

  @override
  void initState() {
    super.initState();
  }

  void _updateToDo(ToDoModel todo) async {
    ToDoModel Updatedtodo = ToDoModel(
        id: todo.id,
        time: todo.time,
        title: todo.title,
        date: todo.date,
        markAsDone: true);
    await _todoService.changeMarkState(Updatedtodo, context);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: AppColors.kcCardBlackColor,
          duration: Duration(seconds: 1),
          content: Text(
            "Mark as Done",
            style: TextStyleClass.appSubTittleStyle,
          )));
    }
    setState(() {
      widget.inCompletedToDos.remove(todo);
    });
     if (context.mounted) {
      GoRouter.of(context).go("/todopage");
    }
  }

  @override
  Widget build(BuildContext context) {
    //sort according to time
    setState(() {
      widget.inCompletedToDos.sort((a, b) => a.time.compareTo(b.time));
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: ConstantClass.kcDefultContainerPadV),
          child: Column(
            children: [
              //show to  do list
              widget.inCompletedToDos.isEmpty
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
                          color:
                              AppColors.kcTextWhiteColorShadow.withOpacity(0.2),
                        )
                      ],
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.inCompletedToDos.length,
                      itemBuilder: (context, index) {
                        ToDoModel todo = widget.inCompletedToDos[index];
                        //todo card

                        return Dismissible(
                          key: ValueKey(todo),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) async {
                            setState(() {
                              widget.inCompletedToDos.removeAt(index);
                              _todoService.deleteTodo(todo, context);
                            });
                          },
                          child: ToDoCard(
                            changeState: () => _updateToDo(todo),
                            isDone: false,
                            todo: todo,
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
