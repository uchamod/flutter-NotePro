import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sphere/models/notemodel.dart';
import 'package:note_sphere/routes/routenames.dart';
import 'package:note_sphere/services/noteservices.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';

//edit note page
class UpdatenotePage extends StatefulWidget {
  final NoteModel note;
  const UpdatenotePage({
    super.key,
    required this.note,
  });

  @override
  State<UpdatenotePage> createState() => _UpdatenotePageState();
}

class _UpdatenotePageState extends State<UpdatenotePage> {
  List<String> allCategories = [];
  NoteServices noteServices = NoteServices();

  //form key
  final _formKey = GlobalKey<FormState>();
  //field controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _discriptionController = TextEditingController();

  String _selectedCategory = "";
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _loadCategories();
      _selectedCategory = widget.note.category;
      _titleController.text = widget.note.title;
      _discriptionController.text = widget.note.description;
    });
    super.initState();
  }

  void _loadCategories() async {
    allCategories = await noteServices.getAllCategories();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _discriptionController.dispose();
    _titleController.dispose();
    super.dispose();
  }

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
          "Edit note",
          style: TextStyleClass.appTittleStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: ConstantClass.kcDefultpadH,
            vertical: ConstantClass.kcDefultpadV),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //drop down menu
                    Container(
                      child: DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please select a category";
                          } else {
                            return null;
                          }
                        },
                        alignment: Alignment.centerLeft,

                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: AppColors.kcTextWhiteColorShadow,
                                width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: AppColors.kcTextWhiteColorShadow,
                                width: 1),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: AppColors.kcTextWhiteColorShadow,
                                width: 1),
                          ),
                        ),
                        hint: Text(
                          "Category",
                          style: TextStyleClass.appDiscriptionSmallStyle
                              .copyWith(fontSize: 16),
                        ),
                        style: TextStyleClass.appDiscriptionSmallStyle,
                        menuMaxHeight: double.infinity,

                        isExpanded: true,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.kcTextWhiteColor,
                          size: 28,
                        ),
                        //add menu items
                        items: allCategories
                            .map((ele) => DropdownMenuItem(
                                  value: ele,
                                  child: Text(
                                    ele,
                                    style: TextStyleClass.appSubTittleStyle,
                                  ),
                                ))
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        },
                        //or create new category
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    //title text feild
                    TextFormField(
                      style: TextStyleClass.appTittleStyle,
                      cursorColor: AppColors.kcTextWhiteColor,
                      controller: _titleController,
                      textInputAction: TextInputAction.next,
                      maxLines: 2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter your title";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    //discription
                    TextFormField(
                      controller: _discriptionController,
                      maxLines: 15,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter your context";
                        } else {
                          return null;
                        }
                      },
                      cursorColor: AppColors.kcTextWhiteColor,
                      style: TextStyleClass.appSubTittleStyle,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                    Divider(
                      color: AppColors.kcTextWhiteColorShadow,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //note save button and clear form button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            //update the selected note
                            if (_formKey.currentState!.validate()) {
                              try {
                                NoteModel note = NoteModel(
                                  category: _selectedCategory,
                                  title: _titleController.text,
                                  description: _discriptionController.text,
                                  dateTime: DateTime.now(),
                                  id: widget.note.id,  //track the id of current note
                                );

                                await noteServices.updateNote(note, context);
                              } catch (err) {
                                print(err.toString());
                              }
                            } else {
                              const CircularProgressIndicator();
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.06,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: AppColors.kcCardBlackColor),
                            child: const Center(
                              child: Text(
                                "Update Note",
                                style: TextStyleClass.appSubTittleStyle,
                              ),
                            ),
                          ),
                        ),
                        //clear the form
                        GestureDetector(
                          onTap: () {
                            _discriptionController.clear();
                            _titleController.clear();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.06,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: AppColors.kcCardBlackColor),
                            child: const Center(
                              child: Text(
                                "Clear",
                                style: TextStyleClass.appSubTittleStyle,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
