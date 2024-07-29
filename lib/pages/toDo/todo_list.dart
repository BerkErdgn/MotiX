import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({
    Key? key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    required this.editFunction,
    required this.date,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  final String taskName;
  final bool taskCompleted;
  final ValueChanged<bool?>? onChanged;
  final Function(BuildContext)? deleteFunction;
  final Function(BuildContext, String)? editFunction;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late bool _taskCompleted;

  @override
  void initState() {
    super.initState();
    _taskCompleted = widget.taskCompleted;
  }

  void _handleCheckboxChange(bool? value) {
    setState(() {
      _taskCompleted = value ?? false;
    });
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: TodoItemPadding.itemPadding,
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: widget.deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(15),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Color(0xFFCDE8E5),
                title: const Text(
                  'Task Details',
                  style: TextStyle(color: Colors.black),
                ),
                content: TodoItemDialog(
                  taskCompleted: _taskCompleted,
                  onChanged: _handleCheckboxChange,
                  taskName: widget.taskName,
                  date: widget.date,
                  startTime: widget.startTime,
                  endTime: widget.endTime,
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Kapat',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            );
          },
          child: TodoItemContainer(
            taskCompleted: _taskCompleted,
            onChanged: _handleCheckboxChange,
            taskName: widget.taskName,
            editFunction: widget.editFunction,
            date: widget.date,
            startTime: widget.startTime,
            endTime: widget.endTime,
          ),
        ),
      ),
    );
  }
}

class TodoItemContainer extends StatelessWidget {
  const TodoItemContainer({
    Key? key,
    required this.taskCompleted,
    required this.onChanged,
    required this.taskName,
    required this.editFunction,
    required this.date,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  final bool taskCompleted;
  final ValueChanged<bool?>? onChanged;
  final String taskName;
  final Function(BuildContext, String)? editFunction;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: TodoItemPadding.containerPadding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Checkbox(
            value: taskCompleted,
            onChanged: onChanged,
          ),
          Expanded(
            child: Text(
              taskName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                decoration: taskCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationColor: Colors.black,
                decorationThickness: 2,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat('dd-MM-yyyy').format(date),
                style: const TextStyle(color: Colors.black),
              ),
              Text(
                '${startTime.format(context)} - ${endTime.format(context)}',
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TodoItemDialog extends StatefulWidget {
  const TodoItemDialog({
    Key? key,
    required this.taskCompleted,
    required this.onChanged,
    required this.taskName,
    required this.date,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  final bool taskCompleted;
  final ValueChanged<bool?>? onChanged;
  final String taskName;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  @override
  _TodoItemDialogState createState() => _TodoItemDialogState();
}

class _TodoItemDialogState extends State<TodoItemDialog> {
  late bool _taskCompleted;

  @override
  void initState() {
    super.initState();
    _taskCompleted = widget.taskCompleted;
  }

  void _handleCheckboxChange(bool? value) {
    setState(() {
      _taskCompleted = value ?? false;
    });
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Checkbox(
              value: _taskCompleted,
              onChanged: _handleCheckboxChange,
            ),
            Expanded(
              child: Text(
                widget.taskName,
                style: TextStyle(
                  decoration:
                      _taskCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          DateFormat('dd-MM-yyyy').format(widget.date),
          style: const TextStyle(color: Colors.black),
        ),
        Text(
          '${widget.startTime.format(context)} - ${widget.endTime.format(context)}',
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}

class TodoItemPadding {
  static const EdgeInsets itemPadding = EdgeInsets.symmetric(vertical: 5.0);
  static const EdgeInsets containerPadding = EdgeInsets.all(15.0);
}
