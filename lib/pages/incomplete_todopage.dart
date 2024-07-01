import 'package:flutter/material.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/widget/todocard.dart';

class IncompleteToDo extends StatefulWidget {
  const IncompleteToDo({super.key});

  @override
  State<IncompleteToDo> createState() => _IncompleteToDoState();
}

class _IncompleteToDoState extends State<IncompleteToDo> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal:10,
            vertical: ConstantClass.kcDefultContainerPadV),
        child: Column(
          children: [
            ToDoCard(title: "todo", dateTime: ""),
          ],
        ),
      ),
    );
  }
}
