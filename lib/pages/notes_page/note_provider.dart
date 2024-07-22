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
  int _colorIndex = 0;

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

  void addNote(String title, String subtitle) {
    final colors = [Color(0xFFFC9149), Color(0xFFB9FF69), Color(0xFF8BCEFA)];
    final color = colors[_colorIndex % colors.length];
    _colorIndex++;

    final note = Note(
      title: title,
      subtitle: subtitle,
      date: DateTime.now(),
      color: color,
    );
    _notes.add(note);
    saveNotes();
    notifyListeners();
  }
}
