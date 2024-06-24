import 'package:flutter/material.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';

class WorkCard extends StatefulWidget {
  final String title;
  final String dateTime;

  const WorkCard({super.key, required this.title, required this.dateTime});

  @override
  State<WorkCard> createState() => _WorkCardState();
}

class _WorkCardState extends State<WorkCard> {
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
      child: ListTile(
        
        title: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            widget.title,
            style: TextStyleClass.appCardTitleStyle,
          ),
        ),
        trailing: Checkbox(
          value: false,

          onChanged: (value) {},
        ),
        
        subtitle: Text(
          widget.dateTime,
          style: TextStyleClass.appDiscriptionSmallStyle,
        ),
      ),
    );
  }
}
