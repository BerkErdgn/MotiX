import 'package:flutter/material.dart';
import 'package:motix_app/pages/toDo/todo_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _controller = TextEditingController();
  List<List<dynamic>> _toDoList = [];

  @override
  void initState() {
    super.initState();
    _loadToDoList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadToDoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? toDoListString = prefs.getString('toDoList');
    if (toDoListString != null) {
      setState(() {
        _toDoList = List<List<dynamic>>.from(json.decode(toDoListString));
      });
    }
  }

  Future<void> _saveToDoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('toDoList', json.encode(_toDoList));
  }

  void _checkBoxChanged(int index, bool? value) {
    setState(() {
      _toDoList[index][1] = value ?? false;
    });
    _saveToDoList();
  }

  void _saveNewTask() {
    if (_controller.text.trim().isEmpty) {
      _showSnackbar('Lütfen bir görev girin.');
      return;
    }

    setState(() {
      _toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    _saveToDoList();
  }

  void _deleteTask(int index) {
    setState(() {
      _toDoList.removeAt(index);
    });
    _saveToDoList();
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 21, 21, 21),
        content: Text(message,
            style: const TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: _toDoList.isEmpty
                    ? const Center(
                        child: Text(
                        'Henüz yapılacak bir görev eklenmedi.',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ))
                    : ListView.builder(
                        itemCount: _toDoList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TodoItem(
                            deleteFunction: (context) => _deleteTask(index),
                            taskName: _toDoList[index][0],
                            taskCompleted: _toDoList[index][1],
                            onChanged: (value) =>
                                _checkBoxChanged(index, value),
                          );
                        },
                      ),
              ),
              SizedBox(height: 70),
            ],
          ),
          Positioned(
            left: 30,
            right: 90,
            bottom: 20,
            child: TextField(
              controller: _controller, 
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Yeni not ekle',
                hintStyle: const TextStyle(color: Colors.black38),
                fillColor: const Color(0xFFFFFBF5),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton(
              backgroundColor: Color(0xFFD4FAFC),
              onPressed: _saveNewTask,
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
