import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motix_app/data/entity/note.dart';
import 'package:motix_app/util/consts/motix_color_consts.dart';
import 'package:motix_app/util/consts/motix_text_consts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'note_provider.dart';

class AddNotePage extends StatefulWidget {
  final Note? note;

  AddNotePage({this.note});

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  Color _currentColor = MotixColor.mainColorLightGray;
  String? _selectedCategory;

  final List<String> _categories = [
    NotesStrings.workCategory,
    NotesStrings.personalCategory,
    NotesStrings.studyCategory,
    NotesStrings.sportsCategory
  ];

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _noteController.text = widget.note!.subtitle;
      _currentColor = widget.note!.color;
      _selectedCategory = widget.note!.category;
    } else {
      _selectedCategory = _categories[0];
    }
  }

  void _pickColor() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(NoteAddStrings.pickColorLabel),
        content: BlockPicker(
          pickerColor: _currentColor,
          onColorChanged: (color) {
            setState(() {
              _currentColor = color;
            });
          },
        ),
        actions: [
          TextButton(
            child: Text(NoteAddStrings.okButtonText),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null
            ? NoteAddStrings.newNoteTitle
            : NoteAddStrings.editNoteTitle),
        actions: [
          if (widget.note != null)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                final provider = context.read<NoteProvider>();
                provider.removeNote(widget.note!);
                Navigator.pop(context);
              },
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0), //
            child: Column(
              children: [
                TextField(
                  maxLines: null,
                  style: const TextStyle(fontSize: 24),
                  controller: _titleController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: NoteAddStrings.titleHintText,
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  items: _categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: NoteAddStrings.categoryLabel,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                    constraints: const BoxConstraints(minHeight: 185),
                    child: Card(
                      color: _currentColor,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 60),
                                  child: TextField(
                                    style: TextStyle(color: MotixColor.mainColorDarkGrey),
                                    maxLines: null,
                                    controller: _noteController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: NoteAddStrings.noteHintText,
                                      hintStyle: TextStyle(
                                        color: MotixColor.mainColorDarkGrey,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.color_lens,
                                      color: MotixColor.mainColorOrange,
                                      size: 34,
                                    ),
                                    onPressed: _pickColor,
                                  ),
                                  Text(
                                    "${DateFormat('dd MMMM yyyy', 'tr_TR').format(DateTime.now())}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: MotixColor.mainColorDarkGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      final title = _titleController.text;
                      final subtitle = _noteController.text;

                      if (widget.note == null) {
                        context.read<NoteProvider>().addNote(
                              title,
                              subtitle,
                              _currentColor,
                              _selectedCategory ?? 'Others',
                            );
                      } else {
                        context.read<NoteProvider>().updateNote(
                              widget.note!.copyWith(
                                title: title,
                                subtitle: subtitle,
                                color: _currentColor,
                                category: _selectedCategory ?? 'Others',
                              ),
                            );
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(NoteAddStrings.noteSavedMessage),
                        ),
                      );

                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MotixColor.mainColorGrey,
                    ),
                    child: const Text(
                      NoteAddStrings.saveButtonText,
                      style: TextStyle(
                          color: MotixColor.mainColorDarkGrey, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}