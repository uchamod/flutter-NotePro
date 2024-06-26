import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sphere/routes/routenames.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';

class AddNewNote extends StatefulWidget {
  final bool isNormal;
  const AddNewNote({super.key, required this.isNormal});

  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          //route to homepage
          leading: GestureDetector(
            onTap: () {
              GoRouter.of(context).goNamed(RouteNames.notepage);
            },
            child: const Icon(
              Icons.arrow_back_rounded,
              size: 30,
            ),
          ),
          title: const Text(
           "Create note",
            style: TextStyleClass.appTittleStyle,
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ConstantClass.kcDefultpadH,
              vertical: ConstantClass.kcDefultpadV),
          child: Column(
            children: [],
          ),
        ));
  }
}
