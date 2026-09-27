import 'package:flutter/material.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/textstyle.dart';

class ToDoCard extends StatefulWidget {
  final String title;
  final String dateTime;
  final bool isDone;
  final Function() changeState;
  final Function() onDelete;
  const ToDoCard(
      {super.key,
      required this.title,
      required this.dateTime,
      required this.isDone,
      required this.changeState,
      required this.onDelete});

  @override
  State<ToDoCard> createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        width: MediaQuery.of(context).size.width * 1,
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.1,
        ),
        decoration: BoxDecoration(
          color: AppColors.kcCardBlackColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(
            widget.title,
            style: TextStyleClass.appCardTitleStyle,
          ),
          subtitle: Text(
            widget.dateTime,
            style: TextStyleClass.appDiscriptionSmallStyle,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                width: 12,
              ),
              Checkbox(
                value: widget.isDone,
                activeColor: AppColors.kcTextWhiteColor,
                onChanged: (value) => widget.changeState(),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                onPressed: widget.onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
