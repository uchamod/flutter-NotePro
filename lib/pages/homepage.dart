import 'package:flutter/material.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';
import 'package:note_sphere/widget/categorycard.dart';
import 'package:note_sphere/widget/progresscard.dart';
import 'package:note_sphere/widget/taskcard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "NotePro",
          style: TextStyleClass.appHeadingStyle,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ConstantClass.kcDefultpadH,
            vertical: ConstantClass.kcDefultpadV),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //progress card
            ProgressCard(allTask: 3,completeTask: 1,),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryCard(
                  icon: Icons.bookmark_add_outlined,
                  title: "Notes",
                  numOfTasks: 3,
                  subText: "notes",
                ),
                CategoryCard(
                  icon: Icons.today_outlined,
                  title: "To-Do Lists",
                  numOfTasks: 2,
                  subText: "works",
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's Progress",
                  style: TextStyleClass.appTittleStyle,
                ),
                Text(
                  "See All",
                  style: TextStyleClass.appSubTittleStyle,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TaskCard(
                title: "Read a book",
                dateTime: "May 10,2024 10am",
                iconColor: AppColors.kcTickGreenColor),
          ],
        ),
      ),
    );
  }
}
