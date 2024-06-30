import 'package:flutter/material.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';

class SingleNoteCard extends StatefulWidget {
  final String title;
  final String discription;
  final Future Function() editNote;
  final Future Function() deleteNote;

  const SingleNoteCard(
      {super.key,
      required this.title,
      required this.discription,
      required this.editNote,
      required this.deleteNote});

  @override
  State<SingleNoteCard> createState() => _SingleNoteCardState();
}

class _SingleNoteCardState extends State<SingleNoteCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //note edit button
              GestureDetector(
                onTap: widget.editNote,
                child: Icon(
                  Icons.edit_outlined,
                  color: AppColors.kcTextWhiteColorShadow,
                  size: 28,
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              //delete note button
              GestureDetector(
                onTap: widget.deleteNote,
                child: Icon(
                  Icons.delete_outline,
                  color: AppColors.kcTextWhiteColorShadow,
                  size: 28,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          //note title
          Text(
            widget.title,
            style: TextStyleClass.appCardTitleStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 15,
          ),
          //note discription
          Text(
            widget.discription,
            style: TextStyleClass.appDiscriptionLargeStyle,
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
