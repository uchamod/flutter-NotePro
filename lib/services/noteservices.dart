//noteservices
import 'package:hive/hive.dart';
import 'package:note_sphere/models/notemodel.dart';
import 'package:uuid/uuid.dart';

class NoteServices {
  //add initial notes that display the user when first time open the app
  //then user can delete intial notes and add new  notes
  List<NoteModel> allNotes = [
    NoteModel(
        id: const Uuid().v4(),
        category: "University",
        title: "Assignment",
        description: "add your note discription here",
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
}
