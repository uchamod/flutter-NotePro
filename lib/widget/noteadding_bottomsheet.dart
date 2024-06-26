import 'package:flutter/material.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';

class BottomSheetByCategory extends StatefulWidget {
  final Function() addNewNote;
  final Function() addNewNoteForNewCategory;

  const BottomSheetByCategory(
      {super.key,
      required this.addNewNote,
      required this.addNewNoteForNewCategory});

  @override
  State<BottomSheetByCategory> createState() => _BottomSheetByCategoryState();
}

class _BottomSheetByCategoryState extends State<BottomSheetByCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: AppColors.kcCardBlackColor.withOpacity(1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child:  Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: ConstantClass.kcDefultcontainerPadH,
            vertical: ConstantClass.kcDefultContainerPadV * 2),
        child: Column(
          children: [
            //add new note
            GestureDetector(
              onTap: widget.addNewNote,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Create a New Note",
                    style: TextStyleClass.appCardTitleStyle,
                  ),
                  Icon(
                    Icons.arrow_right,
                    size: 30,
                    color: AppColors.kcTextWhiteColor,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Divider(
              color: AppColors.kcTextWhiteColor,
              thickness: 1,
            ),
            const SizedBox(
              height: 25,
            ),
            //add new  note by category
            GestureDetector(
              onTap: widget.addNewNoteForNewCategory,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Create a New Category",
                    style: TextStyleClass.appCardTitleStyle,
                  ),
                  Icon(
                    Icons.arrow_right,
                    size: 30,
                    color: AppColors.kcTextWhiteColor,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
