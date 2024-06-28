import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sphere/models/notemodel.dart';
import 'package:note_sphere/routes/routenames.dart';
import 'package:note_sphere/services/noteservices.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';
import 'package:note_sphere/widget/noteadding_bottomsheet.dart';
import 'package:note_sphere/widget/notecard.dart';

//show allNote class
class MainNotePage extends StatefulWidget {
  const MainNotePage({super.key});

  @override
  State<MainNotePage> createState() => _MainNotePageState();
}

class _MainNotePageState extends State<MainNotePage> {
  //instance for noteservices
  NoteServices noteServices = NoteServices();
  //allnotes in storage
  List<NoteModel> allnotes = [];
  //notes by category
  Map<String, List<NoteModel>> notesByCategory = {};

  @override
  void initState() {
    // TODO: implement initState
    _checkIsUserNew();
    _loadnotes();
    super.initState();
  }

  //check is user new
  void _checkIsUserNew() async {
    final bool isNewUser = await noteServices.isNewUser();

    if (isNewUser) {
      await noteServices.saveInitialNotes();
    }
  }

  //loaded notes from storage and assign to list and map by category
  Future<void> _loadnotes() async {
    final List<NoteModel> notes = await noteServices.loadNotes();
    Map<String, List<NoteModel>> noteMap =
        noteServices.getNoteByCategory(notes);
    setState(() {
      allnotes = notes;
      notesByCategory = noteMap;
    });
  }

//method for show the bottom sheet
  void openModelBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheetByCategory(
          //route to add new note page
          addNewNote: () {
            Navigator.pop(context);
            GoRouter.of(context)
                .goNamed(RouteNames.addnewnotepage, extra: true);
          },
          //route to add new note by category page
          addNewNoteForNewCategory: () {
            Navigator.pop(context);
            GoRouter.of(context)
                .goNamed(RouteNames.addnewnotepage, extra: false);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          //route to homepage
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
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: ConstantClass.kcDefultpadH,
              vertical: ConstantClass.kcDefultpadV),
          child: Column(
            children: [
              //show all the notes acording to category
              allnotes.isEmpty
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
                              childAspectRatio: 16 / 11),
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: notesByCategory.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        //route to singlenotepage
                        return GestureDetector(
                          onTap: () {
                            GoRouter.of(context).goNamed(
                                RouteNames.singlenotepage,
                                extra: notesByCategory.keys.elementAt(index));
                          },
                          child: NoteCard(
                              category: notesByCategory.keys.elementAt(index),
                              numOfNotes: notesByCategory.values
                                  .elementAt(index)
                                  .length),
                        );
                      },
                    )
            ],
          ),
        ),
        //add new note
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          //show bottom sheet
          onPressed: openModelBottomSheet,
          child: const Center(
            child: Icon(
              Icons.add,
              size: 35,
              color: AppColors.kcTextWhiteColor,
            ),
          ),
        ));
  }
}
