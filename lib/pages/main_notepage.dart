import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sphere/routes/routenames.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';
import 'package:note_sphere/widget/notecard.dart';

class MainNotePage extends StatefulWidget {
  const MainNotePage({super.key});

  @override
  State<MainNotePage> createState() => _MainNotePageState();
}

class _MainNotePageState extends State<MainNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            GoRouter.of(context).goNamed(RouteNames.homepage);
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            size: 30,
          ),
        ),
        title: const Text(
          "Notes",
          style: TextStyleClass.appHeadingStyle,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ConstantClass.kcDefultpadH,
            vertical: ConstantClass.kcDefultpadV),
        child: Column(
          children: [
            NoteCard(category: "School", numOfNotes: 5),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.kcBackgroundBlackColor,
       
            onPressed: () {},
        child: Container(
          width: MediaQuery.of(context).size.width*0.2,
          height: MediaQuery.of(context).size.width*0.2,
          decoration: BoxDecoration(
            color: AppColors.kcButtonPurpleColor,
            borderRadius: BorderRadius.circular(150),
            //border: Border.all(color: AppColors.kcTextWhiteColor,width: 2)
          ),
          child: const Center(
            child: Icon(
              Icons.add,
              size: 35,
              color: AppColors.kcTextWhiteColor,
            ),
          ),
        ),
    
      ),
    );
  }
}
