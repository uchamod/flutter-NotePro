import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sphere/routes/routenames.dart';
import 'package:note_sphere/util/textstyle.dart';
import 'package:note_sphere/widget/taskcard.dart';
import 'package:note_sphere/widget/workcard.dart';

import '../util/constants.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
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
        title: const Text("To-Do List",style: TextStyleClass.appHeadingStyle,),
      ),
      body: const Padding(padding: EdgeInsets.symmetric(
            horizontal: ConstantClass.kcDefultpadH,
            vertical: ConstantClass.kcDefultpadV),
            child: Column(
              children: [
               WorkCard(title: "Go to School", dateTime: "21,May 2024 10am",)
              ],
            ),),
    );
  }
}
