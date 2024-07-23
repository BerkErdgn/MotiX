import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Note {
  final String title;
  final String subtitle;
  final DateTime date;
  final Color color;

  Note({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.color,
  });

  Note copyWith({
    String? title,
    String? subtitle,
    DateTime? date,
    Color? color,
  }) {
    return Note(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      date: date ?? this.date,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'date': date.millisecondsSinceEpoch,
      'color': color.value,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'],
      subtitle: map['subtitle'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      color: Color(map['color']),
    );
  }
}

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

  void addNote(String title, String subtitle, Color color) {
    final note = Note(
      title: title,
      subtitle: subtitle,
      date: DateTime.now(),
      color: color,
    );
    _notes.insert(0,note);
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
