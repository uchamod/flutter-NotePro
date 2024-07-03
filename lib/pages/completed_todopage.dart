import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sphere/models/todomodel.dart';
import 'package:note_sphere/services/todoservice.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';
import 'package:note_sphere/widget/todocard.dart';

class CompletedToDo extends StatefulWidget {
  final List<ToDoModel> completedToDos;
  const CompletedToDo({super.key, required this.completedToDos});

  @override
  State<CompletedToDo> createState() => _CompletedToDoState();
}

class _CompletedToDoState extends State<CompletedToDo> {
  //instant for todo service
  final TodoService _todoService = TodoService();

  @override
  void initState() {
    super.initState();
  }

  //update todo
  void _updateToDo(ToDoModel todo) async {
    ToDoModel updatedToDo = ToDoModel(
        id: todo.id,
        time: todo.time,
        title: todo.title,
        date: todo.date,
        markAsDone: false);
    await _todoService.changeMarkState(updatedToDo, context);
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
      widget.completedToDos.remove(todo);
    });
    if (context.mounted) {
      GoRouter.of(context).go("/todopage");
    }
  }

  @override
  Widget build(BuildContext context) {
    //sort according to time
    setState(() {
      widget.completedToDos.sort((a, b) => a.time.compareTo(b.time));
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: ConstantClass.kcDefultContainerPadV),
          child: Column(
            children: [
              widget.completedToDos.isEmpty
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
                      itemCount: widget.completedToDos.length,
                      itemBuilder: (context, index) {
                        ToDoModel todo = widget.completedToDos[index];
                        //todo card

                        return Dismissible(
                          key: ValueKey(todo),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) async {
                            setState(() {
                              widget.completedToDos.removeAt(index);
                              _todoService.deleteTodo(todo, context);
                            });
                          },
                          child: ToDoCard(
                            changeState: () => _updateToDo(todo),
                            isDone: true,
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
