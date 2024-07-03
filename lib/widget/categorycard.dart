import 'package:flutter/material.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';

class CategoryCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final int numOfTasks;
  final String subText;
  const CategoryCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.numOfTasks, required this.subText});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.height * 0.15,
      padding: const EdgeInsets.symmetric(
          horizontal: ConstantClass.kcDefultpadH,
          vertical: ConstantClass.kcDefultContainerPadV),
      decoration: BoxDecoration(
        color: AppColors.kcCardBlackColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            widget.icon,
            size: 35,
            color: AppColors.kcTextWhiteColor,
          ),
          Text(
            widget.title,
            style: TextStyleClass.appTittleStyle,
          ),
          Text(
            "${widget.numOfTasks.toStringAsFixed(0)} ${widget.subText}",
            style: TextStyleClass.appDiscriptionSmallStyle,
          ),
        ],
      ),
    );
  }
}
