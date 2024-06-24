import 'package:flutter/material.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';

class TaskCard extends StatefulWidget {
  final String title;
  final String dateTime;
  final Color iconColor;
  const TaskCard(
      {super.key,
      required this.title,
      required this.dateTime,
      required this.iconColor});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.1,
      padding: const EdgeInsets.symmetric(
          horizontal: ConstantClass.kcDefultpadH,
          vertical: ConstantClass.kcDefultpadV),
      decoration: BoxDecoration(
        color: AppColors.kcCardBlackColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
             children: [
            Text(
              widget.title,
              style: TextStyleClass.appCardTitleStyle,
            ),
            Text(
              widget.dateTime,
              style: TextStyleClass.appDiscriptionSmallStyle,
            )
          ]),
          Icon(
            Icons.check,
            color: widget.iconColor,
            size: 24,
            weight: 20,
          ),
        ],
      ),
    );
  }
}
