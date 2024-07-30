import 'package:flutter/material.dart';
import 'package:motix_app/util/consts/motix_text_consts.dart'; 

class EditTodoPage extends StatefulWidget {
  const EditTodoPage({
    Key? key,
    required this.initialTaskName,
  }) : super(key: key);

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
    Navigator.pop(
      context,
      _controller.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          EditTodoPageStrings.appBarTitle,
          style: TextStyle(
            color: Color(0xFFFAF8ED),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFAF8ED)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controller,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFAF8ED),
                  ),
                  decoration: InputDecoration(
                    hintText: EditTodoPageStrings.hintText,
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
          Positioned(
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
            child: ElevatedButton(
              onPressed: _saveEdit,
              child: Text(
                EditTodoPageStrings.saveButton,
                style: TextStyle(color: Color(0xFFFAF8ED), fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFED7D31),
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
