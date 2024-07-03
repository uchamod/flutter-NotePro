import 'package:flutter/material.dart';
import 'package:note_sphere/models/todomodel.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/textstyle.dart';

class ToDoCard extends StatefulWidget {
  final ToDoModel todo;
  final bool isDone;
  final Function() changeState;
  const ToDoCard({super.key, required this.changeState, required this.todo, required this.isDone});

  @override
  State<ToDoCard> createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
          color: AppColors.kcCardBlackColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              widget.todo.title,
              style: TextStyleClass.appCardTitleStyle,
            ),
          ),
          //checkbox
          trailing: Checkbox(
            value: widget.isDone,
            activeColor: AppColors.kcTextWhiteColor,
            //bind the function
            onChanged: (bool? value) => widget.changeState(),
          ),
          subtitle: Text(
            widget.todo.date.toString(),
            style: TextStyleClass.appDiscriptionSmallStyle,
          ),
        ),
      ),
    );
  }
}
