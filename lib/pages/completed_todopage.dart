import 'package:flutter/material.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/widget/todocard.dart';

class CompletedToDo extends StatefulWidget {
  const CompletedToDo({super.key});

  @override
  State<CompletedToDo> createState() => _CompletedToDoState();
}

class _CompletedToDoState extends State<CompletedToDo> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: ConstantClass.kcDefultContainerPadV),
        child: Column(
          children: [
            ToDoCard(title: "Completed", dateTime: ""),
          ],
        ),
      ),
    );
  }
}
