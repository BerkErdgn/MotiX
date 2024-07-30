import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:motix_app/data/entity/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];
  List<Note> get notes => _notes;

  Future<void> loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? notesJson = prefs.getString('notes');
    if (notesJson != null) {
      Iterable decoded = json.decode(notesJson);
      _notes = decoded.map((item) => Note.fromMap(item)).toList();
      notifyListeners();
    }
  }

  Future<void> saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> notesMapList =
        _notes.map((note) => note.toMap()).toList();
    String notesJson = json.encode(notesMapList);
    await prefs.setString('notes', notesJson);
  }

  void addNote(String title, String subtitle, Color color, String category) {
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
  }

  void updateNote(Note updatedNote) {
    final index = _notes.indexWhere((note) => note.date == updatedNote.date);
    if (index != -1) {
      _notes[index] = updatedNote;
      saveNotes();
      notifyListeners();
    }
  }

  void removeNote(Note note) {
    _notes.removeWhere((n) => n.date == note.date);
    saveNotes();
    notifyListeners();
  }

  void removeAllNotes() {
    _notes.clear();
    saveNotes();
    notifyListeners();
  }
}
