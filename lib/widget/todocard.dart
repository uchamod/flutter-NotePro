import 'package:flutter/material.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/textstyle.dart';

class ToDoCard extends StatefulWidget {
  final String title;
  final String dateTime;
  final bool isDone;
  final Function() changeState;
  const ToDoCard(
      {super.key,
      required this.title,
      required this.dateTime,
      required this.isDone,
      required this.changeState});

  @override
  State<ToDoCard> createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
  bool done = false;
  @override
  void initState() {
    isMark();
    super.initState();
  }

  void isMark() {
    done = widget.isDone;
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
              widget.title,
              style: TextStyleClass.appCardTitleStyle,
            ),
          ),
          //checkbox
          trailing: Checkbox(
            value: done,
            activeColor: AppColors.kcTextWhiteColor,
            //bind the function
            onChanged: (value) => widget.changeState(),
          ),
          subtitle: Text(
            widget.dateTime,
            style: TextStyleClass.appDiscriptionSmallStyle,
          ),
        ),
      ),
    );
  }
}
