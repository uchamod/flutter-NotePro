import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sphere/providers/note_provider.dart';
import 'package:note_sphere/routes/routenames.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';
import 'package:note_sphere/widget/custom_fsb_location.dart';
import 'package:note_sphere/widget/noteadding_bottomsheet.dart';
import 'package:note_sphere/widget/notecard.dart';
import 'package:provider/provider.dart';

//show allNote class
class MainNotePage extends StatefulWidget {
  const MainNotePage({super.key});

  @override
  State<MainNotePage> createState() => _MainNotePageState();
}

class _MainNotePageState extends State<MainNotePage> {
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
    double scheight = MediaQuery.of(context).size.height * 0.25;
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
      body: Consumer<NoteProvider>(
        builder: (context, noteProvider, child) {
          final allnotes = noteProvider.notes;
          final notesByCategory = noteProvider.notesByCategory;

          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: ConstantClass.kcDefultpadH,
                vertical: ConstantClass.kcDefultpadV),
            child: Column(
              children: [
                //show all the notes acording to category
                allnotes.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: scheight,
                            ),
                            const Icon(
                              Icons.today_outlined,
                              size: 128,
                              color: AppColors.kcButtonPurpleColor,
                            ),
                            const Text(
                              "No Notes Avalible",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.kcButtonPurpleColor),
                            )
                          ],
                        ),
                      )
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
          );
        },
      ),
      //add new note
      floatingActionButtonLocation: const CustomFabLocation(bottom: 48),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(140),
        ),
        //show bottom sheet
        onPressed: openModelBottomSheet,
        child: const Center(
          child: Icon(
            Icons.add,
            size: 48,
            color: AppColors.kcTextWhiteColor,
          ),
        ),
      ),
    );
  }
}
