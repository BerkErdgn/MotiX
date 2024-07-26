import 'dart:convert';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:motix_app/pages/toDo/todo_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  void _addTask(String title) {
    setState(() {
      _tasks.add({
        'title': title,
        'completed': false,
        'date': DateFormat('yyyy-MM-dd').format(_selectedDate),
      });
      _controller.clear();
    });
    _saveToDoList();
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
            setState(() {
              _tasks.add(task);
              _saveToDoList();
            });
            _showSnackbar('Görev başarıyla eklendi!');
          },
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _tasks.add(result);
        _saveToDoList();
      });
    }
  }

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Günaydın';
    } else if (hour < 18) {
      return 'İyi Günler';
    } else {
      return 'İyi Akşamlar';
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedDateFormatted = DateFormat('dd-MM-yyyy').format(_selectedDate);

    List<Map<String, dynamic>> filteredTasks = _tasks
        .where((task) {
          final taskDate = task['date'] as String?;
          return taskDate != null && taskDate == selectedDateFormatted;
        })
        .toList();

    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          _buildDatePicker(),
          _buildTaskList(filteredTasks),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 140,
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
    );
  }

  Widget _buildDatePicker() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: 100,
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: _selectedDate,
        selectionColor: Colors.blue.shade300,
        locale: 'tr',
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
        dateTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        dayTextStyle: const TextStyle(color: Colors.white),
        monthTextStyle: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildTaskList(List<Map<String, dynamic>> tasks) {
    return Expanded(
      child: tasks.isEmpty
          ? const Center(
              child: Text(
              'Henüz yapılacak bir görev eklenmedi.',
              style: TextStyle(fontSize: 16),
            ))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TodoItem(
                  taskName: tasks[index]['title'],
                  taskCompleted: tasks[index]['completed'] ?? false,
                  onChanged: (bool? value) {
                    _toggleTaskComplete(index, value);
                  },
                  deleteFunction: (BuildContext context) {
                    _deleteTask(index);
                  },
                  editFunction: (BuildContext context, String newTaskName) {
                    _editTask(index, newTaskName);
                  },
                );
              },
            ),
    );
  }
}
