import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:note_sphere/models/notemodel.dart';
import 'package:note_sphere/routes/routenames.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';

class ShowFullNote extends StatefulWidget {
  final NoteModel note;
  const ShowFullNote({super.key, required this.note});

  @override
  State<ShowFullNote> createState() => _ShowFullNoteState();
}

class _ShowFullNoteState extends State<ShowFullNote> {
  @override
  Widget build(BuildContext context) {
    final formatedDate = DateFormat.yMMMd().format(widget.note.dateTime);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //route to homepage
        leading: GestureDetector(
          onTap: () {
            GoRouter.of(context).goNamed(RouteNames.singlenotepage,
                extra: widget.note.category);
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            size: 30,
          ),
        ),
       
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: ConstantClass.kcDefultpadH,
            vertical: ConstantClass.kcDefultpadV),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Text(
                  widget.note.title.toUpperCase()
                  ,
                  style: TextStyleClass.appHeadingStyle
                      .copyWith(
                       decoration: TextDecoration.underline,
                       decorationColor: AppColors.kcTextWhiteColor
                       
                        ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Date : $formatedDate",
              style: TextStyleClass.appSubTittleStyle
                  .copyWith(color: AppColors.kcTextWhiteColorShadow),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Category : ${widget.note.category}",
              style: TextStyleClass.appSubTittleStyle
                  .copyWith(color: AppColors.kcTextWhiteColorShadow),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.note.description,
              style: TextStyleClass.appSubTittleStyle,
            ),
          ],
        ),
      ),
    );
  }
}
