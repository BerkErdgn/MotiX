import 'dart:ui';

class Note {
  final String title;
  final String subtitle;
  final DateTime date;
  final Color color;
  final String category;

  Note({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.color,
    required this.category,
  });

  Note copyWith({
    String? title,
    String? subtitle,
    DateTime? date,
    Color? color,
    String? category,
  }) {
    return Note(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      date: date ?? this.date,
      color: color ?? this.color,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'date': date.millisecondsSinceEpoch,
      'color': color.value,
      'category': category,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'],
      subtitle: map['subtitle'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      color: Color(map['color']),
      category: map['category'],
    );
  }
}
