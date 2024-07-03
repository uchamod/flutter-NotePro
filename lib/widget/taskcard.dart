import 'package:flutter/material.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';

class TaskCard extends StatefulWidget {
  final String title;
  final DateTime dateTime;
  final DateTime time;
  final Color iconColor;
  final bool isCompleted;
  const TaskCard(
      {super.key,
      required this.title,
      required this.dateTime,
      required this.iconColor,
      required this.time,
      required this.isCompleted});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.1,
      margin: const EdgeInsets.only(bottom: 10),
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
                Row(
                  children: [
                    Text(
                      '${widget.dateTime.day}/${widget.dateTime.month}/${widget.dateTime.year}',
                      style: TextStyleClass.appDiscriptionSmallStyle,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${widget.time.hour}:${widget.time.minute}',
                      style: TextStyleClass.appDiscriptionSmallStyle,
                    ),
                  ],
                )
              ]),
          Icon(
            widget.isCompleted ? Icons.done_all_rounded : Icons.done,
            color: widget.iconColor,
            size: 24,
            weight: 20,
          ),
        ],
      ),
    );
  }
}
