import 'package:flutter/material.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';

class SingleNoteCard extends StatefulWidget {
  final String title;
  final String discription;
  const SingleNoteCard(
      {super.key, required this.title, required this.discription});

  @override
  State<SingleNoteCard> createState() => _SingleNoteCardState();
}

class _SingleNoteCardState extends State<SingleNoteCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.44,
      height: MediaQuery.of(context).size.height * 0.14,
      padding: const EdgeInsets.symmetric(
          horizontal: ConstantClass.kcDefultpadH,
          vertical: ConstantClass.kcDefultContainerPadV),
      decoration: BoxDecoration(
        color: AppColors.kcCardBlackColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 5),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.edit_outlined,
                color: AppColors.kcTextWhiteColorShadow,
                size: 28,
              ),
              const SizedBox(width: 25,),
              Icon(
                Icons.delete_outline,
                color: AppColors.kcTextWhiteColorShadow,
                size: 28,
              )
            ],
          ),
          Text(
            widget.title,
            style: TextStyleClass.appCardTitleStyle,
          ),
          Text(
            widget.discription,
            style: TextStyleClass.appDiscriptionLargeStyle,
          )
        ],
      ),
    );
  }
}
