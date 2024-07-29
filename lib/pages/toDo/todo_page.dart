import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:motix_app/pages/toDo/todo_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:lottie/lottie.dart';  // Lottie paketini import edin
import 'add_todo_page.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _tasks = [];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('tr_TR', null);
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
        _tasks = List<Map<String, dynamic>>.from(json.decode(toDoListString));
      });
    }
  }

  Future<void> _saveToDoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('toDoList', json.encode(_tasks));
  }

  void _addTask(Map<String, dynamic> task) {
    setState(() {
      _tasks.add(task);
    });
    _saveToDoList();
    _showSnackbar('Görev başarıyla eklendi!');
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
    _saveToDoList();
  }

  void _toggleTaskComplete(int index, bool? value) {
    setState(() {
      _tasks[index]['completed'] = value ?? false;
    });
    _saveToDoList();
  }

  void _editTask(int index, String newTaskName) {
    setState(() {
      _tasks[index]['title'] = newTaskName;
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

  void _navigateToAddTodoPage() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => AddTodoPage(
          onAddTask: (task) {
            _addTask(task);
          },
        ),
      ),
    );

    if (result != null) {
      _addTask(result);
    }
  }

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 6 && hour < 12) {
      return 'Günaydın';
    } else if (hour >= 12 && hour < 18) {
      return 'İyi Günler';
    } else if (hour >= 18 && hour < 24) {
      return 'İyi Akşamlar';
    } else {
      return 'İyi Geceler';
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedDateFormatted = DateFormat('yyyy-MM-dd').format(_selectedDate);

    List<Map<String, dynamic>> filteredTasks = _tasks
        .where((task) {
          final taskDate = task['date'] as String?;
          return taskDate != null && taskDate == selectedDateFormatted;
        })
        .toList();

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 35),
          Container(
            height: 120,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFED7D31),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Center(
                      child: Text(
                        getGreeting(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _navigateToAddTodoPage,
                  icon: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ),
          DatePicker(
            DateTime.now(),
            height: 100,
            width: 80,
            initialSelectedDate: DateTime.now(),
            selectionColor: const Color(0xFF6EACDA),
            selectedTextColor: Colors.white,
            dateTextStyle: TextStyle(color: Colors.white),
            dayTextStyle: TextStyle(color: Colors.white),
            monthTextStyle: TextStyle(color: Colors.white),
            locale: 'tr_TR',
            onDateChange: (date) {
              setState(() {
                _selectedDate = date;
              });
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: filteredTasks.isEmpty
                ? Column(
                  children: [
                    Center(
                        child: Lottie.asset(
                          'assets/animations/lottie3.json',
                          width: 300,
                          height: 300,
                          fit: BoxFit.fill,
                        ),
                      ),
                    Text('Görev Ekle')
                  ],
                )
                : ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      final taskName = task['title'] as String;
                      final taskCompleted = task['completed'] as bool? ?? false;
                      final taskDate = DateTime.parse(task['date']);
                      final startTimeString = task['startTime'] as String;
                      final endTimeString = task['endTime'] as String;

                      final startTime = TimeOfDay(
                        hour: int.parse(startTimeString.split(':')[0]),
                        minute: int.parse(startTimeString.split(':')[1]),
                      );
                      final endTime = TimeOfDay(
                        hour: int.parse(endTimeString.split(':')[0]),
                        minute: int.parse(endTimeString.split(':')[1]),
                      );

                      return TodoItem(
                        taskName: taskName,
                        taskCompleted: taskCompleted,
                        onChanged: (value) =>
                            _toggleTaskComplete(index, value),
                        deleteFunction: (context) => _deleteTask(index),
                        editFunction: (context, newTaskName) =>
                            _editTask(index, newTaskName),
                        date: taskDate,
                        startTime: startTime,
                        endTime: endTime,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
