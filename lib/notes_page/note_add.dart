import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'note_provider.dart';

class AddNotePage extends StatelessWidget {
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Not Ekleyin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Başlık'),
            ),
            TextField(
              controller: _subtitleController,
              decoration: InputDecoration(labelText: 'Alt başlık'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text;
                final subtitle = _subtitleController.text;
                context.read<NoteProvider>().addNote(title, subtitle);
                Navigator.of(context).pop();
              },
              child: Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}
