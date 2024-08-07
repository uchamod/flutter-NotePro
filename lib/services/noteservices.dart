//noteservices
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_sphere/models/notemodel.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/textstyle.dart';
import 'package:uuid/uuid.dart';

class NoteServices {
  //add initial notes that display the user when first time open the app
  //then user can delete intial notes and add new  notes
  List<NoteModel> allNotes = [
    NoteModel(
        id: const Uuid().v4(),
        category: "University",
        title: "Assignment",
        description:
            "network assigment was given by kavidu yakupitiya last week but it's doesn'nt statred yet dead line is 2024/07/17 i think we will be unable to done this bullshit because of lack of knowledge this is bullshit",
        dateTime: DateTime.now()),
    NoteModel(
        id: const Uuid().v4(),
        category: "Work Place",
        title: "Meeting",
        description: "add your note discription here",
        dateTime: DateTime.now()),
    NoteModel(
        id: const Uuid().v4(),
        category: "Home",
        title: "Cleaning",
        description: "add your note discription here",
        dateTime: DateTime.now()),
  ];

  //create reference to the note box
  final _noteBox = Hive.box("notebox");

  //check is user new
  //if notebox empty user is new
  Future<bool> isNewUser() async {
    return _noteBox.isEmpty;
  }

  //method to save initial data in local database if user is new
  Future<void> saveInitialNotes() async {
    if (_noteBox.isEmpty) {
      await _noteBox.put("notes", allNotes);
    }
  }

  //method to load data from local database
  Future<List<NoteModel>> loadNotes() async {
    //get the values
    final dynamic notes = await _noteBox.get("notes");
    if (notes != null && notes is List<dynamic>) {
      return notes.cast<NoteModel>().toList();
    }
    return [];
  }

  //loop through all notes and create object where the key is the caregory and value is the notes in that list
  Map<String, List<NoteModel>> getNoteByCategory(List<NoteModel> allnotes) {
    final Map<String, List<NoteModel>> notes = {};
    for (final note in allnotes) {
      if (notes.containsKey(note.category)) {
        notes[note.category]!.add(note);
      } else {
        notes[note.category] = [note];
      }
    }
    return notes;
  }

  //get the notes according to specific category
  Future<List<NoteModel>> getNotesForGivenCategory(String category) async {
    final dynamic notes = await _noteBox.get("notes");
    List<NoteModel> notesBycategory = [];
    for (final note in notes) {
      if (note.category == category) {
        notesBycategory.add(note);
      }
    }
    return notesBycategory;
  }

  //remove note from local storage
  Future<void> deleteNote(NoteModel note, BuildContext context) async {
    try {
      final dynamic allNotes = await _noteBox.get("notes");
      //get the index
      final int index = allNotes.indexWhere((ele) => ele.id == note.id);
      allNotes.removeAt(index);
      await _noteBox.put("notes", allNotes);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: AppColors.kcCardBlackColor,
            content: Text(
              "Note is deleted succsussfuly",
              style: TextStyleClass.appSubTittleStyle,
            )));
      }
    } catch (err) {
      print(err.toString());
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: AppColors.kcCardBlackColor,
            duration: Duration(seconds: 1),
            content: Text(
              "Something went wrong",
              style: TextStyleClass.appSubTittleStyle,
            )));
      }
    }
  }

  //update current note
  Future<void> updateNote(NoteModel note, BuildContext context) async {
    try {
      final dynamic allNotes = await _noteBox.get("notes");
      //get the index
      final int index = allNotes.indexWhere((ele) => ele.id == note.id);
      allNotes[index] = note;
      await _noteBox.put("notes", allNotes);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: AppColors.kcCardBlackColor,
            duration: Duration(seconds: 1),
            content: Text(
              "Note is updated succsussfuly",
              style: TextStyleClass.appSubTittleStyle,
            )));
      }
    } catch (err) {
      print(err.toString());
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: AppColors.kcCardBlackColor,
            duration: Duration(seconds: 1),
            content: Text(
              "Something went wrong",
              style: TextStyleClass.appSubTittleStyle,
            )));
      }
    }
  }

  
  //get all categories
  Future<List<String>> getAllCategories() async {
    List<String> allCategories = [];
    final dynamic allnotes = await _noteBox.get("notes");
    for (final note in allnotes) {
      if (!allCategories.contains(note.category)) {
        allCategories.add(note.category);
      }
    }
    return allCategories;
  }

  //save a new note
  Future<void> saveNewNote(NoteModel note, BuildContext context) async {
    try {
      final dynamic allNotes = await _noteBox.get("notes");
      allNotes.add(note);
      await _noteBox.put("notes", allNotes);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: AppColors.kcCardBlackColor,
            duration: Duration(seconds: 1),
            content: Text(
              "New Note is added",
              style: TextStyleClass.appSubTittleStyle,
            )));
      }
    } catch (err) {
      print(err.toString());
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: AppColors.kcCardBlackColor,
            duration: Duration(seconds: 1),
            content: Text(
              "Something went wrong",
              style: TextStyleClass.appSubTittleStyle,
            )));
      }
    }
  }
  
}
