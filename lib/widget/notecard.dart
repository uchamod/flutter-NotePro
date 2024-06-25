import 'package:flutter/material.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';

class NoteCard extends StatefulWidget {
  final String category;
  final int numOfNotes;
  const NoteCard({super.key, required this.category, required this.numOfNotes});

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            widget.category,
            style: TextStyleClass.appTittleStyle,
          ),
          Text(
            "${widget.numOfNotes.toString()} notes",
            style: TextStyleClass.appDiscriptionSmallStyle,
          )
        ],
      ),
    );
  }
}
