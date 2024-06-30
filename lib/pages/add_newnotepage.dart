import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sphere/models/notemodel.dart';
import 'package:note_sphere/routes/routenames.dart';
import 'package:note_sphere/services/noteservices.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';

class AddNewNote extends StatefulWidget {
  final bool isNormal;
  const AddNewNote({super.key, required this.isNormal});

  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  List<String> allCategories = [];
  NoteServices noteServices = NoteServices();

  //form key
  final _formKey = GlobalKey<FormState>();
  //field controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _discriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  String _selectedCategory = "";
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _loadCategories();
    });
    super.initState();
  }

  void _loadCategories() async {
    allCategories = await noteServices.getAllCategories();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _categoryController.dispose();
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
            "Create note",
            style: TextStyleClass.appTittleStyle,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: ConstantClass.kcDefultpadH,
                vertical: ConstantClass.kcDefultpadV),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //drop down menu
                      Container(
                       
                        child: widget.isNormal
                            ? DropdownButtonFormField<String>(
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
                                            style: TextStyleClass
                                                .appSubTittleStyle,
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    _selectedCategory = value!;
                                  });
                                },
                                //or create new category
                              )
                            : TextFormField(
                                style: TextStyleClass.appTittleStyle,
                                cursorColor: AppColors.kcTextWhiteColor,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please select a category";
                                  } else {
                                    return null;
                                  }
                                },
                                controller: _categoryController,
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
                                  hintText: "New Category",
                                  hintStyle: TextStyleClass
                                      .appDiscriptionSmallStyle
                                      .copyWith(fontSize: 16),
                                ),
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
                        decoration: InputDecoration(
                            hintText: "Note Title",
                            hintStyle: TextStyleClass.appDiscriptionSmallStyle
                                .copyWith(
                              fontSize: 28,
                            ),
                            border: InputBorder.none),
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
                        decoration: InputDecoration(
                            hintText: "Context",
                            hintStyle: TextStyleClass.appDiscriptionSmallStyle
                                .copyWith(fontSize: 17),
                            border: InputBorder.none),
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
                          //save a new note
                          if (_formKey.currentState!.validate()) {
                            NoteModel note = NoteModel(
                                category: widget.isNormal
                                    ? _selectedCategory
                                    : _categoryController.text,
                                title: _titleController.text,
                                description: _discriptionController.text,
                                dateTime: DateTime.now());

                            noteServices.saveNewNote(note, context);
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
                              "Save Note",
                              style: TextStyleClass.appSubTittleStyle,
                            ),
                          ),
                        ),
                      ),
                      //clear the form
                      GestureDetector(
                        onTap: () {
                          if (widget.isNormal) {

                            _discriptionController.clear();
                            _titleController.clear();
                          } else {
                            _categoryController.clear();
                            _discriptionController.clear();
                            _titleController.clear();
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
                ),
              ],
            ),
          ),
        ));
  }
}
