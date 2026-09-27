import 'package:flutter/material.dart';
import 'package:note_sphere/models/notemodel.dart';
import 'package:note_sphere/services/noteservices.dart';

class NoteProvider extends ChangeNotifier {
  final NoteServices _noteServices = NoteServices();

  List<NoteModel> _notes = [];
  List<NoteModel> get notes => _notes;

  List<String> _categories = [];
  List<String> get categories => _categories;

  Future<void> initData() async {
    bool isNew = await _noteServices.isNewUser();
    if (isNew) {
      await _noteServices.saveInitialNotes();
    }
    await loadNotes();
  }

  Future<void> loadNotes() async {
    _notes = await _noteServices.loadNotes();
    _categories = await _noteServices.getAllCategories();
    notifyListeners();
  }

  Future<void> saveNewNote(NoteModel note, BuildContext context) async {
    await _noteServices.saveNewNote(note, context);
    await loadNotes();
  }

  Future<void> updateNote(NoteModel note, BuildContext context) async {
    await _noteServices.updateNote(note, context);
    await loadNotes();
  }

  Future<void> deleteNote(NoteModel note, BuildContext context) async {
    await _noteServices.deleteNote(note, context);
    await loadNotes();
  }

  Map<String, List<NoteModel>> get notesByCategory => _noteServices.getNoteByCategory(_notes);
}
