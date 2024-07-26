import 'package:flutter/material.dart';

class EditTodoPage extends StatefulWidget {
  const EditTodoPage({Key? key, required this.initialTaskName}) : super(key: key);

  final String initialTaskName;

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialTaskName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveEdit() {
    Navigator.pop(context, _controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Görevi Düzenle'),
        actions: [
          IconButton(
            onPressed: _saveEdit,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'Görev Başlığı',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
