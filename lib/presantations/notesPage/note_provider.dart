import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:motix_app/data/entity/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  Future<void> loadNotes() async {
    // To upload notes,
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? notesJson = prefs.getString('notes');
    if (notesJson != null) {
      Iterable decoded = json.decode(notesJson);
      _notes = decoded.map((item) => Note.fromMap(item)).toList();
      notifyListeners();
    }
  } // end Future loadNotes

  Future<void> saveNotes() async {
    // to save notes,
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> notesMapList =
        _notes.map((note) => note.toMap()).toList();
    String notesJson = json.encode(notesMapList);
    await prefs.setString('notes', notesJson);
  } // end Future saveNotes

  void addNote(String title, String subtitle, Color color, String category) {
    // to add note,
    final note = Note(
      title: title,
      subtitle: subtitle,
      date: DateTime.now(),
      color: color,
      category: category,
    );
    _notes.insert(0, note);
    saveNotes();
    notifyListeners();
  } // end void addNote

  void updateNote(Note updatedNote) {
    //to save the changes the user made to the note
    final index = _notes.indexWhere((note) => note.date == updatedNote.date);
    if (index != -1) {
      _notes[index] = updatedNote;
      saveNotes();
      notifyListeners();
    }
  } // end void updateNote

  void removeNote(Note note) {
    //to delete the note
    _notes.removeWhere((n) => n.date == note.date);
    saveNotes();
    notifyListeners();
  } // end void removeNote

  void removeAllNotes() {
    // To delete all notes
    _notes.clear();
    saveNotes();
    notifyListeners();
  } // end void removeAllNotes
} // end class NoteProvider
