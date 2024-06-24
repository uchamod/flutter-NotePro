import 'package:flutter/material.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';

class ProgressCard extends StatefulWidget {
  final int completeTask;
  final int allTask;

  const ProgressCard({
    super.key,
    required this.completeTask,
    required this.allTask,
  });

  @override
  State<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  //calculate the progress

  @override
  Widget build(BuildContext context) {
    double completetaskPercentage = widget.completeTask != 0
        ? (widget.completeTask / widget.allTask) * 100
        : 0;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kcCardBlackColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: ConstantClass.kcDefultcontainerPadH,
          vertical: ConstantClass.kcDefultContainerPadV),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Overall Progress",
                style: TextStyleClass.appTittleStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "You have completed ${widget.completeTask} out of ${widget.allTask} tasks\nkeep up your progress",
                style: TextStyleClass.appDiscriptionSmallStyle,
              ),
            ],
          ),
          Container(
            width: 85,
            height: 85,
            //  padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppColors.progressCircleGradient,
              borderRadius: BorderRadius.circular(200),
            ),
            child: Center(
              child: Text(
                "${completetaskPercentage.toStringAsFixed(0)}%",
                style: TextStyleClass.appHeadingStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
