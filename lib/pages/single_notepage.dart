import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sphere/providers/note_provider.dart';
import 'package:note_sphere/routes/routenames.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';
import 'package:note_sphere/widget/singlenotecard.dart';
import 'package:provider/provider.dart';

class SingleNotePage extends StatefulWidget {
  final String category;
  const SingleNotePage({super.key, required this.category});

  @override
  State<SingleNotePage> createState() => _SingleNotePageState();
}

class _SingleNotePageState extends State<SingleNotePage> {
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
        title: Text(
          widget.category,
          style: TextStyleClass.appHeadingStyle,
        ),
      ),
      body: Consumer<NoteProvider>(
        builder: (context, noteProvider, child) {
          final notesByCategory = noteProvider.notesByCategory[widget.category] ?? [];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: ConstantClass.kcDefultpadH,
                  vertical: ConstantClass.kcDefultpadV),
              child: Column(
                children: [
                  //show all the notes acording to category
                  notesByCategory.isEmpty
                      ? const Center(
                          child: Text(
                          "No notes avalible\nadd some notes here",
                          style: TextStyleClass.appCardTitleStyle,
                        ))
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            childAspectRatio: 7 / 10.43,
                          ),
                          scrollDirection: Axis.vertical,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: notesByCategory.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            //route to singlenotepage
                            return SingleNoteCard(
                              title: notesByCategory[index].title,
                              discription: notesByCategory[index].description,
                              editNote: () async {
                                GoRouter.of(context).goNamed(
                                    RouteNames.updatenotepage,
                                    extra: notesByCategory[index]);
                              },
                              deleteNote: () async {
                                await noteProvider.deleteNote(
                                    notesByCategory[index], context);
                              },
                              toFullNoteShowPage: () async {
                                GoRouter.of(context).goNamed(
                                    RouteNames.fullnotepage,
                                    extra: notesByCategory[index]);
                              },
                            );
                          },
                        )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
