import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motix_app/util/components/custom_button.dart';
import 'package:motix_app/util/consts/motix_color_consts.dart';
import 'package:motix_app/util/consts/motix_text_consts.dart';

class AddTodoPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddTask;

  const AddTodoPage({Key? key, required this.onAddTask}) : super(key: key);

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final _formKey = GlobalKey<FormState>();

  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startTimeController.text = _formatTime(_startTime);
    _endTimeController.text = _formatTime(_endTime);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    _dateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('HH:mm').format(dateTime);
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _pickTime(TextEditingController controller) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        controller.text = _formatTime(pickedTime);
      });
    }
  }

  Future<void> _submitTask() async {
    if (_formKey.currentState!.validate()) {
      widget.onAddTask({
        'title': _titleController.text,
        'note': _noteController.text,
        'date': _dateController.text,
        'startTime': _startTimeController.text,
        'endTime': _endTimeController.text,
      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    _buildTextField(
                      controller: _titleController,
                      labelText: AddTodoPageStrings.titleLabel,
                      validatorText: AddTodoPageStrings.titleValidator,
                    ),
                    const SizedBox(height: 24),
                    _buildTextField(
                      controller: _noteController,
                      labelText: AddTodoPageStrings.noteLabel,
                      validatorText: AddTodoPageStrings.noteValidator,
                    ),
                    const SizedBox(height: 24),
                    _buildTextField(
                      controller: _dateController,
                      labelText: AddTodoPageStrings.dateLabel,
                      validatorText: AddTodoPageStrings.dateValidator,
                      isReadOnly: true,
                      onTap: _pickDate,
                      icon: Icons.calendar_today,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _startTimeController,
                            labelText: AddTodoPageStrings.startTimeLabel,
                            isReadOnly: true,
                            onTap: () => _pickTime(_startTimeController),
                            icon: Icons.access_time,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            controller: _endTimeController,
                            labelText: AddTodoPageStrings.endTimeLabel,
                            isReadOnly: true,
                            onTap: () => _pickTime(_endTimeController),
                            icon: Icons.access_time,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    _buildSubmitButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 100,
      padding: const EdgeInsets.only(right: 36, top: 16, bottom: 16),
      decoration: BoxDecoration(
        color: MotixColor.mainColorOrange,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.keyboard_backspace_outlined),
              color: MotixColor.mainColorWhite,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                AddTodoPageStrings.addTodo,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: MotixColor.mainColorWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    String? validatorText,
    bool isReadOnly = false,
    Function()? onTap,
    IconData? icon,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: isReadOnly,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: icon != null
            ? Icon(icon, color: MotixColor.mainColorLightGray)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: MotixColor.mainColorOrange),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: MotixColor.mainColorWhite),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorText;
        }
        return null;
      },
    );
  }

  Widget _buildSubmitButton() {
    return CustomButton(
      functionEmailAndPassword: _submitTask,
      buttonText: AddTodoPageStrings.addTaskButton,
      buttonBackgroundColor: MotixColor.mainColorOrange,
      saveButtonTextColor: MotixColor.mainColorWhite,
    );
  }
}
